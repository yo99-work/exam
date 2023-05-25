import 'package:exam/src/pages/product_detail/product_detail_page.dart';
import 'package:exam/src/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';

import 'data/model/product/product.dart';

class AppRoute {
  static const home = "home";
  static const productDetailPage = "product";

  final _rount = <String, WidgetBuilder> {
    home: (contxt) => HomePage(),
    // productDetailPage: (contxt, Product product) => ProductDetailPage(product: product),
  };

  get getAll => _rount;
}