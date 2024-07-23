// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:helpoo_insurance_dashboard/core/models/accident_report_details_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/create_package_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/service_request_details_model.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/cubit.dart';
import 'package:intl/intl.dart';

import '../corporates/corporates_model.dart';

class ClientPackage {
  int? id;
  bool? active;
  String? startDate;
  String? endDate;
  int? clientId;
  int? packageId;
  Package? package;

  ClientPackage.fromJson(Map json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    clientId = json['ClientId'];
    packageId = json['PackageId'];
    active = json['active'];
    package = json['Package'] != null ? Package.fromJson(json['Package']) : null;
  }
}

class GetAllServicesRequests {
  String? status;
  int? totalData;
  int? currentPage;
  int? totalPages;
  List<ServiceRequestModel>? requests;

  GetAllServicesRequests({
    this.status,
    this.totalData,
    this.currentPage,
    this.totalPages,
    this.requests,
  });

  GetAllServicesRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    totalData = json['totalData'] ?? 0;
    currentPage = json['currentPage'] ?? 0;
    totalPages = json['totalPages'] ?? 0;
    if (json['requests'] != null) {
      requests = <ServiceRequestModel>[];
      json['requests'].forEach((v) {
        requests!.add(ServiceRequestModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalData': totalData,
      'currentPage': currentPage,
      'totalPages': totalPages,
      'requests': requests,
    };
  }
}

class GetOneServiceRequestModel {
  String? status;
  ServiceRequestModel? req;
  LocationPrevRequestModel? firstClientDestination;
  LocationPrevRequestModel? firstClientLocation;
  ServiceRequestStatus? oldRequestStatus;

  GetOneServiceRequestModel({
    this.status,
    this.req,
    this.firstClientDestination,
    this.firstClientLocation,
    this.oldRequestStatus,
  });

  GetOneServiceRequestModel.fromJson(Map<String, dynamic> json) {
    firstClientDestination = json['location'] != null ? LocationPrevRequestModel.fromJson(json['location']) : null;
    firstClientLocation = json['firstClientLocation'] != null ? LocationPrevRequestModel.fromJson(json['firstClientLocation']) : null;
    oldRequestStatus = json['oldRequestStatus'] != null ? _parseServiceRequestStatus(json['oldRequestStatus']) : null;
    req = ServiceRequestModel.fromJson(json['request'][0]);
  }
}

class ServiceRequestModel {
  int? id;
  String? name;
  String? phoneNumber;
  Location? location;
  String? status;
  int? fees;
  String? startTime;
  String? arriveTime;
  String? startServiceTime;
  String? endTime;
  String? paymentMethod;
  String? paymentStatus;

  // Null paymentResponse;
  String? orderId;

  // Null comment;
  // Null rating;
  bool? rated;
  int? originalFees;
  int? discount;
  int? discountPercentage;
  int? adminDiscount;
  String? adminDiscountApprovedBy;
  String? adminDiscountReason;
  bool? isAdminDiscountApplied;
  int? waitingFees;
  int? waitingTime;
  bool? isWaitingTimeApplied;
  String? adminComment;
  String? comment;
  PolicyAndPackage? policyAndPackage;
  String? createdAt;
  String? createdAtDate;
  String? createdAtTime;
  String? updatedAt;
  int? carId;
  int? createdByUser;
  int? clientId;
  int? driverId;

  ClientPackage? clientPackage;

  // CorporateCompany corporateCompany;
  Car? car;
  Client? client;
  Driver? driver;
  User? user;
  int? corporateCompanyId;
  CorporateCompany? corporateCompany;
  Branch? branch;
  var branchId;

  List<ServiceRequestPhotoModel>? serviceRequestPhotos;
  List<CarServiceTypes>? carServiceTypes;
  SRVehicleModel? vehicle;
  bool? reject;
  String? clientAddress;
  String? destinationAddress;

  String? camUrl;


  ServiceRequestModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.location,
    this.status,
    this.fees,
    this.startTime,
    this.arriveTime,
    this.startServiceTime,
    this.endTime,
    this.paymentMethod,
    this.paymentStatus,
    // this.paymentResponse,
    this.orderId,
    this.comment,
    // this.rating,
    this.rated,
    this.originalFees,
    this.discount,
    this.discountPercentage,
    this.adminDiscount,
    this.adminDiscountApprovedBy,
    this.adminDiscountReason,
    this.isAdminDiscountApplied,
    this.waitingFees,
    this.waitingTime,
    this.isWaitingTimeApplied,
    this.adminComment,
    this.policyAndPackage,
    this.createdAt,
    this.createdAtDate,
    this.createdAtTime,
    this.updatedAt,
    // this.clientPackageId,
    this.carId,
    this.createdByUser,
    this.clientId,
    this.driverId,
    this.clientPackage,
    this.car,
    this.client,
    this.driver,
    this.user,
    this.serviceRequestPhotos,
    this.carServiceTypes,
    this.corporateCompanyId,
    this.corporateCompany,
    this.branchId,
    this.branch,
    this.vehicle,
    this.reject,
    this.clientAddress,
    this.destinationAddress,
  });

  bool get isRequestActive => status != ServiceRequestStatus.done.name && status != ServiceRequestStatus.canceled.name;

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    phoneNumber = json['PhoneNumber'] ?? '';
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    status = json['status'] ?? '';
    fees = json['fees'] ?? 0;
    startTime = json['startTime'] ?? '';
    arriveTime = json['arriveTime'] ?? '';
    startServiceTime = json['startServiceTime'] ?? '';
    endTime = json['endTime'] ?? '';
    paymentMethod = json['paymentMethod'] ?? '';
    paymentStatus = json['paymentStatus'] ?? '';
    // paymentResponse = json['paymentResponse'];
    orderId = json['orderId'] ?? '';
    comment = json['comment'];
    // rating = json['rating'];
    rated = json['rated'] ?? false;
    originalFees = json['originalFees'] ?? 0;
    discount = json['discount'] ?? 0;
    discountPercentage = json['discountPercentage'] ?? 0;
    adminDiscount = json['adminDiscount'] ?? 0;
    adminDiscountApprovedBy = json['adminDiscountApprovedBy'] ?? '';
    adminDiscountReason = json['adminDiscountReason'] ?? '';
    isAdminDiscountApplied = json['isAdminDiscountApplied'] ?? false;
    waitingFees = json['waitingFees'] ?? 0;
    waitingTime = json['waitingTime'] ?? 0;
    isWaitingTimeApplied = json['isWaitingTimeApplied'] ?? false;
    adminComment = json['adminComment'] ?? '';
    policyAndPackage = json['policyAndPackage'] != null ? PolicyAndPackage.fromJson(json['policyAndPackage']) : null;
    createdAt = json['createdAt'] != null
        ? DateFormat('dd/MM/yyyy hh:mm a').format(DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(json['createdAt']).toLocal())
        : '';
    createdAtDate =
        json['createdAt'] != null ? DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(json['createdAt']).toLocal()) : '';
    createdAtTime =
        json['createdAt'] != null ? DateFormat('hh:mm a').format(DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(json['createdAt']).toLocal()) : '';
    updatedAt = json['updatedAt'] ?? '';
    carId = json['carId'] ?? 0;
    createdByUser = json['createdByUser'] ?? 0;
    clientId = json['clientId'] ?? 0;
    driverId = json['DriverId'] ?? 0;
    clientPackage = json['ClientPackage'] != null ? ClientPackage.fromJson(json['ClientPackage']) : null;
    car = json['Car'] != null ? Car.fromJson(json['Car']) : null;
    client = json['Client'] != null ? Client.fromJson(json['Client']) : null;
    driver = json['Driver'] != null ? Driver.fromJson(json['Driver']) : null;
    user = json['User'] != null ? User.fromJson(json['User']) : null;

    if (json['ServiceRequestPhotos'] != null) {
      serviceRequestPhotos = [];
      serviceRequestPhotos = json['ServiceRequestPhotos'].map<ServiceRequestPhotoModel>((json) => ServiceRequestPhotoModel.fromJson(json)).toList();
    }
    if (json['CarServiceTypes'] != null) {
      carServiceTypes = [];
      carServiceTypes = json['CarServiceTypes'].map<CarServiceTypes>((json) => CarServiceTypes.fromJson(json)).toList();
    }
    corporateCompanyId = json['CorporateCompanyId'] ?? 0;
    corporateCompany = json['CorporateCompany'] != null ? CorporateCompany.fromJson(json['CorporateCompany']) : null;

    branchId = json['BranchId'];

    branch = json['Branch'] != null ? Branch.fromJson(json['Branch']) : null;

    vehicle = json['Vehicle'] != null ? SRVehicleModel.fromJson(json['Vehicle']) : null;
    reject = json['reject'] ?? false;
    clientAddress = json['clientAddress'];
    destinationAddress = json['destinationAddress'];

    camUrl = json['Vehicle']?['url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
      'status': status,
      'fees': fees,
      'startTime': startTime,
      'arriveTime': arriveTime,
      'startServiceTime': startServiceTime,
      'endTime': endTime,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      // 'paymentResponse': paymentResponse,
      'orderId': orderId,
      'comment': comment,
      // 'rating': rating,
      'rated': rated,
      'originalFees': originalFees,
      'discount': discount,
      'discountPercentage': discountPercentage,
      'policyAndPackage': policyAndPackage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      // 'clientPackageId': clientPackageId,
      // 'corporateCompanyId': corporateCompanyId,
      'carId': carId,
      'createdByUser': createdByUser,
      'clientId': clientId,
      'driverId': driverId,
      'clientPackage': clientPackage,
      // 'corporateCompany': corporateCompany,
      'BranchId': branchId,
      'Branch': branch?.toJson(),
      'car': car,
      'client': client,
      'driver': driver,
      'user': user,
      'ServiceRequestPhotos': serviceRequestPhotos,
      'carServiceTypes': carServiceTypes,
      'Vehicle': vehicle,
      'reject': reject,
      'clientAddress': clientAddress,
      'destinationAddress': destinationAddress,
    };
  }
}

class LocationPrevRequestModel {
  var latitude;
  var longitude;

  LocationPrevRequestModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationPrevRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['latitude'] != null && json['longitude'] != null) {
      // debugPrint('--------->xxx ${json['latitude'].runtimeType}');
      // debugPrint('--------->xxx ${json['longitude'].runtimeType}');
    }
    return LocationPrevRequestModel(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}

_parseServiceRequestStatus(dbVal) {
  switch (dbVal) {
    // case 'create':
    //   return ServiceRequestStatus.created;
    // case 'open':
    //   return ServiceRequestStatus.opened;
    case 'pending':
      return ServiceRequestStatus.pending;
    case 'confirmed':
      return ServiceRequestStatus.confirmed;
    case 'arrived':
      return ServiceRequestStatus.arrived;
    case 'destArrived':
      return ServiceRequestStatus.destArrived;
    case 'canceled':
      return ServiceRequestStatus.canceled;
    // case 'not_available':
    //   return ServiceRequestStatus.notAvailable;
    case 'accepted':
      return ServiceRequestStatus.accepted;
    case 'started':
      return ServiceRequestStatus.started;
    case 'done':
      return ServiceRequestStatus.done;
    // case 'paid':
    //   return ServiceRequestStatus.paid;
    default:
      return ServiceRequestStatus.done;
  }
}

class LastUpdatedDistanceAndDuration {
  var createdAt;
  var driverDistanceValue;
  var driverDistanceText;
  var driverDurationText;
  var driverDurationValue;
  var lastUpdatedStatus;

  LastUpdatedDistanceAndDuration({
    this.createdAt,
    this.driverDistanceValue,
    this.driverDistanceText,
    this.driverDurationText,
    this.driverDurationValue,
    this.lastUpdatedStatus,
  });

  LastUpdatedDistanceAndDuration.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    driverDistanceValue = json['driverDistanceMatrix']['distance']['value'];
    driverDistanceText = json['driverDistanceMatrix']['distance']['text'];
    driverDurationValue = json['driverDistanceMatrix']['duration']['value'];
    driverDurationText = json['driverDistanceMatrix']['duration']['text'];
    lastUpdatedStatus = json['status'];
  }
}

class Location {
  // Distance? distance;
  String? clientAddress;
  String? clientLatitude;
  String? destinationLat;
  String? destinationLng;
  String? clientLongitude;
  String? destinationAddress;
  String? distance;
  String? duration;
  LastUpdatedDistanceAndDuration? lastUpdatedDistanceAndDuration;

  // Distance? destinationDistance;

  Location({
    // this.distance,
    this.clientAddress,
    this.clientLatitude,
    this.destinationLat,
    this.destinationLng,
    this.clientLongitude,
    this.destinationAddress,
    this.distance,
    this.duration,
    this.lastUpdatedDistanceAndDuration,

    // this.destinationDistance,
  });

  Location.fromJson(Map<String, dynamic> json) {
    lastUpdatedDistanceAndDuration =
        json['lastUpdatedDistanceAndDuration'] != null ? LastUpdatedDistanceAndDuration.fromJson(json['lastUpdatedDistanceAndDuration']) : null;
    clientAddress = json['clientAddress'];
    clientLatitude = json['clientLatitude'].runtimeType == double ? '${json['clientLatitude'] ?? 0}' : json['clientLatitude'];
    destinationLat = json['destinationLat'].runtimeType == double ? '${json['destinationLat'] ?? 0}' : json['destinationLat'];
    destinationLng = json['destinationLng'].runtimeType == double ? '${json['destinationLng'] ?? 0}' : json['destinationLng'];
    clientLongitude = json['clientLongitude'].runtimeType == double ? '${json['clientLongitude'] ?? 0}' : json['clientLongitude'];
    destinationAddress = json['destinationAddress'];
  }

  Map<String, dynamic> toJson() {
    return {
      // 'distance': distance,
      'clientAddress': clientAddress,
      'clientLatitude': clientLatitude,
      'destinationLat': destinationLat,
      'destinationLng': destinationLng,
      'clientLongitude': clientLongitude,
      'destinationAddress': destinationAddress,
      // 'destinationDistance': destinationDistance,
    };
  }
}

class ServiceRequestPhotoModel {
  int? id;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  int? serviceRequestId;

  ServiceRequestPhotoModel({
    this.id,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.serviceRequestId,
  });

  ServiceRequestPhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    serviceRequestId = json['serviceRequestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['serviceRequestId'] = serviceRequestId;
    return data;
  }
}
// class Distance {
//   Distance? distance;
//
//   Distance({this.distance});
//
//   Distance.fromJson(Map<String, dynamic> json) {
//     distance =
//         json['distance'] != null ? Distance.fromJson(json['distance']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'distance': distance,
//     };
//   }
// }
//
// class Distance {
//   String text;
//   String value;
//
//   Distance({this.text, this.value});
//
//   Distance.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['text'] = this.text;
//     data['value'] = this.value;
//     return data;
//   }
// }
//
// class Distance {
//   int value;
//
//   Distance({this.value});
//
//   Distance.fromJson(Map<String, dynamic> json) {
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['value'] = this.value;
//     return data;
//   }
// }

class PolicyAndPackage {
  String? status;
  String? policyEnd;
  int? usedCount;
  String? policyStart;
  String? policyNumber;
  bool? policyCanceled;
  int? maxTotalDiscount;
  int? packageRequestCount;
  int? packageDiscountPercentage;
  int? discountPercentAfterPolicyExpires;

  PolicyAndPackage({
    this.status,
    this.policyEnd,
    this.usedCount,
    this.policyStart,
    this.policyNumber,
    this.policyCanceled,
    this.maxTotalDiscount,
    this.packageRequestCount,
    this.packageDiscountPercentage,
    this.discountPercentAfterPolicyExpires,
  });

  PolicyAndPackage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    policyEnd = json['policy_end'];
    usedCount = json['used_count'];
    policyStart = json['policy_start'];
    policyNumber = json['policy_number'];
    policyCanceled = json['policy_canceled'];
    maxTotalDiscount = json['max_total_discount'];
    packageRequestCount = json['package_request_count'];
    packageDiscountPercentage = json['package_discount_percentage'];
    discountPercentAfterPolicyExpires = json['discount_percent_after_policy_expires'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'policy_end': policyEnd,
      'used_count': usedCount,
      'policy_start': policyStart,
      'policy_number': policyNumber,
      'policy_canceled': policyCanceled,
      'max_total_discount': maxTotalDiscount,
      'package_request_count': packageRequestCount,
      'package_discount_percentage': packageDiscountPercentage,
      'discount_percent_after_policy_expires': discountPercentAfterPolicyExpires,
    };
  }
}

class CorporateCompany {
  int? id;
  String? enName;
  String? arName;
  int? discountRatio;
  bool? deferredPayment;
  String? startDate;
  String? endDate;
  bool? cash;
  bool? cardToDriver;
  bool? online;
  String? photo;

  // Null? numofrequeststhismonth;
  String? createdAt;
  String? updatedAt;

  CorporateCompany(
      {this.id,
      this.enName,
      this.arName,
      this.discountRatio,
      this.deferredPayment,
      this.startDate,
      this.endDate,
      this.cash,
      this.cardToDriver,
      this.online,
      this.photo,
      // this.numofrequeststhismonth,
      this.createdAt,
      this.updatedAt});

  CorporateCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    discountRatio = json['discount_ratio'] ?? 0;
    deferredPayment = json['deferredPayment'] ?? false;
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    cash = json['cash'] ?? false;
    cardToDriver = json['cardToDriver'] ?? false;
    online = json['online'] ?? false;
    photo = json['photo'] ?? '';
    // numofrequeststhismonth = json['numofrequeststhismonth'];
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['discount_ratio'] = discountRatio;
    data['deferredPayment'] = deferredPayment;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['cash'] = cash;
    data['cardToDriver'] = cardToDriver;
    data['online'] = online;
    data['photo'] = photo;
    // data['numofrequeststhismonth'] = this.numofrequeststhismonth;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

// class Car {
//   int id;
//   String plateNumber;
//   int year;
//   String policyNumber;
//   String policyStarts;
//   String policyEnds;
//   String appendixNumber;
//   String vinNumber;
//   bool policyCanceled;
//   String color;
//   Null frontLicense;
//   Null backLicense;
//   int createdBy;
//   int manufacturerId;
//   int carModelId;
//   int clientId;
//   bool active;
//   String createdAt;
//   String updatedAt;
//   Null deletedAt;
//   int insuranceCompanyId;
//
//   Car(
//       {this.id,
//       this.plateNumber,
//       this.year,
//       this.policyNumber,
//       this.policyStarts,
//       this.policyEnds,
//       this.appendixNumber,
//       this.vinNumber,
//       this.policyCanceled,
//       this.color,
//       this.frontLicense,
//       this.backLicense,
//       this.createdBy,
//       this.manufacturerId,
//       this.carModelId,
//       this.clientId,
//       this.active,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt,
//       this.insuranceCompanyId});
//
//   Car.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     plateNumber = json['plateNumber'];
//     year = json['year'];
//     policyNumber = json['policyNumber'];
//     policyStarts = json['policyStarts'];
//     policyEnds = json['policyEnds'];
//     appendixNumber = json['appendix_number'];
//     vinNumber = json['vin_number'];
//     policyCanceled = json['policyCanceled'];
//     color = json['color'];
//     frontLicense = json['frontLicense'];
//     backLicense = json['backLicense'];
//     createdBy = json['CreatedBy'];
//     manufacturerId = json['ManufacturerId'];
//     carModelId = json['CarModelId'];
//     clientId = json['ClientId'];
//     active = json['active'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     deletedAt = json['deletedAt'];
//     insuranceCompanyId = json['insuranceCompanyId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['plateNumber'] = this.plateNumber;
//     data['year'] = this.year;
//     data['policyNumber'] = this.policyNumber;
//     data['policyStarts'] = this.policyStarts;
//     data['policyEnds'] = this.policyEnds;
//     data['appendix_number'] = this.appendixNumber;
//     data['vin_number'] = this.vinNumber;
//     data['policyCanceled'] = this.policyCanceled;
//     data['color'] = this.color;
//     data['frontLicense'] = this.frontLicense;
//     data['backLicense'] = this.backLicense;
//     data['CreatedBy'] = this.createdBy;
//     data['ManufacturerId'] = this.manufacturerId;
//     data['CarModelId'] = this.carModelId;
//     data['ClientId'] = this.clientId;
//     data['active'] = this.active;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['deletedAt'] = this.deletedAt;
//     data['insuranceCompanyId'] = this.insuranceCompanyId;
//     return data;
//   }
// }
//
// class Client {
//   int id;
//   bool active;
//   Null confirmed;
//   String fcmtoken;
//   String createdAt;
//   String updatedAt;
//   int userId;
//   User user;
//
//   Client(
//       {this.id,
//       this.active,
//       this.confirmed,
//       this.fcmtoken,
//       this.createdAt,
//       this.updatedAt,
//       this.userId,
//       this.user});
//
//   Client.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     active = json['active'];
//     confirmed = json['confirmed'];
//     fcmtoken = json['fcmtoken'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     userId = json['UserId'];
//     user = json['User'] != null ? new User.fromJson(json['User']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['active'] = this.active;
//     data['confirmed'] = this.confirmed;
//     data['fcmtoken'] = this.fcmtoken;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['UserId'] = this.userId;
//     if (this.user != null) {
//       data['User'] = this.user.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   int id;
//   String phoneNumber;
//   String email;
//   String password;
//   String username;
//   String name;
//   bool blocked;
//   String photo;
//   bool deleted;
//   String createdAt;
//   String updatedAt;
//   int roleId;
//
//   User(
//       {this.id,
//       this.phoneNumber,
//       this.email,
//       this.password,
//       this.username,
//       this.name,
//       this.blocked,
//       this.photo,
//       this.deleted,
//       this.createdAt,
//       this.updatedAt,
//       this.roleId});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     phoneNumber = json['PhoneNumber'];
//     email = json['email'];
//     password = json['password'];
//     username = json['username'];
//     name = json['name'];
//     blocked = json['blocked'];
//     photo = json['photo'];
//     deleted = json['deleted'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     roleId = json['RoleId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['PhoneNumber'] = this.phoneNumber;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['username'] = this.username;
//     data['name'] = this.name;
//     data['blocked'] = this.blocked;
//     data['photo'] = this.photo;
//     data['deleted'] = this.deleted;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['RoleId'] = this.roleId;
//     return data;
//   }
// }

class Driver {
  int? id;
  bool? offline;
  String? averageRating;
  int? ratingCount;
  DriverLocation? location;
  bool? available;
  String? fcmtoken;
  String? createdAt;
  String? updatedAt;
  int? userId;
  User? user;

  Driver({
    this.id,
    this.offline,
    this.averageRating,
    this.ratingCount,
    this.location,
    this.available,
    this.fcmtoken,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.user,
  });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offline = json['offline'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    location = json['location'] != null ? DriverLocation.fromJson(json['location']) : null;
    available = json['available'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offline': offline,
      'average_rating': averageRating,
      'rating_count': ratingCount,
      'location': location?.toJson(),
      'available': available,
      'fcmtoken': fcmtoken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'UserId': userId,
      'User': user?.toJson(),
    };
  }
}

class DriverLocation {
  String? heading;
  double? latitude;
  double? longitude;

  DriverLocation({this.heading, this.latitude, this.longitude});

  DriverLocation.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

// class User {
//   int id;
//   Null phoneNumber;
//   Null email;
//   String password;
//   String username;
//   String name;
//   bool blocked;
//   String photo;
//   bool deleted;
//   String createdAt;
//   String updatedAt;
//   int roleId;
//
//   User(
//       {this.id,
//       this.phoneNumber,
//       this.email,
//       this.password,
//       this.username,
//       this.name,
//       this.blocked,
//       this.photo,
//       this.deleted,
//       this.createdAt,
//       this.updatedAt,
//       this.roleId});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     phoneNumber = json['PhoneNumber'];
//     email = json['email'];
//     password = json['password'];
//     username = json['username'];
//     name = json['name'];
//     blocked = json['blocked'];
//     photo = json['photo'];
//     deleted = json['deleted'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     roleId = json['RoleId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['PhoneNumber'] = this.phoneNumber;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['username'] = this.username;
//     data['name'] = this.name;
//     data['blocked'] = this.blocked;
//     data['photo'] = this.photo;
//     data['deleted'] = this.deleted;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['RoleId'] = this.roleId;
//     return data;
//   }
// }

class CarServiceTypes {
  int? id;
  String? enName;
  String? arName;
  int? baseCost;
  int? costPerKm;
  String? createdAt;
  String? updatedAt;
  int? carType;
  Types? types;

  CarServiceTypes({
    this.id,
    this.enName,
    this.arName,
    this.baseCost,
    this.costPerKm,
    this.createdAt,
    this.updatedAt,
    this.carType,
    this.types,
  });

  CarServiceTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    baseCost = json['base_cost'] ?? 0;
    costPerKm = json['cost_per_km'] ?? 0;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    carType = json['car_type'] ?? 0;
    types = json['Types'] != null ? Types.fromJson(json['Types']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_name': enName,
      'ar_name': arName,
      'base_cost': baseCost,
      'cost_per_km': costPerKm,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'car_type': carType,
      'Types': types?.toJson(),
    };
  }
}

class Types {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? serviceRequestId;
  int? carServiceTypeId;

  Types({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.serviceRequestId,
    this.carServiceTypeId,
  });

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    serviceRequestId = json['ServiceRequestId'];
    carServiceTypeId = json['CarServiceTypeId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'ServiceRequestId': serviceRequestId,
      'CarServiceTypeId': carServiceTypeId,
    };
  }
}
