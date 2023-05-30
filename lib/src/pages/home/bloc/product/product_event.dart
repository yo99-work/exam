part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductFetched extends ProductEvent {
  final int limit;
  ProductFetched(this.limit);

  @override
  List<Object> get props => [limit];
}

