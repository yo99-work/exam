import 'package:exam/src/app.dart';
import 'package:exam/src/bloc/AppBlocObserver.dart';
import 'package:exam/src/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {

  //configure
  // runApp(const MyApp());
  setupDi();
  BlocOverrides.runZoned(() {
    runApp(const App());
  }, blocObserver: AppBlocObserver());
}
