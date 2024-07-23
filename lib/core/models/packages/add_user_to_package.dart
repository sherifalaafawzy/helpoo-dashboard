import '../package_bulk_user_model.dart';

class AddUserToPackageResponse {
  String? status;
  AddUserToPackageResponseDate? data;

  AddUserToPackageResponse({
    this.status,
    this.data,
  });

  AddUserToPackageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AddUserToPackageResponseDate.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data,
    };
  }
}

//**************************************************************************
class AddUserToPackageResponseDate {
  int? successCount;
  int? failureCount;
  List<PackageBulkUserModel>? failedRows;

  AddUserToPackageResponseDate({
    this.successCount,
    this.failureCount,
    this.failedRows,
  });

  AddUserToPackageResponseDate.fromJson(Map<String, dynamic> json) {
    successCount = json['successCount'];
    failureCount = json['failureCount'];
    failedRows = json['failedRows'] != null
        ? (json['failedRows'] as List).map((i) => PackageBulkUserModel.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'successCount': successCount,
      'failureCount': failureCount,
      'failedRows': failedRows!.map((e) => e.toJson()).toList(),
    };
  }
}