import 'package:flutter/material.dart';
import 'package:resturant_assigment_app/core/extention/context_ext.dart';
import 'package:resturant_assigment_app/core/utils/network_service.dart';
import 'package:resturant_assigment_app/features/favorites/view/favorites_screen.dart';

import 'widgets/map_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    final searchVm = context.restaurantSearchViewModel;

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      searchVm.fetchUserLocation().then(
        (_) async {
          if (!(await NetworkService.isConnected()) && mounted) {
            context.showSnackBar('Please Check Internet Connection');
            setState(() {
              _isLoading = false;
            });
            return;
          }

          searchVm.fetchNearByResturants().then(
            (_) {
              setState(() {
                _isLoading = false;
              });
            },
          );
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Near by Resturants',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.blue,
              ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
              icon: const Text(
                '⭐',
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const Stack(
              children: [
                MapWidget(),
              ],
            ),
    );
  }
}
