import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/data/api/foursquare_api.dart';
import 'package:resturant_assigment_app/core/data/repos/resturant_repo.dart';
import 'package:resturant_assigment_app/core/data/strorage/local_storage.dart';
import 'package:resturant_assigment_app/features/details/data/restaurant_details_repo.dart';
import 'package:resturant_assigment_app/features/details/viewmodel/restaurant_details_view_model.dart';
import 'package:resturant_assigment_app/features/favorites/data/favorites_repo.dart';
import 'package:resturant_assigment_app/features/favorites/viewmodel/favorites_view_model.dart';
import 'package:resturant_assigment_app/features/search/data/resturant_search_repo.dart';
import 'package:resturant_assigment_app/features/search/viewmodel/resturant_search_view_model.dart';

extension BuildContextEntension on BuildContext {
  FoursquareApi get foursquareApi => read<FoursquareApi>();
  LocalStorage get localStorage => read<LocalStorage>();

  RestaurantRepo get restaurantRepo => read<RestaurantRepo>();
  RestaurantSearchRepo get restaurantSearchRepo => read<RestaurantSearchRepo>();
  RestaurantDetailsRepo get restaurantDetailsRepo =>
      read<RestaurantDetailsRepo>();
  FavoritesRepo get favoritesRepo => read<FavoritesRepo>();

  RestaurantSearchViewModel get restaurantSearchViewModel =>
      read<RestaurantSearchViewModel>();
  FavoritesViewModel get favoritesViewModel => read<FavoritesViewModel>();
  RestaurantDetailsViewModel get restaurantDetailsViewModel =>
      read<RestaurantDetailsViewModel>();

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(this)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.white),
        ),
        elevation: 3,
        backgroundColor: Colors.red,
      ),
    );
  }
}
