import 'package:exam/src/config/theme.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: CustomTheme.primary,
      child: const Text(
        "Coming Soon",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color: CustomTheme.white,
        ),
      ),
    );
  }
}
