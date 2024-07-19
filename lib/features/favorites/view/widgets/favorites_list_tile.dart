import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () {
        favoritesVM.setSelectedResturant(restaurant);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ResturantDetailsScreen(restaurant: restaurant),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Colors.black,
          ),
        ),
        elevation: 16,
        shadowColor: Colors.blue,
        
        child: ListTile(
          leading: const Text('⭐'),
          title: Text(
            restaurant.name,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(restaurant.address),
        ),
      ),
    );
  }
}
