import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/core/data/repos/resturant_repo.dart';

class FavoritesRepo {
  final RestaurantRepo _restaurantRepository;

  FavoritesRepo(this._restaurantRepository);

  Future<List<RestaurantModel>> getFavorites() async {
    try {
      final favorites = await _restaurantRepository.fetchAllFavorites();
      return favorites;
    } catch (error) {
      rethrow;
    }
  }



  Future<void> updateFavorites(List<RestaurantModel> restaurants) async {
    try {
      await _restaurantRepository.updateFavorites(restaurants);
    } catch (error) {
      rethrow;
    }
  }
}
