import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'flash_sale_product_event.dart';
part 'flash_sale_product_state.dart';

class FlashSaleProductBloc extends Bloc<FlashSaleProductEvent, FlashSaleProductState> {
  FlashSaleProductBloc() : super(FlashSaleProductInitial()) {
    on<FlashSaleProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
