class DriversMapModel {
  String? status;
  List<Drivers>? drivers;

  DriversMapModel({this.status, this.drivers});

  DriversMapModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    if (json['drivers'] != null) {
      drivers = <Drivers>[];
      json['drivers'].forEach((v) {
        drivers!.add(Drivers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (drivers != null) {
      data['drivers'] = drivers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drivers {
  Driver? driver;
  List<CarServiceTypes>? carServiceTypes;
  Vehicle? vehicle;

  Drivers({this.driver, this.carServiceTypes, this.vehicle});

  Drivers.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    if (json['CarServiceTypes'] != null) {
      carServiceTypes = <CarServiceTypes>[];
      json['CarServiceTypes'].forEach((v) {
        carServiceTypes!.add(CarServiceTypes.fromJson(v));
      });
    }
    vehicle =
        json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (carServiceTypes != null) {
      data['CarServiceTypes'] =
          carServiceTypes!.map((v) => v.toJson()).toList();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    return data;
  }
}

class Driver {
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

  Driver(
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

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    offline = json['offline'] ?? false;
    averageRating = json['average_rating'] ?? '';
    ratingCount = json['rating_count'] ?? 0;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    available = json['available'] ?? false;
    fcmtoken = json['fcmtoken'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    userId = json['UserId'] ?? 0;
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
    heading = json['heading'].toString();
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

class CarServiceTypes {
  int? id;
  String? enName;
  String? arName;
  int? baseCost;
  int? costPerKm;
  String? createdAt;
  String? updatedAt;
  int? carType;
  VehicleServiceTypes? vehicleServiceTypes;

  CarServiceTypes(
      {this.id,
      this.enName,
      this.arName,
      this.baseCost,
      this.costPerKm,
      this.createdAt,
      this.updatedAt,
      this.carType,
      this.vehicleServiceTypes});

  CarServiceTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    baseCost = json['base_cost'] ?? 0;
    costPerKm = json['cost_per_km'] ?? 0;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    carType = json['car_type'] ?? 0;
    vehicleServiceTypes = json['VehicleServiceTypes'] != null
        ? VehicleServiceTypes.fromJson(json['VehicleServiceTypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['base_cost'] = baseCost;
    data['cost_per_km'] = costPerKm;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['car_type'] = carType;
    if (vehicleServiceTypes != null) {
      data['VehicleServiceTypes'] = vehicleServiceTypes!.toJson();
    }
    return data;
  }
}

class VehicleServiceTypes {
  String? createdAt;
  String? updatedAt;
  int? vehicleId;
  int? carServiceTypeId;

  VehicleServiceTypes(
      {this.createdAt, this.updatedAt, this.vehicleId, this.carServiceTypeId});

  VehicleServiceTypes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    vehicleId = json['VehicleId'] ?? 0;
    carServiceTypeId = json['CarServiceTypeId'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['VehicleId'] = vehicleId;
    data['CarServiceTypeId'] = carServiceTypeId;
    return data;
  }
}

class Vehicle {
  String? vecPlate;
  String? vecName;
  int? vecNum;
  String? vecTypeName;
  int? vecType;
  String? url;

  Vehicle(
      {this.vecPlate,
      this.vecName,
      this.vecNum,
      this.vecTypeName,
      this.vecType,
      this.url});

  Vehicle.fromJson(Map<String, dynamic> json) {
    vecPlate = json['Vec_plate'] ?? '';
    vecName = json['Vec_name'] ?? '';
    vecNum = json['Vec_num'] ?? 0;
    vecTypeName = json['Vec_type_name'] ?? '';
    vecType = json['Vec_type'] ?? 0;
    url = json['url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Vec_plate'] = vecPlate;
    data['Vec_name'] = vecName;
    data['Vec_num'] = vecNum;
    data['Vec_type_name'] = vecTypeName;
    data['Vec_type'] = vecType;
    data['url'] = url;
    return data;
  }
}
