import 'car_accident_report_model.dart';
import 'location_model.dart';

import 'insurance_companies_model.dart';

class GetAccidentReportModel {
  final String status;
  final List<AccidentReportModel> accidentReports;
  final int totalData;
  final int totalPages;
  final int currentPage;
  final int totalItems;
  final int unread;

  GetAccidentReportModel({
    required this.status,
    required this.accidentReports,
    required this.totalData,
    required this.totalPages,
    required this.currentPage,
    required this.totalItems,
    required this.unread,
  });

  factory GetAccidentReportModel.fromJson(Map<String, dynamic> json) {
    return GetAccidentReportModel(
      status: json['status'] ?? '',
      accidentReports: json['accidentReports'] != null
          ? (json['accidentReports'] as List)
              .map((e) => AccidentReportModel.fromJson(e))
              .toList()
          : [],
      totalData: json['totaldata'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      totalItems: json['totalItems'] ?? 0,
      unread: json['unread'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'accidentReports': accidentReports.map((e) => e.toJson()).toList(),
      'totaldata': totalData,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'totalItems': totalItems,
      'unread': unread,
    };
  }
}

//******************************************************************************
class AccidentReportModel {
  int? id;
  int? requiredImagesNo;
  int? uploadedImagesCounter;
  String? ref;
  String? comment;
  String? phoneNumber;
  String? client;
  String? repairCost;
  String? commentUser;
  String? status;
  List<String>? statusList;

  String? aiRef;
  LocationModel? location;
  List<String>? billDeliveryDate;
  List<String>? billDeliveryTimeRange;

  List<String>? billDeliveryNotes;
  List<LocationModel>? billDeliveryLocation;
  List<LocationModel>? beforeRepairLocation;
  List<LocationModel>? afterRepairLocation;

  String? video;
  List<String>? bRepairName;
  List<LocationModel>? rightSaveLocation;
  List<LocationModel>? supplementLocation;
  List<LocationModel>? resurveyLocation;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? carId;
  int? createdByUser;
  int? clientId;
  int? insuranceCompanyId;
  InsuranceCompany? insuranceCompany;

  List<CarAccidentReportModel>? carAccidentReports;
  bool? read;

  AccidentReportModel({
    required this.id,
    required this.requiredImagesNo,
    required this.uploadedImagesCounter,
    required this.ref,
    required this.comment,
    required this.phoneNumber,
    required this.insuranceCompany,
    required this.client,
    required this.repairCost,
    required this.commentUser,
    required this.status,
    required this.statusList,
    required this.aiRef,
    required this.location,
    required this.billDeliveryDate,
    required this.billDeliveryTimeRange,
    required this.billDeliveryNotes,
    required this.billDeliveryLocation,
    required this.beforeRepairLocation,
    required this.afterRepairLocation,
    required this.video,
    required this.bRepairName,
    required this.rightSaveLocation,
    required this.supplementLocation,
    required this.resurveyLocation,
    required this.createdAt,
    required this.updatedAt,
    required this.carId,
    required this.createdByUser,
    required this.clientId,
    required this.insuranceCompanyId,
    required this.carAccidentReports,
    required this.read,
  });

  factory AccidentReportModel.fromJson(Map<String, dynamic> json) {
    return AccidentReportModel(
      id: json['id'] ?? 0,
      requiredImagesNo: json['requiredImagesNo'] ?? 0,
      uploadedImagesCounter: json['uploadedImagesCounter'] ?? 0,
      ref: json['ref'] ?? '',
      comment: json['comment'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      client: json['client'] ?? '',
      repairCost: json['repairCost'] ?? '',
      commentUser: json['commentUser'] ?? '',
      status: json['status'] ?? '',
       insuranceCompany : json['insuranceCompany'] != null
        ?  InsuranceCompany.fromJson(json['insuranceCompany'])
        : null,
      statusList: json['statusList'] != null
          ? (json['statusList'] as List).map((e) => e.toString()).toList()
          : null,
      aiRef: json['aiRef'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      billDeliveryDate: json['billDeliveryDate'] != null
          ? (json['billDeliveryDate'] as List).map((e) => e.toString()).toList()
          : null,
      billDeliveryTimeRange: json['billDeliveryTimeRange'] != null
          ? (json['billDeliveryTimeRange'] as List)
              .map((e) => e.toString())
              .toList()
          : null,
      billDeliveryNotes: json['billDeliveryNotes'] != null
          ? (json['billDeliveryNotes'] as List)
              .map((e) => e.toString())
              .toList()
          : null,
      billDeliveryLocation: json['billDeliveryLocation'] != null
          ? (json['billDeliveryLocation'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : null,
      beforeRepairLocation: json['beforeRepairLocation'] != null
          ? (json['beforeRepairLocation'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : null,
      afterRepairLocation: json['afterRepairLocation'] != null
          ? (json['afterRepairLocation'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : null,
      video: json['video'] ?? '',
      bRepairName: json['bRepairName'] != null
          ? (json['bRepairName'] as List).map((e) => e.toString()).toList()
          : null,
      rightSaveLocation: json['rightSaveLocation'] != null
          ? (json['rightSaveLocation'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : null,
      supplementLocation: json['supplementLocation'] != null
          ? (json['supplementLocation'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : null,
      resurveyLocation: json['resurveyLocation'] != null
          ? (json['resurveyLocation'] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList()
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      carId: json['carId'] ?? 0,
      createdByUser: json['createdByUser'] ?? 0,
      clientId: json['clientId'] ?? 0,
      insuranceCompanyId: json['insuranceCompanyId'] ?? 0,
      carAccidentReports: json['CarAccidentReports'] != null
          ? (json['CarAccidentReports'] as List)
              .map((e) => CarAccidentReportModel.fromJson(e))
              .toList()
          : null,
      read: json['read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'requiredImagesNo': requiredImagesNo,
      'uploadedImagesCounter': uploadedImagesCounter,
      'ref': ref,
      'comment': comment,
      'phoneNumber': phoneNumber,
      'client': client,
      'repairCost': repairCost,
      'commentUser': commentUser,
      'status': status,
      'statusList': statusList,
      'aiRef': aiRef,
      'location': location?.toJson(),
      'billDeliveryDate': billDeliveryDate,
      'billDeliveryTimeRange': billDeliveryTimeRange,
      'billDeliveryNotes': billDeliveryNotes,
 
      'billDeliveryLocation':
          billDeliveryLocation?.map((e) => e.toJson()).toList(),
      'beforeRepairLocation':
          beforeRepairLocation?.map((e) => e.toJson()).toList(),
      'afterRepairLocation':
          afterRepairLocation?.map((e) => e.toJson()).toList(),
      'video': video,
      'bRepairName': bRepairName,
      'rightSaveLocation': rightSaveLocation?.map((e) => e.toJson()).toList(),
      'supplementLocation': supplementLocation?.map((e) => e.toJson()).toList(),
      'resurveyLocation': resurveyLocation?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'carId': carId,
      'createdByUser': createdByUser,
      'clientId': clientId,
      'insuranceCompanyId': insuranceCompanyId,
      'CarAccidentReports': carAccidentReports?.map((e) => e.toJson()).toList(),
      'read': read,
    };
  }
}
