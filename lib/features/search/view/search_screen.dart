import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../viewmodel/resturant_search_view_model.dart';
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
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final searchVm = context.read<RestaurantSearchViewModel>();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      searchVm.fetchUserLocation().then(
        (_) {
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.list,
              color: Colors.blue,
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
