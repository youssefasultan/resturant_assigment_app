import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/core/data/repos/resturant_repo.dart';

class RestaurantSearchRepo {
  final RestaurantRepo _restaurantRepository;

  RestaurantSearchRepo(this._restaurantRepository);

  Future<List<RestaurantModel>> getNearbyRestaurants({
    required double latitude,
    required double longitude,
    int radius = 1000,
  }) async {
    try {
      final restaurants = await _restaurantRepository.getNearbyRestaurants(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );

      return restaurants;
    } catch (error) {
      rethrow;
    }
  }
}
