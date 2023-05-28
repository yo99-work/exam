import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../widgets/navigation_icon.dart';

class NotificationPage extends StatelessWidget {
  final bool isPresentMode;
  const NotificationPage({super.key, required this.isPresentMode});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children:[ Container(
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
        ),

          (!isPresentMode) ? SizedBox(height:0):
          Positioned(
            top: 40,
            left: 12,
            child: NavigationIcon(
              icon: Icons.arrow_back,
              notificationValue: 0,
              colorIcon: CustomTheme.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ]
      ),
    );
  }
}
