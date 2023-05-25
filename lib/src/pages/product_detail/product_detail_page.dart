import 'package:exam/src/pages/product_detail/widgets/product_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../data/model/product/product.dart';
import '../../widgets/app_button.dart';
import '../home/widgets/banner_slider.dart';
import '../home/widgets/product_card.dart';
import 'widgets/header.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomTheme.background,
      body: Stack(children: [
        ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            children: [
              Column(children: [
                ProductSlider(images: widget.product.images ?? []),
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.product.title ?? "", textAlign: TextAlign.left),
                      Text(widget.product.description ?? ""),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        child: ProductPriceView(product: widget.product),
                      ),


                         AppButton(text: "Add to cart", width: MediaQuery.of(context).size.width * 0.8, bgColor: CustomTheme.primary, textColor: Colors.white)

                    ],
                  ),
                )
              ]),
            ]),
        Header(_scrollController, widget.product),
      ]),
    );
  }
}


