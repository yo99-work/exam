

import 'package:exam/src/data/network/api/cart/cart_api.dart';
import '../model/product/product.dart';

class CartRepository {
  final CartApi cartApi;

  CartRepository({ required this.cartApi});

  Future<List<Product>> getProducts(String userId) async {
    try {
      final response = await cartApi.readDataFromCollection(userId);
      return response;
    } catch (e){
      throw e;
    }
  }

  Future<void> addProduct(Product product, String userId) async {
    try {
      await cartApi.createData(product, userId);
    } catch (e){
      throw e;
    }
  }

  Future<void> removeProduct(Product product, String userId) async {
    try {
      await cartApi.removeData(product, userId);
    } catch (e){
      throw e;
    }
  }

  Future<void> clearCart(String userId) async {
    try {
      await cartApi.removeAll(userId);
    } catch (e){
      throw e;
    }
  }
}