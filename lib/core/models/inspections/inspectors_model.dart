import '../insurance_companies_model.dart';

class InspectorsModel {
  String? status;
  List<Inspector>? inspectors;

  InspectorsModel({this.status, this.inspectors});

  InspectorsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['inspectors'] != null) {
      inspectors = <Inspector>[];
      json['inspectors'].forEach((v) {
        inspectors!.add(Inspector.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (inspectors != null) {
      data['inspectors'] = inspectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inspector {
  int? id;
  String? fcmtoken;
  int? userId;
  int? insuranceCompanyId;
  int? createdByInsurance;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? phoneNumbers;
  List<String>? emails;
  User? user;
  InsuranceCompany? insuranceCompany;

  Inspector({
    this.id,
    this.fcmtoken,
    this.userId,
    this.insuranceCompanyId,
    this.createdByInsurance,
    this.createdAt,
    this.updatedAt,
    this.phoneNumbers,
    this.emails,
    this.user,
    this.insuranceCompany,
  });

  Inspector.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fcmtoken = json['fcmtoken'] ?? '';
    userId = json['UserId'];
    insuranceCompanyId = json['InsuranceCompanyId'];
    createdByInsurance = json['CreatedByInsurance'];
    createdAt = DateTime.tryParse(json['createdAt']);
    updatedAt = DateTime.tryParse(json['updatedAt']);
    phoneNumbers = json['phoneNumbers'] != null
        ? List<String>.from(json['phoneNumbers'])
        : null;
    emails = json['emails'] != null ? List<String>.from(json['emails']) : null;
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fcmtoken'] = fcmtoken;
    data['UserId'] = userId;
    data['InsuranceCompanyId'] = insuranceCompanyId;
    data['CreatedByInsurance'] = createdByInsurance;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (phoneNumbers != null) {
      data['phoneNumbers'] = phoneNumbers;
    }
    if (emails != null) {
      data['emails'] = emails;
    }
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? phoneNumber;
  String? email;
  String? password;
  String? username;
  String? name;
  bool? blocked;
  String? photo;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? roleId;

  User(
      {this.id,
      this.phoneNumber,
      this.email,
      this.password,
      this.username,
      this.name,
      this.blocked,
      this.photo,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.roleId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['PhoneNumber'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    name = json['name'];
    blocked = json['blocked'];
    photo = json['photo'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    roleId = json['RoleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['PhoneNumber'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['username'] = username;
    data['name'] = name;
    data['blocked'] = blocked;
    data['photo'] = photo;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['RoleId'] = roleId;
    return data;
  }
}
