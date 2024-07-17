import 'package:resturant_assigment_app/core/data/models/resturant_model.dart';

class FoursquareResponse {
  final List<RestaurantModel> venues;

  FoursquareResponse({
    required this.venues,
  });

  factory FoursquareResponse.fromJson(Map<String, dynamic> json) {
    return FoursquareResponse(
      venues: (json['results'] as List)
          .map((venue) => RestaurantModel.fromJson(venue))
          .toList(),
    );
  }
}
