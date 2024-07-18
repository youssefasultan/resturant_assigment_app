import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/data/strorage/local_storage.dart';
import 'package:resturant_assigment_app/core/extention/context_ext.dart';
import 'package:resturant_assigment_app/core/theme/app_theme.dart';
import 'package:resturant_assigment_app/features/details/data/restaurant_details_repo.dart';
import 'package:resturant_assigment_app/features/search/view/search_screen.dart';

import 'core/data/api/foursquare_api.dart';
import 'core/data/repos/resturant_repo.dart';
import 'features/details/viewmodel/restaurant_details_view_model.dart';
import 'features/favorites/data/favorites_repo.dart';
import 'features/favorites/viewmodel/favorites_view_model.dart';
import 'features/search/data/resturant_search_repo.dart';
import 'features/search/viewmodel/resturant_search_view_model.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Core Providers:
        Provider<FoursquareApi>(create: (_) => FoursquareApi()),
        Provider<LocalStorage>(create: (_) => LocalStorage()),
        Provider<RestaurantRepo>(
          create: (context) =>
              RestaurantRepo(context.foursquareApi, context.localStorage),
        ),

        // Feature-Specific Providers:
        // ... (Restaurant Search Providers) ...
        Provider<RestaurantSearchRepo>(
          create: (context) => RestaurantSearchRepo(context.restaurantRepo),
        ),

        ChangeNotifierProvider<RestaurantSearchViewModel>(
          create: (context) =>
              RestaurantSearchViewModel(context.restaurantSearchRepo),
        ),

        // ... (Restaurant details Providers) ...
        Provider<RestaurantDetailsRepo>(
          create: (context) => RestaurantDetailsRepo(context.restaurantRepo),
        ),
        ChangeNotifierProxyProvider<RestaurantSearchViewModel,
            RestaurantDetailsViewModel>(
          create: (context) => RestaurantDetailsViewModel(
            context.restaurantDetailsRepo,
            context.restaurantSearchViewModel.selectedResturant!,
          ),
          update: (context, value, previous) => RestaurantDetailsViewModel(
              context.restaurantDetailsRepo, value.selectedResturant!),
        ),
        // ChangeNotifierProxyProvider<FavoritesViewModel,
        //     RestaurantDetailsViewModel>(
        //   create: (context) => RestaurantDetailsViewModel(
        //     context.restaurantDetailsRepo,
        //     context.favoritesViewModel.selectedResturant!,
        //   ),
        //   update: (context, value, previous) => RestaurantDetailsViewModel(
        //       context.restaurantDetailsRepo, value.selectedResturant!),
        // ),

        // ... (Favorties Providers) ...
        Provider<FavoritesRepo>(
          create: (context) => FavoritesRepo(context.restaurantRepo),
        ),
        ChangeNotifierProvider<FavoritesViewModel>(
          create: (context) => FavoritesViewModel(context.favoritesRepo),
        )
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const SearchScreen(),
      ),
    );
  }
}
