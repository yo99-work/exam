part of 'flash_sale_product_bloc.dart';


sealed class FlashSaleProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FlashSaleProductFetched extends FlashSaleProductEvent {}
