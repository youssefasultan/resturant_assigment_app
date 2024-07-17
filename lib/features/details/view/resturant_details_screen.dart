import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/features/details/viewmodel/restaurant_details_view_model.dart';

class ResturantDetailsScreen extends StatelessWidget {
  const ResturantDetailsScreen({super.key});

  static const routeName = '/resturant_details';

  @override
  Widget build(BuildContext context) {
    final data = context.watch<RestaurantDetailsViewModel>();
    final resturant = data.resturantModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          resturant.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.heart,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
