class CalculateFeesModel {
  String status;
  num euroOriginalFees;
  num euroFees;
  num euroPercentage;
  num normalOriginalFees;
  num normalFees;
  num normalPercentage;

  CalculateFeesModel({
    required this.status,
    required this.euroOriginalFees,
    required this.euroFees,
    required this.euroPercentage,
    required this.normalOriginalFees,
    required this.normalFees,
    required this.normalPercentage,
  });

  factory CalculateFeesModel.fromJson(Map<String, dynamic> json) {
    return CalculateFeesModel(
      status: json['status'] ?? '',
      euroOriginalFees: json['EuroOriginalFees'] ?? 0,
      euroFees: json['EuroFees'] ?? 0,
      euroPercentage: json['EuroPercent'] ?? 0,
      normalOriginalFees: json['NormOriginalFees'] ?? 0,
      normalFees: json['NormFees'] ?? 0,
      normalPercentage: json['NormPercent'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'EuroOriginalFees': euroOriginalFees,
      'EuroFees': euroFees,
      'EuroPercent': euroPercentage,
      'NormOriginalFees': normalOriginalFees,
      'NormFees': normalFees,
      'NormPercent': normalPercentage,
    };
  }
}
