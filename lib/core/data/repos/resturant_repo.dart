import 'package:resturant_assigment_app/core/data/api/foursquare_api.dart';

import '../models/resturant_model.dart';

class RestaurantRepo {
  final FoursquareApi _foursquareApi;

  RestaurantRepo(this._foursquareApi);

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

  Future<List<String>> getRestaurantPhoros(String id) async {
    try {
      return await _foursquareApi.getRestaurantPhotos(id);
    } catch (error) {
      rethrow;
    }
  }
}
