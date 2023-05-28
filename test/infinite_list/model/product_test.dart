import 'package:exam/src/data/model/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product', () {
    test('supports value comparison', () {
      expect(
        Product(1, "title", "description", 10, 10, 1, 10, "brand", "category", "thumbnail", const []),
        Product(1, "title", "description", 10, 10, 1, 10, "brand", "category", "thumbnail", const []),
      );
    });
  });
}
