import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../widgets/app_image_view.dart';

class ProductSlider extends StatefulWidget {
  final List<String> images;

  const ProductSlider({super.key, required this.images});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  late int _indexPage;

  @override
  void initState() {
    _indexPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      _buildContainer(),
      _buildIndicator(),
    ]);
  }

  Container _buildContainer() {
    return Container(
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 1,
            viewportFraction: 1,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                _indexPage = index;
              });
            }),
        items: widget.images
            .map((item) => AppImageView(
                  imageUrl: item,
                  radius: 0,
                ))
            .toList(),
      ),
    );
  }

  _buildIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.black26),
            child: Center(
                child: Text(
              '${(_indexPage + 1)}/${widget.images.length}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )),
          ),
        ],
      );
}
