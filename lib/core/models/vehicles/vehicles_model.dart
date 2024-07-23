class VehiclesModel {
  String? status;
  List<Vehicles>? vehicles;

  VehiclesModel({this.status, this.vehicles});

  VehiclesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (vehicles != null) {
      data['vehicles'] = vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  int? id;
  String? vecPlate;
  String? vecName;
  int? vecNum;
  String? phoneNumber;
  String? iMEI;
  bool? available;
  String? url;
  String? createdAt;
  String? updatedAt;
  int? activeDriver;
  int? vecType;
  Driver? driver;
  VehicleType? vehicleType;
  List<CarServiceTypes>? carServiceTypes;

  Vehicles(
      {this.id,
      this.vecPlate,
      this.vecName,
      this.vecNum,
      this.phoneNumber,
      this.iMEI,
      this.available,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.activeDriver,
      this.vecType,
      this.driver,
      this.vehicleType,
      this.carServiceTypes});

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    vecPlate = json['Vec_plate'] ?? "";
    vecName = json['Vec_name'] ?? "";
    vecNum = json['Vec_num'] ?? 0;
    phoneNumber = json['PhoneNumber'] ?? "";
    iMEI = json['IMEI'] ?? "";
    available = json['available'] ?? false;
    url = json['url'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    activeDriver = json['Active_Driver'] ?? 0;
    vecType = json['Vec_type'] ?? 0;
    driver = json['Driver'] != null ? Driver.fromJson(json['Driver']) : null;
    vehicleType = json['VehicleType'] != null
        ? VehicleType.fromJson(json['VehicleType'])
        : null;
    if (json['CarServiceTypes'] != null) {
      carServiceTypes = <CarServiceTypes>[];
      json['CarServiceTypes'].forEach((v) {
        carServiceTypes!.add(CarServiceTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Vec_plate'] = vecPlate;
    data['Vec_name'] = vecName;
    data['Vec_num'] = vecNum;
    data['PhoneNumber'] = phoneNumber;
    data['IMEI'] = iMEI;
    data['available'] = available;
    data['url'] = url;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['Active_Driver'] = activeDriver;
    data['Vec_type'] = vecType;
    if (driver != null) {
      data['Driver'] = driver!.toJson();
    }
    if (vehicleType != null) {
      data['VehicleType'] = vehicleType!.toJson();
    }
    if (carServiceTypes != null) {
      data['CarServiceTypes'] =
          carServiceTypes!.map((v) => v.toJson()).toList();
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
      this.userId});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    offline = json['offline'] ?? false;
    averageRating = json['average_rating'] ?? "";
    ratingCount = json['rating_count'] ?? 0;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    available = json['available'] ?? false;
    fcmtoken = json['fcmtoken'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    userId = json['UserId'] ?? 0;
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
    return data;
  }
}

class Location {
  String? heading;
  double? latitude;
  double? longitude;

  Location({this.heading, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    heading = json['heading'] ?? "";
    latitude = json['latitude'] ?? 0.0;
    longitude = json['longitude'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class VehicleType {
  int? id;
  String? typeName;
  String? createdAt;
  String? updatedAt;

  VehicleType({this.id, this.typeName, this.createdAt, this.updatedAt});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    typeName = json['TypeName'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['TypeName'] = typeName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
    enName = json['en_name'] ?? "";
    arName = json['ar_name'] ?? "";
    baseCost = json['base_cost'] ?? 0;
    costPerKm = json['cost_per_km'] ?? 0;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
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
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
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
