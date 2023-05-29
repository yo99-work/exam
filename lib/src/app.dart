import 'package:exam/src/pages/cart/bloc/cart_bloc.dart';
import 'package:exam/src/pages/home/bloc/flash_sale_product/flash_sale_product_bloc.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:exam/src/pages/login/bloc/login_cubit.dart';
import 'package:exam/src/pages/main/main_page.dart';
import 'package:exam/src/pages/notification/bloc/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'app_route.dart';
import 'bloc/app_bloc.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class App extends StatelessWidget {
  const App({super.key});



  @override
  Widget build(BuildContext context) {

    final appBloc = BlocProvider<AppBloc>(create: (context) => AppBloc());
    final loginCubit = BlocProvider<LoginCubit>(create: (context) => LoginCubit());
    final cartBloc = BlocProvider<CartBloc>(create: (context) => CartBloc());
    final notificationBloc = BlocProvider<NotificationBloc>(create: (context) => NotificationBloc());

    final productBloc = BlocProvider<ProductBloc>(create: (context) => ProductBloc());
    final flashSaleProductBloc = BlocProvider<FlashSaleProductBloc>(create: (context) => FlashSaleProductBloc());


    return MultiBlocProvider(
      providers: [appBloc, loginCubit, cartBloc, notificationBloc, productBloc, flashSaleProductBloc],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exam',
        routes: AppRoute().getAll,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainPage(),

      ),
    );
  }



}
