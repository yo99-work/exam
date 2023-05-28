import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BannerSlider extends StatefulWidget {
  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final List<String> _image = [
    'assets/images/mock_banner1.png',
    'assets/images/mock_banner2.png',
    'assets/images/mock_banner3.png'
  ];

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
            aspectRatio: 1.77,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _indexPage = index;
              });
            }),
        items: _image.map((item) => Image.asset(item)).toList(),
      ),
    );
  }

  _buildIndicator() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _image.asMap().entries.map((entry) {
          int idx = entry.key;
          return Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 4),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                border: Border.all(color: (idx == _indexPage) ? Colors.deepOrange : Colors.white),
                shape: BoxShape.circle,
                color: (idx == _indexPage) ? Colors.deepOrange : Colors.white
              ),
            ),
          );

        }).toList()
      );

}
