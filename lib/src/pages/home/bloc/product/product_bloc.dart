import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/repository/product_repository.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../data/model/product/product.dart';
import '../../../../di/service_locator.dart';

part 'product_event.dart';

part 'product_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final productRepository = getIt.get<ProductRepository>();
  final throttleDuration = const Duration(milliseconds: 100);

  ProductBloc() : super(const ProductState()) {
    on<ProductFetched>(
      _onProductFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onProductFetched(
    ProductFetched event,
    Emitter<ProductState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == LazyLoadStatus.initial) {
        final products = await productRepository.getProduct(event.limit, state.products.length);
        final updateProducts = products.map((item) {
          item.autoGenerateTag();
          return item;
        }).toList();

        emit(state.copyWith(
            status: LazyLoadStatus.success,
            products: updateProducts,
            hasReachedMax: false));
      }else {
        final products = await productRepository.getProduct(
            event.limit, state.products.length);

        final updateProducts = products.map((item) {
          item.autoGenerateTag();
          return item;
        }).toList();

        products.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
          state.copyWith(
            status: LazyLoadStatus.success,
            products: List.of(state.products)
              ..addAll(updateProducts),
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }
}
