class CarAccidentReportModel {
  int id;
  String report;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int AccidentReportId;
  int? pdfReportId;


  CarAccidentReportModel({
    required this.id,
    required this.report,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.AccidentReportId,
    required this.pdfReportId,
  });

  factory CarAccidentReportModel.fromJson(Map<String, dynamic> json) {
    return CarAccidentReportModel(
      id: json['id'],
      report: json['report'],
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      AccidentReportId: json['AccidentReportId'] ?? 0,
      pdfReportId: json['pdfReportId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report': report,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'AccidentReportId': AccidentReportId,
      'pdfReportId': pdfReportId,
    };
  }
}
