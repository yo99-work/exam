part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CartFetched extends CartEvent {
  final String userId;
  CartFetched(this.userId);

  @override
  List<Object> get props => [userId];
}

final class AddToCart extends CartEvent {
  final Product product;
  final String userId;
  AddToCart(this.product, this.userId);

  @override
  List<Object> get props => [product, userId];

}

final class RemoveFromCart extends CartEvent {
  final Product product;
  final String userId;
  RemoveFromCart(this.product, this.userId);

  @override
  List<Object> get props => [product, userId];
}

final class ClearCart extends CartEvent {
  final String userId;
  ClearCart(this.userId);

  @override
  List<Object> get props => [userId];
}
