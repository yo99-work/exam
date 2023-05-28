import 'dart:ffi';

import 'package:exam/src/config/theme.dart';
import 'package:exam/src/pages/cart/bloc/cart_bloc.dart';
import 'package:exam/src/pages/cart/cart_page.dart';
import 'package:exam/src/widgets/navigation_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              NavigationIcon(
                icon: Icons.arrow_back,
                notificationValue: 0,
                colorIcon: _colorIcon,
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(child: SizedBox(width: 8)),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return NavigationIcon(
                    icon: Icons.shopping_cart,
                    notificationValue: state.products.length,
                    colorIcon: _colorIcon,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));

                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

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
      if (scrollOffset <= 0) {
        _backgroundColorSearch = Colors.white;
        _colorIcon = Colors.white;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        _backgroundColorSearch = CustomTheme.background;
        _colorIcon = CustomTheme.primary;
      }

      _backgroundColor = Colors.white.withOpacity(_opacity);
    });
  }
}
