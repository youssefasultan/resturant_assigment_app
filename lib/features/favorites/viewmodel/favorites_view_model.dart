import 'package:flutter/material.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/features/favorites/data/favorites_repo.dart';

class FavoritesViewModel extends ChangeNotifier {
  FavoritesViewModel(this._favoritesRepo);

  final FavoritesRepo _favoritesRepo;

  List<RestaurantModel> _restaurants = [];
  List<RestaurantModel> get restaurants => _restaurants;

  RestaurantModel? _selectedResturant;
  RestaurantModel? get selectedResturant => _selectedResturant;
  

  /// set selected resturant for details screen
  void setSelectedResturant(RestaurantModel e) {
    _selectedResturant = e;
    notifyListeners();
  }

  /// update favorites
  Future<void> updateFavorites() async {
    try {
      await _favoritesRepo.updateFavorites(_restaurants);
    } catch (error) {
      rethrow;
    }
  }


  /// get Favorite restrants
  Future<void> getFavorites() async {
    try {
      final favorites = await _favoritesRepo.getFavorites();
      _restaurants = favorites;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  /// add resturant to favorites
  void addFavorite(RestaurantModel restaurant) {
    _restaurants.add(restaurant);
    updateFavorites();
    notifyListeners();
  }


  /// remove resturant from favorites
  void removeFavorite(RestaurantModel restaurant) {
    _restaurants.remove(restaurant);
    updateFavorites();
    notifyListeners();
  }

  /// check if resturant found in favorites
  bool isFavorite(String fsqId) {
    return _restaurants.any((element) => element.fsqId == fsqId);
  }

  /// toggle the favorite resturant
  void toggleFavorite(RestaurantModel resturant) {
    if (isFavorite(resturant.fsqId)) {
      removeFavorite(_restaurants
          .firstWhere((element) => element.fsqId == resturant.fsqId));
    } else {
      addFavorite(resturant);
    }
  }
}
