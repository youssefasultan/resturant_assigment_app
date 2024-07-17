import 'package:resturant_assigment_app/core/data/repos/resturant_repo.dart';

class RestaurantDetailsRepo {
  final RestaurantRepo _restaurantRepository;

  RestaurantDetailsRepo(this._restaurantRepository);


  Future<List<String>> getRestaurantPhotos(String id) async {
    try {
      return await _restaurantRepository.getRestaurantPhoros(id);
    } catch (error) {
      rethrow;
    }
  }
}
