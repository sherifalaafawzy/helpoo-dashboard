class DriversStatsResponseModel {
  String? status;
  Stats? stats;

  DriversStatsResponseModel({this.status, this.stats});

  DriversStatsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
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
        ? new AllDrivers.fromJson(json['allDrivers'])
        : null;
    offlineDrivers = json['offlineDrivers'] != null
        ? new AllDrivers.fromJson(json['offlineDrivers'])
        : null;
    busyDrivers = json['busyDrivers'] != null
        ? new AllDrivers.fromJson(json['busyDrivers'])
        : null;
    freeDrivers = json['freeDrivers'] != null
        ? new AllDrivers.fromJson(json['freeDrivers'])
        : null;
    onlineDrivers = json['onlineDrivers'] != null
        ? new AllDrivers.fromJson(json['onlineDrivers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allDrivers != null) {
      data['allDrivers'] = this.allDrivers!.toJson();
    }
    if (this.offlineDrivers != null) {
      data['offlineDrivers'] = this.offlineDrivers!.toJson();
    }
    if (this.busyDrivers != null) {
      data['busyDrivers'] = this.busyDrivers!.toJson();
    }
    if (this.freeDrivers != null) {
      data['freeDrivers'] = this.freeDrivers!.toJson();
    }
    if (this.onlineDrivers != null) {
      data['onlineDrivers'] = this.onlineDrivers!.toJson();
    }
    return data;
  }
}

class AllDrivers {
  int? count;
  List<Rows>? rows;

  AllDrivers({this.count, this.rows});

  AllDrivers.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
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

  Rows(
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

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offline = json['offline'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    available = json['available'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offline'] = this.offline;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['available'] = this.available;
    data['fcmtoken'] = this.fcmtoken;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['UserId'] = this.userId;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    packagePromoCodeId = json['PackagePromoCodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PhoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['username'] = this.username;
    data['name'] = this.name;
    data['blocked'] = this.blocked;
    data['photo'] = this.photo;
    data['deleted'] = this.deleted;
    data['RoleId'] = this.roleId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['PackagePromoCodeId'] = this.packagePromoCodeId;
    return data;
  }
}

