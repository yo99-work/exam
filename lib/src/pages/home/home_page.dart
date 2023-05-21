import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam/src/app_route.dart';
import 'package:exam/src/constants/asset.dart';
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
      backgroundColor: Colors.yellow,
      body: Stack(children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                              color: Colors.amber
                          ),
                          child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                color: Colors.red,
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
