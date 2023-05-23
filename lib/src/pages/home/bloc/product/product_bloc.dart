import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/network/api/product/product_api.dart';
import 'package:exam/src/data/repository/product_repository.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../app.dart';
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
  // final test = getIt.get<ProductApi>();
  final productRepository = getIt.get<ProductRepository>();
  final int _productLimit = 20;
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
      if (state.status == ProductStatus.initial) {
        final products = await productRepository.getProduct(_productLimit, state.products.length);
        return emit(state.copyWith(
            status: ProductStatus.success,
            products: products,
            hasReachedMax: false));
      }else {
        final products = await productRepository.getProduct(
            _productLimit, state.products.length);
        products.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
          state.copyWith(
            status: ProductStatus.success,
            products: List.of(state.products)
              ..addAll(products),
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      print("Error $e");
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }
}
