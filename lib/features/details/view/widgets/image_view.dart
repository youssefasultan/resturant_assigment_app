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
        height: 200.0,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
      items: resturant.photosUrl!
          .map(
            (e) => CachedNetworkImage(
              imageUrl: e,
              imageBuilder: (context, imageProvider) => Container(
                width: 300.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
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
