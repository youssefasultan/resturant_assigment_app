import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:resturant_assigment_app/core/common/widgets/map/map_widget.dart';
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // address
            Row(
              children: [
                const Icon(FontAwesomeIcons.addressBook),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    resturant.address,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // categories
            Wrap(
              children: [
                ...resturant.categories!.map(
                  (e) => CategoryContainter(name: e),
                )
              ],
            ),
            const SizedBox(height: 16),
            // map for the resturant
            Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: Stack(
                children: [
                  MapWidget(
                    markers: [
                      Marker(
                        point: LatLng(resturant.late, resturant.long),
                        width: 50,
                        height: 50,
                        child: const Icon(
                          FontAwesomeIcons.locationPin,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
