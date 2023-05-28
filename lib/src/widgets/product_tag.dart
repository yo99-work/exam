import 'package:exam/src/config/theme.dart';
import 'package:flutter/material.dart';

enum ProductTagType { freeDelivery, bigSale, cashBack }

class ProductTag extends StatelessWidget {
  final ProductTagType type;

  const ProductTag(this.type);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProductTagType.bigSale:
        return Container(
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          decoration: BoxDecoration(
              color: CustomTheme.primary,
              borderRadius: BorderRadius.circular(18)),
          child: const Text(
            "11.11",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 9),
          ),
        );

      case ProductTagType.freeDelivery:
        return Container(
          margin: EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          decoration: BoxDecoration(
              color: CustomTheme.green,
              borderRadius: BorderRadius.circular(18)),
          child: const Row(
            children: [
              Text(
                "Delivery",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 9),
              ),
            ],
          ),
        );
      case ProductTagType.cashBack:
        return Container(
          margin: EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          decoration: BoxDecoration(
              color: CustomTheme.primary,
              borderRadius: BorderRadius.circular(18)),

          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Xtra",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 8),
              ),
              Text(
                "CASHBACK",
                style: TextStyle(
                    color: CustomTheme.yellow,
                    fontWeight: FontWeight.w900,
                    fontSize: 6),
              )
            ],
          ),
        );
    }
  }
}
