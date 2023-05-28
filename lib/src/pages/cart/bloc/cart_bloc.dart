import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/repository/cart_repository.dart';

import '../../../data/model/product/product.dart';
import '../../../di/service_locator.dart';
import '../../home/bloc/product/product_bloc.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final cartRepository = getIt.get<CartRepository>();
  final throttleDuration = const Duration(milliseconds: 100);

  CartBloc() : super(const CartState()) {
      on<CartFetched>(
        _onCartFetch,
        transformer: throttleDroppable(throttleDuration),
      );

    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);

  }

  Future<void> _onCartFetch(
      CartFetched event,
    Emitter<CartState> emit,
  ) async {
    try {
      List<Product> products = await cartRepository.getProducts(event.userId);

      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          products: products,
          hasReachedMax: false));

    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure, products: []));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await cartRepository.addProduct(event.product, event.userId);
      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          hasReachedMax: false));

    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event,
      Emitter<CartState> emit,
      ) async {

    try {
      await cartRepository.removeProduct(event.product, event.userId);
      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          hasReachedMax: false));

    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }

  Future<void> _onClearCart(
      ClearCart event,
      Emitter<CartState> emit,
      ) async {

    try {
      await cartRepository.clearCart(event.userId);
      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          hasReachedMax: false));

    } catch (e) {
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }
}
