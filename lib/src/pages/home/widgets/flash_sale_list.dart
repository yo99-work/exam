import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class FlashSaleList extends StatefulWidget {
  const FlashSaleList({Key? key}) : super(key: key);

  @override
  State<FlashSaleList> createState() => _FlashSaleListState();
}

class _FlashSaleListState extends State<FlashSaleList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        childAspectRatio: 0.68,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          Container(
            height: 400,
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: "http://via.placeholder.com/200x150",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter:
                          ColorFilter.mode(CustomTheme.stoke, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          ),
        ]);
  }
}
