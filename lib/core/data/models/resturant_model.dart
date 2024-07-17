class RestaurantModel {
  final String fsqId;

  final String address;
  final String name;
  List<String>? photosUrl;
  final double long, late;

  RestaurantModel({
    required this.fsqId,
    required this.address,
    required this.name,
    required this.long,
    required this.late,
    this.photosUrl,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      fsqId: json['fsq_id'],
      address: json['location']['formatted_address'],
      name: json['name'],
      long: json['geocodes']['main']['longitude'],
      late: json['geocodes']['main']['latitude'],
    );
  }
}
