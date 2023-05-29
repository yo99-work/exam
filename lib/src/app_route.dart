import 'package:exam/src/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {
  static const home = "home";
  static const productDetailPage = "product";

  final _rount = <String, WidgetBuilder> {
    home: (contxt) => HomePage(),
  };

  get getAll => _rount;
}