import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam/src/app_route.dart';
import 'package:exam/src/config/theme.dart';
import 'package:exam/src/pages/product_detail/product_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/product/product.dart';
import '../../../widgets/product_tag.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.width * 0.38;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)));
      },
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  SizedBox(
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
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
                  if (!product.isFlashSale) ...[
                    const Row(
                      children: [
                        ProductTag(ProductTagType.cashBack),
                        ProductTag(ProductTagType.freeDelivery),
                        ProductTag(ProductTagType.bigSale),
                      ],
                    ),
                  ],
                  const Spacer(flex: 1),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: product.isFlashSale
                        ? ProductFlastSalePriceView(product: product)
                        : ProductPriceView(product: product),
                  ),
                ],
              )),
          Positioned(
            right: -10,
            top: -10,
            child:
            (!product.isFlashSale) ? SizedBox(height: 0,) :
            Stack(alignment: Alignment.center, children: [
              const Icon(
                Icons.bookmark,
                color: CustomTheme.yellow,
                size: 60,
              ),
              Center(child: Text("${product.discountPercentage?.toInt() ?? 0}%",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red
              )))
            ]),
          )
        ],
      ),
    );
  }
}

class ProductPriceView extends StatelessWidget {
  const ProductPriceView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(product.getPriceWithNumericPattern(),
            style: const TextStyle(
              color: CustomTheme.deepOrange,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            )),
        const Spacer(flex: 1),
        const Icon(Icons.star, size: 18, color: CustomTheme.yellow),
        Text("${product.rating}",
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ))
      ],
    );
  }
}

class ProductFlastSalePriceView extends StatelessWidget {
  const ProductFlastSalePriceView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(product.getPriceWithNumericPattern(),
            style: const TextStyle(
              color: CustomTheme.deepOrange,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )),
        Text("Stock:${product.stock ?? 0}",
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ))
      ],
    );
  }
}
