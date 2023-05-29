import 'package:exam/src/config/theme.dart';
import 'package:exam/src/data/model/product/product.dart';
import 'package:exam/src/data/repository/authen_repository.dart';
import 'package:exam/src/pages/cart/bloc/cart_bloc.dart';
import 'package:exam/src/pages/cart/order_success_page.dart';
import 'package:exam/src/widgets/app_button.dart';
import 'package:exam/src/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/app_bloc.dart';
import '../../di/service_locator.dart';
import '../../widgets/navigation_icon.dart';

class CartPage extends StatefulWidget {
  final bool isPresentMode;
  const CartPage({required this.isPresentMode});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    getIt<AuthenRepository>().currentUser.then((user) {
      context.read<CartBloc>().add(CartFetched(user.id ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final total = state.products.fold(
            0.0,
            (previousValue, element) =>
                previousValue + element.getPriceByQuantity());
        return Material(
          type: MaterialType.transparency,
          child: Container(
              color: CustomTheme.white,
              child: Stack(alignment: Alignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90, bottom: 123),
                  child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return _createCartItem(state, index);
                      }),
                ),
                (!widget.isPresentMode) ?
                const SizedBox(width: 0) :
                Positioned(
                  top: 50,
                  left: 12,
                  child: NavigationIcon(
                    icon: Icons.arrow_back,
                    notificationValue: 0,
                    colorIcon: CustomTheme.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Positioned(
                  top: 50,
                  child: Text(
                    "My cart",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: CustomTheme.primary),
                  ),
                ),
                _CheckoutView(width: width, total: total, state: state,)
              ])),
        );
      },
    );
  }



  Container _createCartItem(CartState state, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: CustomTheme.stoke, style: BorderStyle.solid, width: 0.8),
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: AppImageView(
              imageUrl: state.products[index].thumbnail ?? "",
              radius: 12,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${state.products[index].title}",
                  softWrap: true,
                  maxLines: 3,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(state.products[index].getPriceWithNumericPattern(),
                    style: const TextStyle(
                      color: CustomTheme.deepOrange,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )),
                const SizedBox(
                  height: 12,
                ),
                _createActionupdateCart(state, index)
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _createActionupdateCart(CartState state, int index) {
    return Row(
      children: [
        SizedBox(
            width: 40,
            height: 30,
            child: IconButton(
              padding: const EdgeInsets.only(bottom: 1, top: 2),
              alignment: Alignment.topCenter,
              onPressed: () {
                final userId = context.read<AppBloc>().state.user.id ?? "";
                context
                    .read<CartBloc>()
                    .add(RemoveFromCart(state.products[index], userId));
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.read<CartBloc>().add(CartFetched(userId));
                });
              },
              icon: const Icon(
                Icons.minimize_rounded,
                color: Colors.black87,
                size: 15,
              ),
            )),
        const SizedBox(
          width: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  color: CustomTheme.stoke,
                  style: BorderStyle.solid,
                  width: 1.5),
              borderRadius: BorderRadius.circular(6)),
          child: Text(
            "${state.products[index].quantity ?? 1}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
            alignment: Alignment.center,
            // color: Colors.red,
            width: 40,
            height: 30,
            child: IconButton(
              onPressed: () {
                final userId = context.read<AppBloc>().state.user.id ?? "";
                context
                    .read<CartBloc>()
                    .add(AddToCart(state.products[index], userId));
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.read<CartBloc>().add(CartFetched(userId));
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black87,
                size: 15,
              ),
            )),
      ],
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView({
    required this.width,
    required this.total,
    required this.state,
  });
  final double width;
  final double total;
  final CartState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 20),
        width: width,
        // height: 50,
        color: CustomTheme.white,
        child: Column(children: [
          SizedBox(
            width: width * 0.8,
            child: Row(
              children: [
                const Text(
                  "In total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  Product.convertToHumanD(total),
                  style: const TextStyle(
                    color: CustomTheme.deepOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          AppButton(
              text: "Checkout",
              width: width * 0.8,
              bgColor: CustomTheme.primary,
              textColor: CustomTheme.white,
              onClick: () {
                if (state.products.isNotEmpty) {
                  final userId =
                      context.read<AppBloc>().state.user.id ?? "";
                  context.read<CartBloc>().add(ClearCart(userId));
                  Future.delayed(const Duration(milliseconds: 500),
                      () {
                    context
                        .read<CartBloc>()
                        .add(CartFetched(userId));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const OrderSuccessPage()));
                  });
                } else {
                  Fluttertoast.showToast(
                    msg: 'Your shopping cart is empty',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                }
              })
        ]),
      ),
    );
  }
}
