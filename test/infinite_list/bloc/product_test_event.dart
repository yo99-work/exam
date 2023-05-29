
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductEvent', () {
    group('ProductFetched', () {
      test('supports value comparison', () {
        expect(ProductFetched(), ProductFetched());
      });
    });
  });
}
