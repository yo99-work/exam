import 'package:flutter/material.dart';

class NavigationIcon extends StatelessWidget {
  final IconData icon;
  final int notificationValue;
  final Color colorIcon;
  final VoidCallback onPressed;

  const NavigationIcon(
      {super.key,
      required this.icon,
      required this.notificationValue,
      required this.colorIcon,
      required this.onPressed,
      });

  @override
  Widget build(BuildContext context) {
    return       Stack(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Stack(children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26),
            child: IconButton(
                onPressed: onPressed,
                icon: Icon(icon),
                color: colorIcon,
                iconSize: 22),
          ),
        ]),
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
    ]);
  }


}
