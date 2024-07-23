import 'corporate_company_model.dart';
import 'insurance_company_model.dart';
import 'role_model.dart';

class UserModel {
  final int id;
  final int userId;
  final String username;
  final bool active;
  final int insuranceCompanyId;
  final int? InspectionCompanyId;
  final InsuranceCompanyModel? insuranceCompany;
  final String phoneNumber;
  final String name;
  final String email;
  final int roleId;
  final String roleName;
  final String photo;
  final RoleModel? role;
  final bool blocked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? corporateCompanyId;
  final CorporateCompanyModel? corporateCompany;

  UserModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.active,
    required this.insuranceCompanyId,
    this.InspectionCompanyId,
    required this.insuranceCompany,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.roleId,
    required this.roleName,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.role,
    this.corporateCompanyId,
    this.corporateCompany,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      userId: json['UserId'] ?? 0,
      username: json['username'] ?? '',
      active: json['active'] ?? false,
      insuranceCompanyId: json['insuranceCompanyId'] ?? 0,
      InspectionCompanyId: json['InspectionCompanyId'] ?? 0,
      insuranceCompany: json['insuranceCompany'] != null
          ? InsuranceCompanyModel.fromJson(json['insuranceCompany'])
          : null,
      phoneNumber: json['PhoneNumber'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      roleId: json['RoleId'] ?? 0,
      roleName: json['RoleName'] ?? '',
      blocked: json['blocked'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      photo: json['photo'] ?? '',
      role: json['role'] != null ? RoleModel.fromJson(json['role']) : null,
      corporateCompanyId: json['corporateCompanyId'] ?? 0,
      corporateCompany: json['CorporateCompany'] != null
          ? CorporateCompanyModel.fromJson(json['CorporateCompany'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'UserId': userId,
      'username': username,
      'active': active,
      'insuranceCompanyId': insuranceCompanyId,
      'InspectionCompanyId': InspectionCompanyId,
      'insuranceCompany': insuranceCompany?.toJson(),
      'PhoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'RoleId': roleId,
      'RoleName': roleName,
      'blocked': blocked,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'photo': photo,
      'role': role?.toJson(),
    };
  }
}
