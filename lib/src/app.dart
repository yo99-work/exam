import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'app_route.dart';
import 'bloc/counter_a_bloc/counter_a_bloc.dart';
import 'pages/home/home_page.dart';
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

    final counterABloc = BlocProvider<CounterABloc>(create: (context) => CounterABloc());
    final productBloc = BlocProvider<ProductBloc>(create: (context) => ProductBloc());

    return MultiBlocProvider(
      providers: [counterABloc, productBloc],
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Exam',
        routes: AppRoute().getAll,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),

      ),
    );
  }
}
