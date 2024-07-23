class DriversModel {
  final String status;
  List<DriverModel> drivers = [];

  DriversModel({
    required this.status,
    required this.drivers,
  });

  factory DriversModel.fromJson(Map<String, dynamic> json) {
    return DriversModel(
      status: json['status'] ?? '',
      drivers: (json['drivers'] as List)
          .map((e) => DriverModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'drivers': drivers.map((e) => e.toJson()).toList(),
    };
  }
}

class DriverModel {
  final int id;
  final bool offline;
  final bool available;
  final num latitude;
  final num longitude;
  final User? user;
  num? distance;
  String? duration;

  DriverModel({
    required this.id,
    required this.offline,
    required this.available,
    required this.latitude,
    required this.longitude,
    this.user,
    this.distance,
    this.duration,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? 0,
      offline: json['offline'] ?? false,
      available: json['available'] ?? false,
      latitude:
          json['location'] != null ? json['location']['latitude'] ?? 0.0 : 0.0,
      longitude:
          json['location'] != null ? json['location']['longitude'] ?? 0.0 : 0.0,
      user: json['User'] != null ? User.fromJson(json['User']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offline': offline,
      'available': available,
      'latitude': latitude,
      'longitude': longitude,
      'User': user != null ? user!.toJson() : null,
    };
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
    id = json['id'] ?? 0;
    phoneNumber = json['PhoneNumber'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    username = json['username'] ?? '';
    name = json['name'] ?? '';
    blocked = json['blocked'] ?? false;
    photo = json['photo'] ?? '';
    deleted = json['deleted'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    roleId = json['RoleId'] ?? 0;
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
