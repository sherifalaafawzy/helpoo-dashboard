import 'car_model.dart';
import 'client_model.dart';
import 'insurance_company_model.dart';
import 'manufacturer_model.dart';

class PolicyModel {
  final int id;
  final String plateNumber;
  final int year;
  final String policyNumber;
  final DateTime policyStarts;
  final DateTime policyEnds;
  final String appendixNumber;
  final String vinNumber;
  final bool policyCanceled;
  final String color;
  final String frontLicense;
  final String backLicense;
  final int createdBy;
  final int manufacturerId;
  final int carModelId;
  final int clientId;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final int insuranceCompanyId;
  final ManufacturerModel? manufacturer;
  final CarModel? carModel;
  final InsuranceCompanyModel? insuranceCompanyModel;
  final ClientModel? client;

  PolicyModel({
    required this.id,
    required this.plateNumber,
    required this.year,
    required this.policyNumber,
    required this.policyStarts,
    required this.policyEnds,
    required this.appendixNumber,
    required this.vinNumber,
    required this.policyCanceled,
    required this.color,
    required this.frontLicense,
    required this.backLicense,
    required this.createdBy,
    required this.manufacturerId,
    required this.carModelId,
    required this.clientId,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.insuranceCompanyId,
    required this.manufacturer,
    required this.carModel,
    required this.insuranceCompanyModel,
    required this.client,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      id: json['id'] ?? 0,
      plateNumber: json['plateNumber'] ?? '',
      year: json['year'] ?? 0,
      policyNumber: json['policyNumber'] ?? '',
      policyStarts: json['policyStarts'] != null ? DateTime.parse(json['policyStarts']) : DateTime.now(),
      policyEnds: json['policyEnds'] != null ? DateTime.parse(json['policyEnds']) : DateTime.now(),
      appendixNumber: json['appendix_number'] ?? '',
      vinNumber: json['vin_number'] ?? '',
      policyCanceled: json['policyCanceled'] ?? false,
      color: json['color'] ?? '',
      frontLicense: json['frontLicense'] ?? '',
      backLicense: json['backLicense'] ?? '',
      createdBy: json['CreatedBy'] ?? 0,
      manufacturerId: json['ManufacturerId'] ?? 0,
      carModelId: json['CarModelId'] ?? 0,
      clientId: json['ClientId'] ?? 0,
      active: json['active'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : DateTime.now(),
      insuranceCompanyId: json['InsuranceCompanyId'] ?? 0,
      manufacturer: json['Manufacturer'] != null ? ManufacturerModel.fromJson(json['Manufacturer']) : null,
      carModel: json['CarModel'] != null ? CarModel.fromJson(json['CarModel']) : null,
      insuranceCompanyModel: json['insuranceCompany'] != null ? InsuranceCompanyModel.fromJson(json['insuranceCompany']) : null,
      client: json['Client'] != null ? ClientModel.fromJson(json['Client']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'year': year,
      'policyNumber': policyNumber,
      'policyStarts': policyStarts.toIso8601String(),
      'policyEnds': policyEnds.toIso8601String(),
      'appendix_number': appendixNumber,
      'vin_number': vinNumber,
      'policyCanceled': policyCanceled,
      'color': color,
      'frontLicense': frontLicense,

      'backLicense': backLicense,
      'CreatedBy': createdBy,
      'ManufacturerId': manufacturerId,
      'CarModelId': carModelId,
      'ClientId': clientId,
      'active': active,

      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt.toIso8601String(),

      'insuranceCompanyId': insuranceCompanyId,
      'manufacturer': manufacturer?.toJson(),
      'carModel': carModel?.toJson(),
      'insuranceCompanyModel': insuranceCompanyModel?.toJson(),
      'client': client?.toJson(),
    };
  }
}
