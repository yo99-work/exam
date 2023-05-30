import 'package:exam/src/bloc/app_bloc.dart';
import 'package:exam/src/pages/cart/bloc/cart_bloc.dart';
import 'package:exam/src/pages/login/login_page.dart';
import 'package:exam/src/pages/product_detail/widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/theme.dart';
import '../../data/model/product/product.dart';
import '../../widgets/app_button.dart';
import '../home/widgets/product_card.dart';
import 'widgets/header.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(children: [
                  ProductSlider(images: widget.product.images ?? []),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                        Text(
                          widget.product.description ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          child: ProductPriceView(product: widget.product),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    builder: (_, state) {
                      return AppButton(
                        text: "Add to cart",
                        width: MediaQuery.of(context).size.width * 0.8,
                        bgColor: CustomTheme.primary,
                        textColor: Colors.white,
                        onClick: () {
                          final userId =
                              context.read<AppBloc>().state.user.id ?? "";
                          if (state.status == AppStatus.authenticated) {
                            context
                                .read<CartBloc>()
                                .add(AddToCart(widget.product, userId));
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              context.read<CartBloc>().add(CartFetched(userId));
                              Fluttertoast.showToast(
                                msg: 'Added to cart',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage(
                                        isPresentMode: true,
                                      ),
                                  fullscreenDialog: true),
                            );
                          }
                        },
                      );
                    },
                  )
                ]),
              ),
            ]),
        Header(_scrollController, widget.product),
      ]),
    );
  }
}
