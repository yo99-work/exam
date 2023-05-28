import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_test_event.dart';
part 'product_test_state.dart';

class ProductTestBloc extends Bloc<ProductTestEvent, ProductTestState> {
  ProductTestBloc() : super(ProductTestInitial()) {
    on<ProductTestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}