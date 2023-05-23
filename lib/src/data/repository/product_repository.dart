import 'package:dio/dio.dart';

import '../model/product/product.dart';
import '../network/api/product/product_api.dart';
import '../network/dio_exception.dart';


class ProductRepository {
  final ProductApi productApi;

  ProductRepository(this.productApi);

  Future<List<Product>> getProduct(int limit, int skip) async {
    try {
      final response = await productApi.getProduct(limit, skip);
      final users = (response.data['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return users;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }


}