import 'package:flutter/material.dart';

import '../../config/theme.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage();

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
