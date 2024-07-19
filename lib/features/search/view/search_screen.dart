import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/extention/context_ext.dart';
import 'package:resturant_assigment_app/core/utils/network_service.dart';
import 'package:resturant_assigment_app/features/details/view/resturant_details_screen.dart';
import 'package:resturant_assigment_app/features/favorites/view/favorites_screen.dart';
import 'package:resturant_assigment_app/core/common/widgets/map/map_pin.dart';
import 'package:resturant_assigment_app/features/search/viewmodel/resturant_search_view_model.dart';

import '../../../core/common/widgets/map/map_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    final searchVm = context.restaurantSearchViewModel;

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      searchVm.fetchUserLocation().then(
        (_) async {
          if (!(await NetworkService.isConnected()) && mounted) {
            context.showSnackBar('Please Check Internet Connection');
            setState(() {
              _isLoading = false;
            });
            return;
          }

          searchVm.fetchNearByResturants().then(
            (_) {
              setState(() {
                _isLoading = false;
              });
            },
          );
        },
      ).onError((error, stack) {
        context.showSnackBar('Error Fetching current location');
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final searchVM = context.watch<RestaurantSearchViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Near by Resturants',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        centerTitle: true,
        actions: [
          // show favorite button, when pressed push to favorites screen
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
              icon: const Text(
                '⭐',
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // map widget, shows all resturants on the map
                MapWidget(
                  markers: [
                    // generate list of markers for near by resturants
                    ...searchVM.getResturants.map(
                      (e) => Marker(
                        point: LatLng(e.late, e.long),
                        width: 100,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            searchVM.setSelectedResturant(e);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ResturantDetailsScreen(),
                              ),
                            );
                          },
                          child: MapPin(
                            name: e.name,
                          ),
                        ),
                      ),
                    ),
                    // marker for user current location
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
                ),
              ],
            ),
    );
  }
}
