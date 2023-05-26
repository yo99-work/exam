

import 'package:exam/src/data/network/api/cart/cart_api.dart';
import '../model/product/product.dart';

class CartRepository {
  final CartApi cartApi;

  CartRepository({ required this.cartApi});

  Future<List<Product>> getProducts() async {
    try {
      final response = await cartApi.readDataFromCollection();
      return response;
    } catch (e){
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await cartApi.createData(product);
      print("ADD success ${response}");
    } catch (e){
      throw e;
    }
  }
}