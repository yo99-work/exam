import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ProductState', () {
    test('supports value comparison', () {
      expect(const ProductState(), const ProductState());
      expect(
        const ProductState().toString(),
        const ProductState().toString(),
      );
    });
  });
}
