import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static const Color gradientStart = const Color(0xFFF);
  static const Color gradint = const Color(0xFFF);
  static const Color primary = const Color(0xFF4E54A3);

  static const Color background = const Color(0xFFEDECF2);
  static const Color stoke = const Color(0xFFD5DDE0);
  static const Color green = const Color(0xFF00D3A1);
  static const Color yellow = const Color(0xFFFFC900);
  static const Color white = const Color(0xFFFFFFFF);

  static const Color deepOrange = const Color(0xFFFF5F00);

  static const LinearGradient primaryGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomCenter,
      stops: [
        0.1,
        0.9,
      ],
      colors: [
        Color(0xFF8f97ff),
        Color(0xFF4E54A3),

      ]);
}
