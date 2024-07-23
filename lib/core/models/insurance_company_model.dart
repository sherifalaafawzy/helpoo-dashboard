class InsuranceCompanyModel {
  final int id;
  final String enName;
  final String arName;
  final num packageRequestCount;
  final num packageDiscountPercentage;
  final num maxTotalDiscount;
  final num discountPercentAfterPolicyExpires;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  InsuranceCompanyModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.packageRequestCount,
    required this.packageDiscountPercentage,
    required this.maxTotalDiscount,
    required this.discountPercentAfterPolicyExpires,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InsuranceCompanyModel.fromJson(Map<String, dynamic> json) {
    return InsuranceCompanyModel(
      id: json['id'] ?? 0,
      enName: json['en_name'] ?? '',
      arName: json['ar_name'] ?? '',
      packageRequestCount: json['package_request_count'] ?? 0,
      packageDiscountPercentage: json['package_discount_percentage'] ?? 0,
      maxTotalDiscount: json['max_total_discount'] ?? 0,
      discountPercentAfterPolicyExpires: json['discount_percent_after_policy_expires'] ?? 0,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : DateTime.now(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_name': enName,
      'ar_name': arName,
      'package_request_count': packageRequestCount,
      'package_discount_percentage': packageDiscountPercentage,
      'max_total_discount': maxTotalDiscount,
      'discount_percent_after_policy_expires': discountPercentAfterPolicyExpires,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
