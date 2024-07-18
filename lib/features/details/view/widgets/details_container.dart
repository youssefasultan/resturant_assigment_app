import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';

import 'category_container.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.resturant,
  });

  final RestaurantModel resturant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: Colors.blue),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            FittedBox(
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.addressBook),
                  const SizedBox(width: 16),
                  Text(
                    resturant.address,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              children: [
                ...resturant.categories!.map(
                  (e) => CategoryContainter(name: e),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
