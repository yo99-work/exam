// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:exam/src/data/cache/share_preference.dart';
import 'package:exam/src/data/network/api/product/product_api.dart';
import 'package:exam/src/data/network/dio_client.dart';
import 'package:exam/src/data/repository/product_repository.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(SharedPref());


  //Product api
  getIt.registerSingleton(ProductApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ProductRepository(getIt.get<ProductApi>()));

  //Authen api
  // getIt.registerSingleton(AuthenRepository());


  //Cart api
  // getIt.registerSingleton(CartApi());
  // getIt.registerSingleton(CartRepository(cartApi: getIt<CartApi>()));
  //
  getIt.registerSingleton(ProductBloc());
}

void main() {

}
