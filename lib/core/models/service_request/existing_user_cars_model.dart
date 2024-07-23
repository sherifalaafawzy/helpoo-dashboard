import '../insurance_companies_model.dart';

class ExistingUserCarsModel {
  String? status;
  List<CustomerCar>? cars;

  ExistingUserCarsModel({this.status, this.cars});

  ExistingUserCarsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['car'] != null) {
      cars = <CustomerCar>[];
      json['car'].forEach((v) {
        cars!.add(CustomerCar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (cars != null) {
      data['car'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerCar {
  int? id;
  String? plateNumber;
  int? year;
  String? policyNumber;
  String? policyStarts;
  String? policyEnds;
  String? appendixNumber;
  String? vinNumber;
  bool? policyCanceled;
  String? color;
  String? frontLicense;
  String? backLicense;
  int? createdBy;
  int? manufacturerId;
  int? carModelId;
  int? clientId;
  bool? active;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? insuranceCompanyId;
  Manufacturer? manufacturer;
  CarModel? carModel;
  Client? client;
  InsuranceCompany? insuranceCompany;

  CustomerCar(
      {this.id,
      this.plateNumber,
      this.year,
      this.policyNumber,
      this.policyStarts,
      this.policyEnds,
      this.appendixNumber,
      this.vinNumber,
      this.policyCanceled,
      this.color,
      this.frontLicense,
      this.backLicense,
      this.createdBy,
      this.manufacturerId,
      this.carModelId,
      this.clientId,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.insuranceCompanyId,
      this.manufacturer,
      this.carModel,
      this.client,
      this.insuranceCompany});

  CustomerCar.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    plateNumber = json['plateNumber'] ?? '';
    year = json['year'] ?? 0;
    policyNumber = json['policyNumber'] ?? '';
    policyStarts = json['policyStarts'] ?? '';
    policyEnds = json['policyEnds'] ?? '';
    appendixNumber = json['appendix_number'] ?? '';
    vinNumber = json['vin_number'] ?? '';
    policyCanceled = json['policyCanceled'] ?? false;
    color = json['color'] ?? '';
    frontLicense = json['frontLicense'] ?? '';
    backLicense = json['backLicense'] ?? '';
    createdBy = json['CreatedBy'] ?? 0;
    manufacturerId = json['ManufacturerId'] ?? 0;
    carModelId = json['CarModelId'] ?? 0;
    clientId = json['ClientId'] ?? 0;
    active = json['active'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    deletedAt = json['deletedAt'] ?? '';
    insuranceCompanyId = json['insuranceCompanyId'];
    manufacturer = json['Manufacturer'] != null ? Manufacturer.fromJson(json['Manufacturer']) : null;
    carModel = json['CarModel'] != null ? CarModel.fromJson(json['CarModel']) : null;
    client = json['Client'] != null ? Client.fromJson(json['Client']) : null;
    insuranceCompany = json['insuranceCompany'] != null ? InsuranceCompany.fromJson(json['insuranceCompany']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plateNumber'] = plateNumber;
    data['year'] = year;
    data['policyNumber'] = policyNumber;
    data['policyStarts'] = policyStarts;
    data['policyEnds'] = policyEnds;
    data['appendix_number'] = appendixNumber;
    data['vin_number'] = vinNumber;
    data['policyCanceled'] = policyCanceled;
    data['color'] = color;
    data['frontLicense'] = frontLicense;
    data['backLicense'] = backLicense;
    data['CreatedBy'] = createdBy;
    data['ManufacturerId'] = manufacturerId;
    data['CarModelId'] = carModelId;
    data['ClientId'] = clientId;
    data['active'] = active;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['insuranceCompanyId'] = insuranceCompanyId;
    if (manufacturer != null) {
      data['Manufacturer'] = manufacturer!.toJson();
    }
    if (carModel != null) {
      data['CarModel'] = carModel!.toJson();
    }
    if (client != null) {
      data['Client'] = client!.toJson();
    }
    if (insuranceCompany != null) {
      data['insuranceCompany'] = insuranceCompany!.toJson();
    }
    return data;
  }
}

class Manufacturer {
  int? id;
  String? enName;
  String? arName;
  String? createdAt;
  String? updatedAt;

  Manufacturer({this.id, this.enName, this.arName, this.createdAt, this.updatedAt});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class CarModel {
  int? id;
  String? enName;
  String? arName;
  String? createdAt;
  String? updatedAt;
  int? manufacturerId;

  CarModel({this.id, this.enName, this.arName, this.createdAt, this.updatedAt, this.manufacturerId});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    manufacturerId = json['ManufacturerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['ManufacturerId'] = manufacturerId;
    return data;
  }
}

class Client {
  int? id;
  bool? active;
  var confirmed;
  String? fcmtoken;
  String? createdAt;
  String? updatedAt;
  int? userId;
  User? user;

  Client(
      {this.id,
        this.active,
        this.confirmed,
        this.fcmtoken,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.user});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    confirmed = json['confirmed'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
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

// class Client {
//   int? id;
//   bool? active;
//   var confirmed;
//   String? fcmtoken;
//   String? createdAt;
//   String? updatedAt;
//   int? userId;
//
//   Client(
//       {this.id,
//         this.active,
//         this.confirmed,
//         this.fcmtoken,
//         this.createdAt,
//         this.updatedAt,
//         this.userId});
//
//   Client.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     active = json['active'];
//     confirmed = json['confirmed'];
//     fcmtoken = json['fcmtoken'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     userId = json['UserId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['active'] = this.active;
//     data['confirmed'] = this.confirmed;
//     data['fcmtoken'] = this.fcmtoken;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['UserId'] = this.userId;
//     return data;
//   }
// }

// class InsuranceCompany {
//   int? id;
//   String? enName;
//   String? arName;
//   int? packageRequestCount;
//   int? packageDiscountPercentage;
//   int? maxTotalDiscount;
//   int? discountPercentAfterPolicyExpires;
//   String? startDate;
//   String? endDate;
//   String? createdAt;
//   String? updatedAt;
//   List<String>? emails;
//
//   InsuranceCompany({
//     this.id,
//     this.enName,
//     this.arName,
//     this.packageRequestCount,
//     this.packageDiscountPercentage,
//     this.maxTotalDiscount,
//     this.discountPercentAfterPolicyExpires,
//     this.startDate,
//     this.endDate,
//     this.createdAt,
//     this.updatedAt,
//     this.emails,
//   });
//
//   InsuranceCompany.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     enName = json['en_name'];
//     arName = json['ar_name'];
//     packageRequestCount = json['package_request_count'];
//     packageDiscountPercentage = json['package_discount_percentage'];
//     maxTotalDiscount = json['max_total_discount'];
//     discountPercentAfterPolicyExpires = json['discount_percent_after_policy_expires'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     emails = json['emails'] != null ? json['emails'].cast<String>() : [];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['en_name'] = this.enName;
//     data['ar_name'] = this.arName;
//     data['package_request_count'] = this.packageRequestCount;
//     data['package_discount_percentage'] = this.packageDiscountPercentage;
//     data['max_total_discount'] = this.maxTotalDiscount;
//     data['discount_percent_after_policy_expires'] = this.discountPercentAfterPolicyExpires;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['emails'] = this.emails;
//     return data;
//   }
// }

class GetInsuranceModel {
  String? status;
  InsuranceCompany? insuranceCompany;

  GetInsuranceModel({this.status, this.insuranceCompany});

  GetInsuranceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    insuranceCompany = json['insuranceCompany'] != null ? InsuranceCompany.fromJson(json['insuranceCompany']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (insuranceCompany != null) {
      data['insuranceCompany'] = insuranceCompany!.toJson();
    }
    return data;
  }
}


/// *********************************************************

// class SearchCarByVinNumberResponseModel {
//   String? status;
//   List<CustomerCar>? cars;
//
//   SearchCarByVinNumberResponseModel({this.status, this.cars});
//
//   SearchCarByVinNumberResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['car'] != null) {
//       cars = <CustomerCar>[];
//       json['car'].forEach((v) {
//         cars!.add(new CustomerCar.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.cars != null) {
//       data['car'] = this.cars!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Car {
//   int? id;
//   String? plateNumber;
//   int? year;
//   String? policyNumber;
//   String? policyStarts;
//   String? policyEnds;
//   String? appendixNumber;
//   String? vinNumber;
//   bool? policyCanceled;
//   String? color;
//   String? frontLicense;
//   String? backLicense;
//   String? createdBy;
//   String? manufacturerId;
//   String? carModelId;
//   String? clientId;
//   String? brokerId;
//   bool? active;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   int? insuranceCompanyId;
//   InsuranceComp? insuranceCompany;
//   var manufacturer;
//   var carModel;
//
//   Car(
//       {this.id,
//         this.plateNumber,
//         this.year,
//         this.policyNumber,
//         this.policyStarts,
//         this.policyEnds,
//         this.appendixNumber,
//         this.vinNumber,
//         this.policyCanceled,
//         this.color,
//         this.frontLicense,
//         this.backLicense,
//         this.createdBy,
//         this.manufacturerId,
//         this.carModelId,
//         this.clientId,
//         this.brokerId,
//         this.active,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.insuranceCompanyId,
//         this.insuranceCompany,
//         this.manufacturer,
//         this.carModel});
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
//     brokerId = json['BrokerId'];
//     active = json['active'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     deletedAt = json['deletedAt'];
//     insuranceCompanyId = json['insuranceCompanyId'];
//     insuranceCompany = json['insuranceCompany'] != null
//         ? new InsuranceComp.fromJson(json['insuranceCompany'])
//         : null;
//     manufacturer = json['Manufacturer'];
//     carModel = json['CarModel'];
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
//     data['BrokerId'] = this.brokerId;
//     data['active'] = this.active;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['deletedAt'] = this.deletedAt;
//     data['insuranceCompanyId'] = this.insuranceCompanyId;
//     if (this.insuranceCompany != null) {
//       data['insuranceCompany'] = this.insuranceCompany!.toJson();
//     }
//     data['Manufacturer'] = this.manufacturer;
//     data['CarModel'] = this.carModel;
//     return data;
//   }
// }

class InsuranceComp {
  int? id;
  String? enName;
  String? arName;
  String? packageRequestCount;
  String? packageDiscountPercentage;
  String? maxTotalDiscount;
  String? discountPercentAfterPolicyExpires;
  String? startDate;
  String? endDate;
  String? photo;
  List<String>? emails;
  String? createdAt;
  String? updatedAt;

  InsuranceComp(
      {this.id,
        this.enName,
        this.arName,
        this.packageRequestCount,
        this.packageDiscountPercentage,
        this.maxTotalDiscount,
        this.discountPercentAfterPolicyExpires,
        this.startDate,
        this.endDate,
        this.photo,
        this.emails,
        this.createdAt,
        this.updatedAt});

  InsuranceComp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    packageRequestCount = json['package_request_count'];
    packageDiscountPercentage = json['package_discount_percentage'];
    maxTotalDiscount = json['max_total_discount'];
    discountPercentAfterPolicyExpires =
    json['discount_percent_after_policy_expires'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    photo = json['photo'];
    emails = json['emails'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    data['package_request_count'] = this.packageRequestCount;
    data['package_discount_percentage'] = this.packageDiscountPercentage;
    data['max_total_discount'] = this.maxTotalDiscount;
    data['discount_percent_after_policy_expires'] =
        this.discountPercentAfterPolicyExpires;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['photo'] = this.photo;
    data['emails'] = this.emails;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

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
  Null? packagePromoCodeId;

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
