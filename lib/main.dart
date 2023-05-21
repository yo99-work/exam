import 'package:exam/src/app_route.dart';
import 'package:exam/src/bloc/AppBlocObserver.dart';
import 'package:exam/src/bloc/counter_a_bloc/counter_a_bloc.dart';
import 'package:exam/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  // runApp(const MyApp());
  BlocOverrides.runZoned(() {
    runApp(MyApp());
  }, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    final counterABloc = BlocProvider<CounterABloc>(create: (context) => CounterABloc());
    // final counterBBloc = BlocProvider<CounterBBloc>(create: (context) => CounterBBloc());

    return MultiBlocProvider(
      providers: [counterABloc],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: AppRoute().getAll,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(title: 'LoginPage'),

      ),
    );
  }
}

