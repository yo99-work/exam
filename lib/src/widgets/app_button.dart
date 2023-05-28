import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double width;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onClick;

  const AppButton(
      {super.key, required this.text,
      required this.width,
      required this.bgColor,
      required this.textColor,
        required this.onClick});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: textColor,
      backgroundColor: bgColor,
      minimumSize: Size(width, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: () {
        onClick();
      },
      child: Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
    );
  }
}
