import 'package:exam/src/pages/another_page.dart';
import 'package:exam/src/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {
  static const home = "home";
  static const another = "another";

  final _rount = <String, WidgetBuilder> {
    home: (contxt) => HomePage(),
    another: (contxt) => AnotherPage(title:"Another"),
  };

  get getAll => _rount;
}