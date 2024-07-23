import 'car_model.dart';

class CarsModel {
  final String status;
  List<CarModel> models = [];

  CarsModel({
    required this.status,
    required this.models,
  });

  factory CarsModel.fromJson(Map<String, dynamic> json) {
    return CarsModel(
      status: json['status'] ?? '',
      models: (json['models'] as List).map((e) => CarModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'models': models.map((e) => e.toJson()).toList(),
    };
  }
}
