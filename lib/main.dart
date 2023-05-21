import 'package:exam/src/app.dart';
import 'package:exam/src/bloc/AppBlocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {

  //configure
  // runApp(const MyApp());

  BlocOverrides.runZoned(() {
    runApp(App());
  }, blocObserver: AppBlocObserver());
}
