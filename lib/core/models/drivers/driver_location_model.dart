// ignore_for_file: public_member_api_docs, sort_constructors_first
class DriverLocationModel {
  final double clientLatitude;
  final double clientLongitude;
  DriverLocationModel({
    required this.clientLatitude,
    required this.clientLongitude,
  });

  DriverLocationModel.fromJson(Map<String, dynamic> json)
      : clientLatitude = json['clientLatitude'],
        clientLongitude = json['clientLongitude'];

  Map<String, dynamic> toJson() => {
        'clientLatitude': clientLatitude,
        'clientLongitude': clientLongitude,
      };
}
