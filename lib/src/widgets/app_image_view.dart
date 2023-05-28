import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/theme.dart';

class AppImageView extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const AppImageView({super.key, required this.imageUrl, required this.radius});


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
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
    );
  }
}
