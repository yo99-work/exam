import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam/src/app_route.dart';
import 'package:exam/src/constants/asset.dart';
import 'package:exam/src/pages/home/widgets/banner_slider.dart';
import 'package:exam/src/pages/home/widgets/header.dart';
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
                color: Colors.lightBlue,
                height: 1000,
                width: double.infinity,
                child: Text("xxxix"),
              ),
            ],
          ),
        ),
        Header(_scrollController),

      ]),
    );
  }
}
