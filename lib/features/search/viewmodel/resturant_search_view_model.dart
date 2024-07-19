import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/features/search/data/resturant_search_repo.dart';
import 'package:resturant_assigment_app/core/utils/location_service.dart';

class RestaurantSearchViewModel extends ChangeNotifier {
  RestaurantSearchViewModel(this._restaurantSearchRepository);

  final RestaurantSearchRepo _restaurantSearchRepository;
  final _locationService = LocationService();

  Position? _currentLocation;
  List<RestaurantModel> _resturants = [];
  String _error = '';
  RestaurantModel? _selectedResturant;

  String get error {
    return _error;
  }

  RestaurantModel? get selectedResturant {
    return _selectedResturant;
  }

  List<RestaurantModel> get getResturants {
    return _resturants;
  }

  Position get currentLocation {
    return _currentLocation!;
  }


  /// getting user current location
  Future<void> fetchUserLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();

      // Update the location
      _currentLocation = position;
    } catch (e) {
      rethrow;
    }
  }

  /// getting nearby resturants
  Future<void> fetchNearByResturants() async {
    try {
      if (_currentLocation == null) {
        return;
      }

      final restaurants =
          await _restaurantSearchRepository.getNearbyRestaurants(
        latitude: _currentLocation!.latitude,
        longitude: _currentLocation!.longitude,
      );

      _resturants = restaurants;
    } catch (e) {
      _error = e.toString();
    }
  }


  /// set selected resturant for details screen
  void setSelectedResturant(RestaurantModel e) {
    _selectedResturant = e;
    notifyListeners();
  }
}
