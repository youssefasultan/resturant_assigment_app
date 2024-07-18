import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/features/details/view/resturant_details_screen.dart';
import 'package:resturant_assigment_app/features/search/view/widgets/map_pin.dart';
import 'package:resturant_assigment_app/features/search/viewmodel/resturant_search_view_model.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final searchVM = context.watch<RestaurantSearchViewModel>();
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(searchVM.currentLocation.latitude,
            searchVM.currentLocation.longitude),
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          maxZoom: 20,
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.resturant_assigment_app',
        ),
        MarkerLayer(
          markers: [
            ...searchVM.getResturants.map(
              (e) => Marker(
                point: LatLng(e.late, e.long),
                width: 100,
                height: 80,
                child: GestureDetector(
                  onTap: () {
                    searchVM.setSelectedResturant(e);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResturantDetailsScreen()));
                  },
                  child: MapPin(
                    name: e.name,
                  ),
                ),
              ),
            ),
            Marker(
              point: LatLng(searchVM.currentLocation.latitude,
                  searchVM.currentLocation.longitude),
              width: 50,
              height: 50,
              child: const Icon(
                FontAwesomeIcons.locationPin,
                color: Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }
}
