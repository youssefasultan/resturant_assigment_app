import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.resturant,
  });

  final RestaurantModel resturant;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
      ),
      items: resturant.photosUrl!
          .map(
            (e) => CachedNetworkImage(
              imageUrl: e,
              fit: BoxFit.contain,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
              errorWidget: (context, url, error) => const Icon(
                FontAwesomeIcons.triangleExclamation,
              ),
            ),
          )
          .toList(),
    );
  }
}