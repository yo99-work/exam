import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final TrackingScrollController scrollController;

  const Header(this.scrollController, {super.key});

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

    widget.scrollController.addListener(_onScoll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildInputSearch(),
              const SizedBox(width: 8),
              _buildNavigationIcon(
                  onPressed: () => print("click"),
                  icon: Icons.shopping_cart,
                  notificationValue: 20),
              _buildNavigationIcon(
                  onPressed: () => print("notification"),
                  icon: Icons.chat_sharp,
                  notificationValue: 10),
            ],
          ),
        ),
      ),
    );
  }

  _buildInputSearch() {
    const textFieldBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ));

    const sizeIcon = BoxConstraints(minHeight: 40, minWidth: 40);

    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          enabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
          hintText: "Search",
          hintStyle: const TextStyle(
            fontSize: 18,
            color: Colors.deepOrange,
          ),
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.blue,
          prefixIconConstraints: sizeIcon,
          suffixIcon: const Icon(Icons.camera_alt),
          suffixIconConstraints: sizeIcon,
          filled: true,
          fillColor: _backgroundColorSearch,
        ),
      ),
    );
  }

  _buildNavigationIcon(
          {required VoidCallback onPressed,
          required IconData icon,
          int notificationValue = 0}) =>
      Stack(
        children: [
          IconButton(
              onPressed: onPressed,
              icon: Icon(icon),
              color: _colorIcon,
              iconSize: 28),
          notificationValue == 0
              ? const SizedBox()
              : Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 20, minHeight: 20),
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
        ],
      );

  void _onScoll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
    } else if (scrollOffset < 100) {
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
        _backgroundColorSearch = Colors.grey[200]!;
        _colorIcon = Colors.deepOrange;
      }

      _backgroundColor = Colors.white.withOpacity(_opacity);
    });
  }
}
