class LocationModel {
  final double lat;
  final double lng;
  final String address;
  String? name;

  LocationModel({
    required this.lat,
    required this.lng,
    required this.address,
    this.name,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json['lat'] ?? 0.0,
      lng: json['lng'] ?? 0.0,
      address: json['address'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'address': address,
      'name': name,
    };
  }
}
