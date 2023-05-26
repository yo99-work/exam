import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam/src/data/repository/cart_repository.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product/product.dart';
import '../../../di/service_locator.dart';
import '../../home/bloc/product/product_bloc.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final cartRepository = getIt.get<CartRepository>();
  final int _productLimit = 20;
  final throttleDuration = const Duration(milliseconds: 100);

  CartBloc() : super(const CartState()) {
      on<CartFetched>(
        _onCartFetch,
        transformer: throttleDroppable(throttleDuration),
      );

    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onCartFetch(
    CartEvent event,
    Emitter<CartState> emit,
  ) async {
    // if (state.hasReachedMax) return;
    try {
      List<Product> products = await cartRepository.getProducts();

      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          products: products,
          hasReachedMax: false));

      if (state.status == LazyLoadStatus.initial) {
        //example
        // final updateProducts = products.map((item) {
        //   item.setIsFlashSale();
        //   item.autoGenerateTag();
        //   return item;
        // }).toList();


      }
    } catch (e) {
      print("Error $e");
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await cartRepository.addProduct(event.product);
      List<Product> currentProduct = List<Product>.from(state.products);
      currentProduct.add(event.product);
      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          products: currentProduct,
          hasReachedMax: true));

    } catch (e) {
      print("Error $e");
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }

  Future<void> _onRemoveFromCart(
      AddToCart event,
      Emitter<CartState> emit,
      ) async {
    try {
      await cartRepository.addProduct(event.product);
      List<Product> currentProduct = state.products;

      currentProduct.add(event.product);
      return emit(state.copyWith(
          status: LazyLoadStatus.success,
          products: currentProduct,
          hasReachedMax: true));

    } catch (e) {
      print("Error $e");
      emit(state.copyWith(status: LazyLoadStatus.failure));
    }
  }
}
