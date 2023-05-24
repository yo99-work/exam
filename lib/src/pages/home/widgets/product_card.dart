import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam/src/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product/product.dart';
import '../../../widgets/product_tag.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.width*0.4;
    return Container(
        // height: 400,

        padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Container(
              height: mediaHeight,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: CustomTheme.stoke,
                        style: BorderStyle.solid,
                        width: 0.5),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.colorBurn)),
                  ),
                ), // placeholder: (context, url) => (),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              alignment: Alignment.centerLeft,
              child: Text(
                "${product.title}",
                softWrap: true,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              child: const Row(
                children: [
                  ProductTag(ProductTagType.cashBack),
                  ProductTag(ProductTagType.freeDelivery),
                  ProductTag(ProductTagType.bigSale),
                ],
              ),
            ),
            const Spacer(flex: 1),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              child: Row(
                children: [
                  Text("\$${product.price}",
                      style: const TextStyle(
                        color: CustomTheme.deepOrange,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                  Spacer(flex: 1),
                  Row(
                    children: [
                      const Icon(Icons.star,  size: 18,color: CustomTheme.yellow),
                      Text("${product.rating}",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
