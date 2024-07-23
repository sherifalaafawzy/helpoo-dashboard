import '../accident_report_details_model.dart';

class ServiceRequestDetails {
  final int id;
  final String status;
  final num fees;
  final num originalFees;
  final String paymentMethod;
  final String paymentStatus;
  final int driverId;
  final DriverRequestDetailsModel? driverRequestDetailsModel;
  final LocationRequestDetailsModel? locationRequestDetailsModel;
  SRVehicleModel? vehicle;
  int? adminDiscount;
  String? adminDiscountApprovedBy;
  String? adminDiscountReason;
  bool? isAdminDiscountApplied;
  bool? isWaitingTimeApplied;
  int? discountPercentage;
  int? waitingTime;
  List<CarServiceType>? CarServiceTypes;
  bool? reject;

  ServiceRequestDetails({
    required this.id,
    required this.status,
    required this.fees,
    required this.originalFees,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.driverId,
    required this.driverRequestDetailsModel,
    required this.locationRequestDetailsModel,
    this.vehicle,
    this.adminDiscount,
    this.adminDiscountApprovedBy,
    this.adminDiscountReason,
    this.isAdminDiscountApplied,
    this.isWaitingTimeApplied,
    this.discountPercentage,
    this.waitingTime,
    this.CarServiceTypes,
    this.reject,
  });

  factory ServiceRequestDetails.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDetails(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      fees: json['fees'] ?? 0.0,
      originalFees: json['originalFees'] ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      driverId: json['DriverId'] ?? 0,
      driverRequestDetailsModel: json['Driver'] != null ? DriverRequestDetailsModel.fromJson(json['Driver']) : null,
      locationRequestDetailsModel:
          json['location'] != null ? LocationRequestDetailsModel.fromJson(json['location']) : null,
      vehicle: json['Vehicle'] != null ? SRVehicleModel.fromJson(json['Vehicle']) : null,
      discountPercentage: json['discountPercentage'] ?? 0,
      waitingTime: json['waitingTime'] ?? 0,
      adminDiscount: json['adminDiscount'] ?? 0,
      adminDiscountApprovedBy: json['adminDiscountApprovedBy'] ?? '',
      adminDiscountReason: json['adminDiscountReason'] ?? '',
      isAdminDiscountApplied: json['isAdminDiscountApplied'] ?? false,
      isWaitingTimeApplied: json['isWaitingTimeApplied'] ?? false,
      CarServiceTypes: json['CarServiceTypes'] != null
          ? List<CarServiceType>.from(json['CarServiceTypes'].map((x) => CarServiceType.fromJson(x)))
          : null,
      reject: json['reject'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'fees': fees,
      'originalFees': originalFees,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'DriverId': driverId,
      'Driver': driverRequestDetailsModel?.toJson(),
      'location': locationRequestDetailsModel?.toJson(),
      'Vehicle': vehicle?.toJson(),
      'discountPercentage': discountPercentage,
    };
  }
}

class CarServiceType {
  final int id;
  final String en_name;
  final String ar_name;
  final int base_cost;
  final int cost_per_km;
  final String createdAt;
  final String updatedAt;
  final int car_type;

  // final Types? types;

  CarServiceType({
    required this.id,
    required this.en_name,
    required this.ar_name,
    required this.base_cost,
    required this.cost_per_km,
    required this.createdAt,
    required this.updatedAt,
    required this.car_type,
    // required this.types,
  });

  factory CarServiceType.fromJson(Map<String, dynamic> json) {
    return CarServiceType(
      id: json['id'] ?? 0,
      en_name: json['en_name'] ?? '',
      ar_name: json['ar_name'] ?? '',
      base_cost: json['base_cost'] ?? 0,
      cost_per_km: json['cost_per_km'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      car_type: json['car_type'] ?? 0,
      // types: json['Types'] != null ? Types.fromJson(json['Types']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_name': en_name,
      'ar_name': ar_name,
      'base_cost': base_cost,
      'cost_per_km': cost_per_km,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'car_type': car_type,
      // 'Types': types?.toJson(),
    };
  }
}

class VehicleType {
  int? id;
  String? typeName;

  VehicleType({
    this.id,
    this.typeName,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      id: json['id'] ?? 0,
      typeName: json['TypeName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'TypeName': typeName,
    };
  }
}

class SRVehicleModel {
  final String VecPlate;
  final String VecName;
  final int VecNum;
  VehicleType? vehicleType;

  // final int Active_Driver;
  // final int Vec_type;
  // final bool available;

  SRVehicleModel({required this.VecPlate, required this.VecName, required this.VecNum, this.vehicleType
      // required this.Active_Driver,
      // required this.Vec_type,
      // required this.available,
      });

  factory SRVehicleModel.fromJson(Map<String, dynamic> json) {
    return SRVehicleModel(
      VecPlate: json['Vec_plate'] ?? '',
      VecName: json['Vec_name'] ?? '',
      VecNum: json['Vec_num'] ?? 0,
      vehicleType: json['VehicleType'] != null ? VehicleType.fromJson(json['VehicleType']) : null,

      // Active_Driver: json['Active_Driver'] ?? '',
      // Vec_type: json['Vec_type'] ?? '',
      // available: json['available'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Vec_plate': VecPlate,
      'Vec_name': VecName,
      'Vec_num': VecNum,
      'VehicleType': vehicleType?.toJson(),
      // 'Active_Driver': Active_Driver,
      // 'Vec_type': Vec_type,
      // 'available': available,
    };
  }
}

class DriverRequestDetailsModel {
  final int id;
  final bool offline;
  final bool available;
  final num latitude;
  final num longitude;
  final String heading;
  final String averageRating;
  final int ratingCount;
  String? distance;
  String? duration;
  final String fcmtoken;
  User? user;

  DriverRequestDetailsModel({
    required this.id,
    required this.offline,
    required this.available,
    required this.latitude,
    required this.longitude,
    required this.heading,
    required this.averageRating,
    required this.ratingCount,
    this.distance,
    this.duration,
    this.user,
    required this.fcmtoken,
  });

  factory DriverRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return DriverRequestDetailsModel(
      id: json['id'] ?? 0,
      offline: json['offline'] ?? false,
      available: json['available'] ?? false,
      user: json['User'] != null ? User.fromJson(json['User']) : null,
      latitude: json['location'] != null ? json['location']['latitude'] ?? 0.0 : 0.0,
      longitude: json['location'] != null ? json['location']['longitude'] ?? 0.0 : 0.0,
      heading: json['location'] != null ? json['location']['heading'] ?? '0.0' : '0.0',
      averageRating: json['average_rating'] ?? '',
      ratingCount: json['rating_count'] ?? 0,
      fcmtoken: json['fcmtoken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offline': offline,
      'available': available,
      'latitude': latitude,
      'longitude': longitude,
      'heading': heading,
      'average_rating': averageRating,
      'rating_count': ratingCount,
    };
  }
}

class LocationRequestDetailsModel {
  final String clientAddress;
  final num clientLatitude;
  final num clientLongitude;
  final String destinationAddress;
  final num destinationLatitude;
  final num destinationLongitude;

  LocationRequestDetailsModel({
    required this.clientAddress,
    required this.clientLatitude,
    required this.clientLongitude,
    required this.destinationAddress,
    required this.destinationLatitude,
    required this.destinationLongitude,
  });

  factory LocationRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    return LocationRequestDetailsModel(
      clientAddress: json['clientAddress'] ?? '',
      clientLatitude: num.parse((json['clientLatitude'] as String)) ?? 0.0,
      clientLongitude: num.parse((json['clientLongitude'] as String)) ?? 0.0,
      destinationAddress: json['destinationAddress'] ?? '',
      destinationLatitude: num.parse((json['destinationLat'] as String)) ?? 0.0,
      destinationLongitude: num.parse((json['destinationLng'] as String)) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientAddress': clientAddress,
      'clientLatitude': clientLatitude,
      'clientLongitude': clientLongitude,
      'destinationAddress': destinationAddress,
      'destinationLatitude': destinationLatitude,
      'destinationLongitude': destinationLongitude,
    };
  }
}
