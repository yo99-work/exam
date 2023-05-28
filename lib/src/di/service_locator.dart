import 'package:dio/dio.dart';
import 'package:exam/src/data/cache/share_preference.dart';
import 'package:exam/src/data/network/api/cart/cart_api.dart';
import 'package:exam/src/data/repository/authen_repository.dart';
import 'package:exam/src/data/repository/cart_repository.dart';
import 'package:exam/src/data/repository/product_repository.dart';
import 'package:get_it/get_it.dart';
import '../data/network/api/product/product_api.dart';
import '../data/network/dio_client.dart';
import '../pages/home/bloc/product/product_bloc.dart';


final getIt = GetIt.instance;
Future<void> setupDi() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(SharedPref());

  //Authen api
  getIt.registerSingleton(AuthenRepository());

  //Product api
  getIt.registerSingleton(ProductApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ProductRepository(getIt.get<ProductApi>()));



  //Cart api
  getIt.registerSingleton(CartApi());
  getIt.registerSingleton(CartRepository(cartApi: getIt<CartApi>()));

  getIt.registerSingleton(ProductBloc());
}

