import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam/src/pages/home/bloc/flash_sale_product/flash_sale_product_bloc.dart';
import 'package:exam/src/pages/home/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme.dart';
import '../../../widgets/BottomLoader.dart';
import '../bloc/product/product_bloc.dart';

class FlashSaleList extends StatefulWidget {
  const FlashSaleList({Key? key}) : super(key: key);

  @override
  State<FlashSaleList> createState() => _FlashSaleListState();
}

class _FlashSaleListState extends State<FlashSaleList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashSaleProductBloc, FlashSaleProductState>(
        builder: (context, state) {
      switch (state.status) {
        case LazyLoadStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
        case LazyLoadStatus.success:
          if (state.products.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.65,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.hasReachedMax
                    ? state.products.length
                    : state.products.length + 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 8, right: (index+1 == state.products.length) ? 8 : 0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width * 0.65,
                        child: ProductCardItem(product: state.products[index])),
                  );
                }),
          );

        case LazyLoadStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
