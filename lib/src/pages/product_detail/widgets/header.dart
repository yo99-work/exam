import 'dart:ffi';

import 'package:exam/src/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product/product.dart';

class Header extends StatefulWidget {
  final ScrollController scrollController;
  final Product product;

  const Header(this.scrollController, this.product, {super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late Color _backgroundColor;
  late Color _backgroundColorSearch;
  late Color _colorIcon;
  late double _opacity;
  late double _opacityMax = 0.01;
  late double _offset;

  @override
  void initState() {
    _backgroundColor = Colors.transparent;
    _backgroundColorSearch = Colors.white;
    _colorIcon = Colors.white;
    _opacity = 0.0;
    _offset = 0.0;

    widget.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: [
              _buildNavigationIcon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.arrow_back,
                  notificationValue: 0),
              const Expanded(child: SizedBox(width: 8))
              ,
              _buildNavigationIcon(
                  onPressed: () => print("click"),
                  icon: Icons.shopping_cart,
                  notificationValue: 20),

            ],
          ),
        ),
      ),
    );
  }

  _buildNavigationIcon(
          {required VoidCallback onPressed,
          required IconData icon,
          int notificationValue = 0}) =>
      Stack(
        children: [Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Stack(
            children: [Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26
              ),
              child:
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(icon),
                      color: _colorIcon,
                      iconSize: 22),


            ),


            ]
          ),
        ),

          notificationValue == 0
              ? const SizedBox()
              : Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
              ),
              constraints:
              const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$notificationValue',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]
      );

  void _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
    } else if (scrollOffset < 50) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if (_opacity <= 1.0) {
        _opacity = 0;
      }
    }

    setState(() {
      if(scrollOffset <= 0) {
        _backgroundColorSearch = Colors.white;
        _colorIcon = Colors.white;
        _offset = 0.0;
        _opacity = 0.0;
      }else {
        _backgroundColorSearch = CustomTheme.background;
        _colorIcon = CustomTheme.primary;
      }

      _backgroundColor = Colors.white.withOpacity(_opacity);
    });
  }
}
