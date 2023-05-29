import 'package:exam/src/config/theme.dart';
import 'package:exam/src/constants/asset.dart';
import 'package:exam/src/widgets/app_button.dart';
import 'package:flutter/material.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: const BoxDecoration(
          gradient: CustomTheme.primaryGradient
        ),
        child: Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(Asset.ICON_SUCCESS)),
              const Text(
                "Order success!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              const Text("Your order has been placed successfully!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white70)),
              // SizedBox(height: width*0.3,),
            ],
          ),
          Positioned(
            bottom: 40,
            child: AppButton(
                text: "Continue shopping",
                width: width * 0.8,
                bgColor: Colors.white,
                textColor: CustomTheme.primary,
                onClick: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);

                }),
          )
        ]),
      ),
    );
  }

}
