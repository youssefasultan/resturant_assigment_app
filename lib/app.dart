import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/theme/app_theme.dart';
import 'package:resturant_assigment_app/features/details/data/restaurant_details_repo.dart';
import 'package:resturant_assigment_app/features/search/view/search_screen.dart';

import 'core/data/api/foursquare_api.dart';
import 'core/data/repos/resturant_repo.dart';
import 'features/details/viewmodel/restaurant_details_view_model.dart';
import 'features/search/data/resturant_search_repo.dart';
import 'features/search/viewmodel/resturant_search_view_model.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Core Providers:
        Provider<FoursquareApi>(
          create: (_) => FoursquareApi(),
        ),
        Provider<RestaurantRepo>(
          create: (context) => RestaurantRepo(context.read<FoursquareApi>()),
        ),

        // Feature-Specific Providers:
        // ... (Restaurant Search Providers) ...
        Provider<RestaurantSearchRepo>(
          create: (context) =>
              RestaurantSearchRepo(context.read<RestaurantRepo>()),
        ),

        ChangeNotifierProvider<RestaurantSearchViewModel>(
          create: (context) =>
              RestaurantSearchViewModel(context.read<RestaurantSearchRepo>()),
        ),

        // ... (Restaurant details Providers) ...
        Provider<RestaurantDetailsRepo>(
          create: (context) =>
              RestaurantDetailsRepo(context.read<RestaurantRepo>()),
        ),
        ChangeNotifierProvider<RestaurantDetailsViewModel>(
          create: (context) => RestaurantDetailsViewModel(
            context.read<RestaurantDetailsRepo>(),
            context.read<RestaurantSearchViewModel>().selectedResturant!,
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const SearchScreen(),
      ),
    );
  }
}
