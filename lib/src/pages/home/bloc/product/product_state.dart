part of 'product_bloc.dart';
enum PostStatus { initial, success, failure }

final class ProductState extends Equatable {
  const ProductState({
    this.status = PostStatus.initial,
    this.posts = const <Product>[],
    this.hasReachedMax = false,
});

  final PostStatus status;
  final List<Product> posts;
  final bool hasReachedMax;

  ProductState copyWith({
    PostStatus? status,
    List<Product>? posts,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, products: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
