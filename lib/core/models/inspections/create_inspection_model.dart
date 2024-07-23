import 'package:dio/dio.dart';

class CreateInspectionModel {
  final String clientName;
  final String government;
  final String city;
  final String area;
  final String addressInfo;
  final String carBrand;
  final String carModel;
  final String vinNumber;
  final String engineNumber;
  final String plateNumber;
  final String accidentDescription;
  final String exceptions;
  final String inspectorId;
  final String type;
  final String date;
  final String notes;
  final String insuranceCompanyId;
  final FormData insuranceImages;

  CreateInspectionModel({
    required this.clientName,
    required this.government,
    required this.city,
    required this.area,
    required this.addressInfo,
    required this.carBrand,
    required this.carModel,
    required this.vinNumber,
    required this.engineNumber,
    required this.plateNumber,
    required this.accidentDescription,
    required this.exceptions,
    required this.inspectorId,
    required this.type,
    required this.date,
    required this.notes,
    required this.insuranceCompanyId,
    required this.insuranceImages,
  });

  factory CreateInspectionModel.fromJson(Map<String, dynamic> json) {
    return CreateInspectionModel(
      clientName: json['clientName'] ?? '',
      government: json['government'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      addressInfo: json['addressInfo'] ?? '',
      carBrand: json['carBrand'] ?? '',
      carModel: json['carModel'] ?? '',
      vinNumber: json['vinNumber'] ?? '',
      engineNumber: json['engineNumber'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      accidentDescription: json['accidentDescription'] ?? '',
      exceptions: json['exceptions'] ?? '',
      inspectorId: json['inspectorId'] ?? '',
      type: json['type'] ?? '',
      date: json['date'] ?? '',
      notes: json['notes'] ?? '',
      insuranceCompanyId: json['insuranceCompanyId'] ?? '',
      insuranceImages: json['insuranceImages'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'government': government,
      'city': city,
      'area': area,
      'addressInfo': addressInfo,
      'carBrand': carBrand,
      'carModel': carModel,
      'vinNumber': vinNumber,
      'engineNumber': engineNumber,
      'plateNumber': plateNumber,
      'accidentDescription': accidentDescription,
      'exceptions': exceptions,
      'inspectorId': inspectorId,
      'type': type,
      'date': date,
      'notes': notes,
      'insuranceCompanyId': insuranceCompanyId,
      'insuranceImages': insuranceImages,
    };
  }
}

