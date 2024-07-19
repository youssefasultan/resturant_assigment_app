class RestaurantModel {
  final String fsqId;
  final String address;
  final String name;
  List<String>? photosUrl;
  List<String>? categories;
  final double long, late;

  RestaurantModel({
    required this.fsqId,
    required this.address,
    required this.name,
    required this.long,
    required this.late,
    this.categories,
    this.photosUrl,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      fsqId: json['fsq_id'],
      address: json['location']['address'],
      name: json['name'],
      long: json['geocodes']['main']['longitude'],
      late: json['geocodes']['main']['latitude'],
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e['short_name'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fsq_id': fsqId,
      'address': address,
      'name': name,
      'long': long,
      'late': late,
      'photosUrl': photosUrl,
      'categories': categories,
    };
  }

  factory RestaurantModel.fromJsonEncode(Map<String, dynamic> json) {
    return RestaurantModel(
      fsqId: json['fsq_id'],
      address: json['address'],
      name: json['name'],
      long: json['long'],
      late: json['late'],
      photosUrl: List<String>.from(json['photosUrl'] ?? []),
      categories: List<String>.from(json['categories'] ?? []),
    );
  }
}
