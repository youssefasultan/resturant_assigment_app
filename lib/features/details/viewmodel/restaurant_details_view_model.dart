import 'package:flutter/material.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/features/details/data/restaurant_details_repo.dart';

class RestaurantDetailsViewModel extends ChangeNotifier {
  final RestaurantDetailsRepo _restaurantDetailsRepo;
  final RestaurantModel _resturantModel;
  RestaurantDetailsViewModel(
      this._restaurantDetailsRepo, this._resturantModel) {
    getRestaurantPhotos(_resturantModel.fsqId);
  }

  RestaurantModel get resturantModel => _resturantModel;

  Future<void> getRestaurantPhotos(String id) async {
    try {
      final photos = await _restaurantDetailsRepo.getRestaurantPhotos(id);

      _resturantModel.photosUrl = photos;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
