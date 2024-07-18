import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/extention/context_ext.dart';
import 'package:resturant_assigment_app/features/favorites/viewmodel/favorites_view_model.dart';

import 'widgets/favorites_list_tile.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static const routeName = '/favorites_screen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    final favoritesVM = context.favoritesViewModel;

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      favoritesVM.getFavorites().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).onError(
        (error, stackTrace) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesVM = context.watch<FavoritesViewModel>();
    final restaurants = favoritesVM.restaurants;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : restaurants.isEmpty
              ? Center(
                  child: Text('No Favorites',
                      style: Theme.of(context).textTheme.titleLarge),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];

                    return FavoriteListTile(restaurant: restaurant);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: favoritesVM.restaurants.length,
                ),
    );
  }
}
