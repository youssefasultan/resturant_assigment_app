import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:resturant_assigment_app/core/constants/strorage_constants.dart';
import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';

class LocalStorage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<List<RestaurantModel>> fetchAllFavorites() async {
    try {
      final response = await storage.read(key: StrorageConstants.favoritesKey);

      if (response == null) {
        throw Exception('No favorites found');
      }

      final result = jsonDecode(response) as List<dynamic>;

      return result.map((e) => RestaurantModel.fromJsonEncode(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFavorites(List<RestaurantModel> restaurants) async {
    try {
      await storage.write(
        key: StrorageConstants.favoritesKey,
        value: jsonEncode(restaurants),
      );
    } catch (e) {
      rethrow;
    }
  }
}
