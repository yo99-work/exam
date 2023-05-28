part of 'product_test_bloc.dart';


void main() {
  group('ProductState', () {
    test('supports value comparison', () {
      expect(ProductState(), ProductState());
      expect(
        ProductState().toString(),
        ProductState().toString(),
      );
    });
  });
}
