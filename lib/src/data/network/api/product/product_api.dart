import 'package:dio/dio.dart';

import '../../dio_client.dart';


class ProductApi {
  final DioClient dioClient;

  ProductApi({required this.dioClient});

  Future<Response> getProduct(int limit) async {
    try {
      final Response response = await dioClient.get(
        "/product",
        queryParameters: {
          'limit': limit,
          'skip': limit,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<Response> getFlashSaleProduct(int limit) async {
    try {
      final Response response = await dioClient.get(
        "/product",
        queryParameters: {
          'limit': limit,
          'skip': limit,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }




}