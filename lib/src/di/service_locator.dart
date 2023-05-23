import 'package:dio/dio.dart';
import 'package:exam/src/data/repository/product_repository.dart';

import '../data/network/api/product/product_api.dart';
import '../data/network/dio_client.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;
Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  //Product api
  getIt.registerSingleton(ProductApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ProductRepository(getIt.get<ProductApi>()));


  //Cart api

  // getIt.registerSingleton(HomeController());
}
