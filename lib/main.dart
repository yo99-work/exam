import 'package:exam/src/app.dart';
import 'package:exam/src/bloc/Observe/app_bloc_observe.dart';
import 'package:exam/src/di/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
Future<void> main() async {

  //configure
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDi();
  runApp(const App());

}
