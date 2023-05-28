import 'package:exam/src/pages/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/BottomLoader.dart';
import '../bloc/product/product_bloc.dart';

class ProductList extends StatefulWidget {
  final ScrollController scrollController;
  const ProductList(this.scrollController, {super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width/2;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        switch (state.status) {
          case LazyLoadStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case LazyLoadStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('no posts'));
            }

            return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 0.68,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    maxCrossAxisExtent: halfWidth),

                itemCount: state.hasReachedMax
                    ? state.products.length
                    : state.products.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.products.length
                      ? const BottomLoader()
                      : ProductCardItem(product: state.products[index]); Text("$index");
                });
          case LazyLoadStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    widget.scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ProductBloc>().add(ProductFetched());
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }
}
