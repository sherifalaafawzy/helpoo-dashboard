import 'package:intl/intl.dart';

class DriversStatisticsModel {
  String? status;
  Stats? stats;

  DriversStatisticsModel({this.status, this.stats});

  DriversStatisticsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }
}

class Stats {
  AllDrivers? allDrivers;
  AllDrivers? offlineDrivers;
  AllDrivers? busyDrivers;
  AllDrivers? freeDrivers;
  AllDrivers? onlineDrivers;

  Stats(
      {this.allDrivers,
      this.offlineDrivers,
      this.busyDrivers,
      this.freeDrivers,
      this.onlineDrivers});

  Stats.fromJson(Map<String, dynamic> json) {
    allDrivers = json['allDrivers'] != null
        ? AllDrivers.fromJson(json['allDrivers'])
        : null;
    offlineDrivers = json['offlineDrivers'] != null
        ? AllDrivers.fromJson(json['offlineDrivers'])
        : null;
    busyDrivers = json['busyDrivers'] != null
        ? AllDrivers.fromJson(json['busyDrivers'])
        : null;
    freeDrivers = json['freeDrivers'] != null
        ? AllDrivers.fromJson(json['freeDrivers'])
        : null;
    onlineDrivers = json['onlineDrivers'] != null
        ? AllDrivers.fromJson(json['onlineDrivers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allDrivers != null) {
      data['allDrivers'] = allDrivers!.toJson();
    }
    if (offlineDrivers != null) {
      data['offlineDrivers'] = offlineDrivers!.toJson();
    }
    if (busyDrivers != null) {
      data['busyDrivers'] = busyDrivers!.toJson();
    }
    if (freeDrivers != null) {
      data['freeDrivers'] = freeDrivers!.toJson();
    }
    if (onlineDrivers != null) {
      data['onlineDrivers'] = onlineDrivers!.toJson();
    }
    return data;
  }
}

class AllDrivers {
  int? count;
  List<DriverStatisticsModel>? rows;

  AllDrivers({this.count, this.rows});

  AllDrivers.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <DriverStatisticsModel>[];
      json['rows'].forEach((v) {
        rows!.add(DriverStatisticsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DriverStatisticsModel {
  int? id;
  bool? offline;
  String? averageRating;
  int? ratingCount;
  Location? location;
  bool? available;
  String? fcmtoken;
  String? createdAt;
  String? updatedAt;
  int? userId;
  User? user;

  DriverStatisticsModel(
      {this.id,
      this.offline,
      this.averageRating,
      this.ratingCount,
      this.location,
      this.available,
      this.fcmtoken,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.user});

  DriverStatisticsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offline = json['offline'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    available = json['available'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offline'] = offline;
    data['average_rating'] = averageRating;
    data['rating_count'] = ratingCount;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['available'] = available;
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

class Location {
  String? heading;
  double? latitude;
  double? longitude;

  Location({this.heading, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
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
