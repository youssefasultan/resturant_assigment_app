import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        favoritesVM.toggleFavorite(restaurant);
      },
      icon: Icon(
        isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
        color: Colors.yellowAccent,
      ),
    );
  }
}
