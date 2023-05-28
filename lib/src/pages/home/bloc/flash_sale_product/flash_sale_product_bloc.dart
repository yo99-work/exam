import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';

import '../../../../data/model/product/product.dart';
import '../../../../data/repository/product_repository.dart';
import '../../../../di/service_locator.dart';

part 'flash_sale_product_event.dart';

part 'flash_sale_product_state.dart';

class FlashSaleProductBloc
    extends Bloc<FlashSaleProductEvent, FlashSaleProductState> {
  final productRepository = getIt.get<ProductRepository>();
  final throttleDuration = const Duration(milliseconds: 100);

  FlashSaleProductBloc() : super(const FlashSaleProductState()) {
    if (!state.hasReachedMax) {
      on<FlashSaleProductFetched>(


      _onFlashSaleProductFetched,
      transformer: throttleDroppable(throttleDuration),
      );
    }
  }

  Future<void> _onFlashSaleProductFetched(
    FlashSaleProductEvent event,
    Emitter<FlashSaleProductState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == LazyLoadStatus.initial) {
        //example
        List<Product> products = await productRepository.getFlashSale(20, 40);
        final updateProducts = products.map((item) {
          item.setIsFlashSale();
          item.autoGenerateTag();
          return item;
        }).toList();

        return emit(state.copyWith(
            status: LazyLoadStatus.success,
            products: updateProducts,
            hasReachedMax: true));
      }
    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }
}
