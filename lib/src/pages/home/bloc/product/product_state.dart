part of 'product_bloc.dart';
enum LazyLoadStatus { initial, success, failure }

final class ProductState extends Equatable {
  const ProductState({
    this.status = LazyLoadStatus.initial,
    this.products = const <Product>[],
    this.hasReachedMax = false,
});

  final LazyLoadStatus status;
  final List<Product> products;
  final bool hasReachedMax;

  ProductState copyWith({
    LazyLoadStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return ProductState(
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
