import 'package:exam/src/data/model/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Converts integer price to human-readable format', () {
    // Arrange
    int price = 1234567;
    String expectedOutput = '\$1,234,567';

    //
    String result = Product.convertToHuman(price);

    // Assert
    expect(result, expectedOutput);
  });


  test('Calculates price by quantity correctly', () {
    // Arrange
    Product product = Product(
      0,
      "title",
      "description",
      5,
      0,
      0,
      0,
      "brand",
      "category",
      "thumbnail",
      [],
    );
    product.quantity = 5;

    int expectedOutput = 25;

    // Act
    int result = product.getPriceByQuantity();
    // Assert
    expect(result, expectedOutput);
  });
}