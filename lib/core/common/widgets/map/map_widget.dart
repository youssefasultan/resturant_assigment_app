import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/features/search/viewmodel/resturant_search_view_model.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.markers,
  });
  final List<Marker> markers;

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
        MarkerLayer(markers: markers)
      ],
    );
  }
}
