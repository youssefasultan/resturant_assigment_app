import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/features/details/view/resturant_details_screen.dart';
import 'package:resturant_assigment_app/features/favorites/viewmodel/favorites_view_model.dart';

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({
    super.key,
    required this.restaurant,
  });

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    final favoritesVM = context.watch<FavoritesViewModel>();
    return ListTile(
      leading: const Icon(FontAwesomeIcons.store, color: Colors.blue),
      subtitle: Text(restaurant.address),
      title: Text(
        restaurant.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onTap: () {
        favoritesVM.setSelectedResturant(restaurant);

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResturantDetailsScreen(restaurant: restaurant),
        ));
      },
    );
  }
}
