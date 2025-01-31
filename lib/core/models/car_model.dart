class CarModel {
  final int id;
  final String enName;
  final String arName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int manufacturerId;

  CarModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.createdAt,
    required this.updatedAt,
    required this.manufacturerId,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? 0,
      enName: json['en_name'] ?? '',
      arName: json['ar_name'] ?? '',
      manufacturerId: json['ManufacturerId'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_name': enName,
      'ar_name': arName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'ManufacturerId': manufacturerId,
    };
  }
}
