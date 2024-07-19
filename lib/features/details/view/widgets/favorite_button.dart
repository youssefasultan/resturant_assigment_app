import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/features/favorites/viewmodel/favorites_view_model.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    final favoritesVM = context.watch<FavoritesViewModel>();
    final isFavorite = favoritesVM.isFavorite(restaurant.fsqId);

    return IconButton(
      onPressed: () {
        // toogling the favorite
        favoritesVM.toggleFavorite(restaurant);
      },
      icon: Image.asset(
        isFavorite ? 'assets/icons/fav_2.png' : 'assets/icons/fav_1.png',
        fit: BoxFit.contain,
        color: Colors.white,
        width: 30,
        height: 30,
      ),
    );
  }
}
