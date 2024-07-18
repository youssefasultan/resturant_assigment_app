import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resturant_assigment_app/core/constants/api_constants.dart';
import 'package:resturant_assigment_app/core/data/models/response.dart';

class FoursquareApi {
  Future<List<String>> getRestaurantPhotos(String id) async {
    try {
      final url = Uri.parse('${ApiConstanst.baseUrl}/places/$id/photos');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': ApiConstanst.apiKey,
      });

      if (response.statusCode != 200) {
        throw Exception(
            'Foursquare Place Search API request failed: ${response.statusCode}');
      }

      final jsonData = jsonDecode(response.body) as List<dynamic>;

      return jsonData
          .map(
            (e) => '${e['prefix']}600x400${e['suffix']}',
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<FoursquareResponse> getNearbyRestaurants(
      {required double latitude,
      required double longitude,
      int radius = 1000}) async {
    try {
      final queryParams = {
        'll': '$latitude,$longitude',
        'radius': radius.toString(),
        'limit': '20',
        'categories': '13065',
      };

      final url = Uri.parse('${ApiConstanst.baseUrl}/places/search').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': ApiConstanst.apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Foursquare Place Search API request failed: ${response.statusCode}');
      }

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      return FoursquareResponse.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }
}
