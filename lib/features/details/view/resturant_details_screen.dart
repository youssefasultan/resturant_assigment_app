import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';
import 'package:resturant_assigment_app/core/extention/context_ext.dart';
import 'package:resturant_assigment_app/features/details/view/widgets/details_container.dart';
import 'package:resturant_assigment_app/features/details/view/widgets/favorite_button.dart';
import 'package:resturant_assigment_app/features/details/view/widgets/image_view.dart';
import 'package:resturant_assigment_app/features/details/viewmodel/restaurant_details_view_model.dart';

class ResturantDetailsScreen extends StatefulWidget {
  const ResturantDetailsScreen({super.key, this.restaurant});

  static const routeName = '/resturant_details';
  final RestaurantModel? restaurant;

  @override
  State<ResturantDetailsScreen> createState() => _ResturantDetailsScreenState();
}

class _ResturantDetailsScreenState extends State<ResturantDetailsScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit && widget.restaurant == null) {
      setState(() {
        _isLoading = true;
      });
      final vm = context.restaurantDetailsViewModel;

      vm.getRestaurantPhotos(vm.resturantModel.fsqId).then(
        (value) {
          setState(() {
            _isLoading = false;
          });
        },
      ).onError(
        (error, stackTrace) {
          context.showSnackBar('No Photos Found');
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
    final resturant = widget.restaurant ??
        context.watch<RestaurantDetailsViewModel>().resturantModel;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          resturant.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          FavoriteButton(restaurant: resturant),
        ],
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // show images if any
                if (resturant.photosUrl != null &&
                    resturant.photosUrl!.isNotEmpty)
                  ImageView(resturant: resturant),
                const SizedBox(height: 16),
                // restaurant details
                Expanded(
                  child: DetailsContainer(resturant: resturant),
                ),
              ],
            ),
    );
  }
}
