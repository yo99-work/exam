import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam/src/app_route.dart';
import 'package:exam/src/constants/asset.dart';
import 'package:exam/src/pages/home/bloc/product/product_bloc.dart';
import 'package:exam/src/pages/home/widgets/banner_slider.dart';
import 'package:exam/src/pages/home/widgets/header.dart';
import 'package:exam/src/pages/home/widgets/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter_a_bloc/counter_a_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _scrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [

        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              BannerSlider(),


              
              Container(
                // padding: const EdgeInsets.all(20),
                // color: Colors.lightBlue,
                // // height: 100,
                // width: double.infinity,
                // height: 1000,
                child: BlocProvider(
                  create: (_) => ProductBloc()..add(ProductFetched()),
                  child: ProductList(_scrollController),
                ),
              ),
            ],
          ),
        ),
        Header(_scrollController),

      ]),
    );
  }
}
