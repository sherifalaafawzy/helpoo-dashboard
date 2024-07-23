import 'policy_model.dart';

class PoliciesModel {
  final String status;
  List<PolicyModel> cars = [];

  PoliciesModel({
    required this.status,
    required this.cars,
  });

  factory PoliciesModel.fromJson(Map<String, dynamic> json) {
    return PoliciesModel(
      status: json['status'] ?? '',
      cars: (json['cars'] as List).map((e) => PolicyModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'cars': cars.map((e) => e.toJson()).toList(),
    };
  }
}
