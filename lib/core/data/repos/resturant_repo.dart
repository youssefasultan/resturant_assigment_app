import 'package:resturant_assigment_app/core/data/api/foursquare_api.dart';
import 'package:resturant_assigment_app/core/data/strorage/local_storage.dart';

import '../models/resturant_model.dart';

class RestaurantRepo {
  RestaurantRepo(this._foursquareApi, this._localStorage);

  final FoursquareApi _foursquareApi;
  final LocalStorage _localStorage;

  // remote data-source
  /// Fetches nearby restaurants based on latitude and longitude.
  Future<List<RestaurantModel>> getNearbyRestaurants({
    required double latitude,
    required double longitude,
    int radius = 1000,
  }) async {
    try {
      final response = await _foursquareApi.getNearbyRestaurants(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );

      final restaurants = response.venues;

      return restaurants;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<String>> getRestaurantPhotos(String id) async {
    try {
      return await _foursquareApi.getRestaurantPhotos(id);
    } catch (error) {
      rethrow;
    }
  }

  // local data-source

  Future<List<RestaurantModel>> fetchAllFavorites() async {
    try {
      return await _localStorage.fetchAllFavorites();
    } catch (error) {
      rethrow;
    }
  }


  Future<void> updateFavorites(List<RestaurantModel> restaurants) async {
    try {
      await _localStorage.updateFavorites(restaurants);
    } catch (error) {
      rethrow;
    }
  }
}
