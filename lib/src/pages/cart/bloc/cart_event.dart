part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CartFetched extends CartEvent {}

final class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);

  List<Object> get props => [product];

}
final class RemoveFromCart extends CartEvent {}
final class UpdateToCart extends CartEvent {}