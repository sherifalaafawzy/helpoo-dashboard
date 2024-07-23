import 'package:intl/intl.dart';

class CorporateUsersModel {
  String? status;
  List<CorporateUsers>? users;

  CorporateUsersModel({this.status, this.users});

  CorporateUsersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['users'] != null) {
      users = <CorporateUsers>[];
      json['users'].forEach((v) {
        users!.add(CorporateUsers.fromJson(v));
      });
    } else {
      users = <CorporateUsers>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CorporateUsers {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? corporateCompanyId;
  User? user;

  CorporateUsers(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.corporateCompanyId,
      this.user});

  CorporateUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    corporateCompanyId = json['CorporateCompanyId'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['UserId'] = userId;
    data['CorporateCompanyId'] = corporateCompanyId;
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
  int? roleId;
  String? createdAt;
  String? updatedAt;
  int? packagePromoCodeId;

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
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.packagePromoCodeId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    phoneNumber = json['PhoneNumber'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    username = json['username'] ?? "";
    name = json['name'] ?? "";
    blocked = json['blocked'] ?? false;
    photo = json['photo'] ?? "";
    deleted = json['deleted'] ?? false;
    roleId = json['RoleId'] ?? 0;
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'] ?? "";
    packagePromoCodeId = json['PackagePromoCodeId'] ?? 0;
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
    data['RoleId'] = roleId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['PackagePromoCodeId'] = packagePromoCodeId;
    return data;
  }
}
