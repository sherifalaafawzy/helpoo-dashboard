import 'manufacturer_model.dart';

class ManufacturersModel {
  final String status;
  List<ManufacturerModel> manufacturers = [];

  ManufacturersModel({
    required this.status,
    required this.manufacturers,
  });

  factory ManufacturersModel.fromJson(Map<String, dynamic> json) {
    return ManufacturersModel(
      status: json['status'] ?? '',
      manufacturers: (json['manufacturers'] as List).map((e) => ManufacturerModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'manufacturers': manufacturers.map((e) => e.toJson()).toList(),
    };
  }
}
