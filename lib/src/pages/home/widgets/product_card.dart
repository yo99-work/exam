import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product/product.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${product.id}', style: textTheme.bodySmall),
        title: Text(product.title ?? ""),
        isThreeLine: true,
        subtitle: Text(product.description ?? ""),
        dense: true,
      ),
    );
  }
}
