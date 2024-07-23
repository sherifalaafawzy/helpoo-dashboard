class UploadPdfResponseModel {
  String? status;
  UploadedReportModel? report;

  UploadPdfResponseModel({
    this.status,
    this.report,
  });

  factory UploadPdfResponseModel.fromJson(Map<String, dynamic> json) => UploadPdfResponseModel(
        status: json["status"],
        report: UploadedReportModel.fromJson(json["report"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "report": report!.toJson(),
      };
}

//******************************************************************************************
class UploadedReportModel {
  UploadedReportModel({
    this.active,
    this.id,
    this.report,
    this.accidentReportId,
    this.updatedAt,
    this.createdAt,
  });

  bool? active;
  int? id;
  String? report;
  int? accidentReportId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory UploadedReportModel.fromJson(Map<String, dynamic> json) => UploadedReportModel(
        active: json["active"],
        id: json["id"],
        report: json["report"],
        accidentReportId: json["AccidentReportId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "id": id,
        "report": report,
        "AccidentReportId": accidentReportId,
        "updatedAt": updatedAt!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
      };
}
