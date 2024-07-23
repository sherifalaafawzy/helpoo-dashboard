import 'package:intl/intl.dart';

class NormalPromoCodeUsers {
  String? status;
  List<PromoCodeUsers>? users;

  NormalPromoCodeUsers({this.status, this.users});

  NormalPromoCodeUsers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['users'] != null) {
      users = <PromoCodeUsers>[];
      json['users'].forEach((v) {
        users!.add(PromoCodeUsers.fromJson(v));
      });
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

class PromoCodeUsers {
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

  PromoCodeUsers(
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

  PromoCodeUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['PhoneNumber'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    name = json['name'];
    blocked = json['blocked'];
    photo = json['photo'];
    deleted = json['deleted'];
    roleId = json['RoleId'];
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'];
    packagePromoCodeId = json['PackagePromoCodeId'];
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
