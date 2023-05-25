import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam/src/app_route.dart';
import 'package:exam/src/constants/asset.dart';
import 'package:exam/src/pages/home/bloc/flash_sale_product/flash_sale_product_bloc.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:exam/src/pages/home/widgets/banner_slider.dart';
import 'package:exam/src/pages/home/widgets/flash_sale_list.dart';
import 'package:exam/src/pages/home/widgets/header.dart';
import 'package:exam/src/pages/home/widgets/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter_a_bloc/counter_a_bloc.dart';
import '../../config/theme.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.background,
      body: Stack(children: [
        ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            children: [
              BannerSlider(),

              const SectionTitle(title: "FLASH SALE",),
              BlocProvider(
                  create: (_) => FlashSaleProductBloc()..add(FlashSaleProductFetched()),
                  child: const FlashSaleList(),
              ),

              const SectionTitle(title: "DAILY DISCOVER",),
              BlocProvider(
                create: (_) => ProductBloc()..add(ProductFetched()),
                child: ProductList(_scrollController),
              ),
            ]),
        Header(_scrollController),
      ]),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(title,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: CustomTheme.primary)),
    );
  }
}
