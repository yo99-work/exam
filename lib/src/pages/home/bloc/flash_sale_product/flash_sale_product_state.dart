part of 'flash_sale_product_bloc.dart';

final class FlashSaleProductState extends Equatable {
  const FlashSaleProductState({
    this.status = LazyLoadStatus.initial,
    this.products = const <Product>[],
    this.hasReachedMax = false,
  });

  final LazyLoadStatus status;
  final List<Product> products;
  final bool hasReachedMax;

  FlashSaleProductState copyWith({
    LazyLoadStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return FlashSaleProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''FlashSaleState { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
