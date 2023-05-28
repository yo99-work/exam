part of 'cart_bloc.dart';

final class CartState extends Equatable {
  const CartState({
    this.status = LazyLoadStatus.initial,
    this.products = const <Product>[],
    this.hasReachedMax = false,
  });

  final LazyLoadStatus status;
  final List<Product> products;
  final bool hasReachedMax;

  CartState copyWith({
    LazyLoadStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return CartState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
