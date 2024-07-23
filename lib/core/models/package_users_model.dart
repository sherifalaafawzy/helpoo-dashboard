import 'package:intl/intl.dart';

class PackageUsersModel {
  String? status;
  List<Clients>? clients;

  PackageUsersModel({this.status, this.clients});

  PackageUsersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clients {
  int? id;
  bool? active;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  int? packageId;
  int? clientId;
  PackageClient? client;

  Clients(
      {this.id,
      this.active,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.packageId,
      this.clientId,
      this.client});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'];
    packageId = json['PackageId'];
    clientId = json['ClientId'];
    client =
        json['Client'] != null ? PackageClient.fromJson(json['Client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['PackageId'] = packageId;
    data['ClientId'] = clientId;
    if (client != null) {
      data['Client'] = client!.toJson();
    }
    return data;
  }
}

class PackageClient {
  int? id;
  bool? active;
  String? fcmtoken;
  String? createdAt;
  String? updatedAt;
  int? userId;
  PackageUser? user;

  PackageClient(
      {this.id,
      this.active,
      this.fcmtoken,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.user});

  PackageClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    user = json['User'] != null ? PackageUser.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['fcmtoken'] = fcmtoken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['UserId'] = userId;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}

class PackageUser {
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

  PackageUser(
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
      this.updatedAt});

  PackageUser.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    return data;
  }
}
