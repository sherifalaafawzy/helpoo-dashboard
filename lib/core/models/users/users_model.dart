class UsersModel {
  String? status;
  List<Users>? users;

  UsersModel({this.status, this.users});

  UsersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
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

class Users {
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
  Role? role;

  Users(
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
      this.roleId,
      this.role});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    phoneNumber = json['PhoneNumber'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    username = json['username'] ?? '';
    name = json['name'] ?? '';
    blocked = json['blocked'] ?? '';
    photo = json['photo'] ?? '';
    deleted = json['deleted'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    roleId = json['RoleId'] ?? '';
    role = json['Role'] != null ? Role.fromJson(json['Role']) : null;
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
    if (role != null) {
      data['Role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.name, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


class SearchedUserByPhoneResponseModel {
  String? status;
  Users? user;
  Client? client;
  List<Packages>? packages;

  SearchedUserByPhoneResponseModel(
      {this.status, this.user, this.client, this.packages});

  SearchedUserByPhoneResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? Users.fromJson(json['user']) : null;
    client =
    json['client'] != null ? Client.fromJson(json['client']) : null;
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
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

  Client(
      {this.id,
        this.active,
        this.confirmed,
        this.fcmtoken,
        this.createdAt,
        this.updatedAt,
        this.userId});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    confirmed = json['confirmed'];
    fcmtoken = json['fcmtoken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['confirmed'] = this.confirmed;
    data['fcmtoken'] = this.fcmtoken;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['UserId'] = this.userId;
    return data;
  }
}

class Packages {
  int? id;
  String? enName;
  String? arName;
  int? originalFees;
  int? price;
  int? fees;
  int? numberOfCars;
  int? maxDiscountPerTime;
  int? numberOfDiscountTimes;
  int? numberOfDiscountTimesOther;
  int? discountPercentage;
  int? discountAfterMaxTimes;
  int? numberOfDays;
  String? arDescription;
  String? enDescription;
  bool? active;
  bool? private;
  int? activateAfterDays;
  String? createdAt;
  String? updatedAt;
  var insuranceCompanyId;
  var brokerId;
  var corporateCompanyId;
  List<PackageBenefits>? packageBenefits;
  var corporateCompany;
  var insuranceCompany;
  var broker;
  String? startDate;
  String? endDate;
  int? orderId;
  var deletedAt;
  int? packageId;
  int? clientId;
  List<CarPackages>? carPackages;
  List? usedPromosPackages;
  int? assignedCars;
  int? requestsInThisPackag;
  int? requestsInThisPackageOtherServices;

  Packages(
      {this.id,
        this.enName,
        this.arName,
        this.originalFees,
        this.price,
        this.fees,
        this.numberOfCars,
        this.maxDiscountPerTime,
        this.numberOfDiscountTimes,
        this.numberOfDiscountTimesOther,
        this.discountPercentage,
        this.discountAfterMaxTimes,
        this.numberOfDays,
        this.arDescription,
        this.enDescription,
        this.active,
        this.private,
        this.activateAfterDays,
        this.createdAt,
        this.updatedAt,
        this.insuranceCompanyId,
        this.brokerId,
        this.corporateCompanyId,
        this.packageBenefits,
        this.corporateCompany,
        this.insuranceCompany,
        this.broker,
        this.startDate,
        this.endDate,
        this.orderId,
        this.deletedAt,
        this.packageId,
        this.clientId,
        this.carPackages,
        this.usedPromosPackages,
        this.assignedCars,
        this.requestsInThisPackag,
        this.requestsInThisPackageOtherServices,
      });

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    originalFees = json['originalFees'];
    price = json['price'];
    fees = json['fees'];
    numberOfCars = json['numberOfCars'];
    maxDiscountPerTime = json['maxDiscountPerTime'];
    numberOfDiscountTimes = json['numberOfDiscountTimes'];
    numberOfDiscountTimesOther = json['numberOfDiscountTimesOther'];
    discountPercentage = json['discountPercentage'];
    discountAfterMaxTimes = json['discountAfterMaxTimes'];
    numberOfDays = json['numberOfDays'];
    arDescription = json['arDescription'];
    enDescription = json['enDescription'];
    active = json['active'];
    private = json['private'];
    activateAfterDays = json['activateAfterDays'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    insuranceCompanyId = json['insuranceCompanyId'];
    brokerId = json['BrokerId'];
    corporateCompanyId = json['corporateCompanyId'];
    if (json['PackageBenefits'] != null) {
      packageBenefits = <PackageBenefits>[];
      json['PackageBenefits'].forEach((v) {
        packageBenefits!.add(PackageBenefits.fromJson(v));
      });
    }
    corporateCompany = json['CorporateCompany'];
    insuranceCompany = json['insuranceCompany'];
    broker = json['Broker'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    orderId = json['orderId'];
    deletedAt = json['deletedAt'];
    packageId = json['PackageId'];
    clientId = json['ClientId'];
    if (json['CarPackages'] != null) {
      carPackages = <CarPackages>[];
      json['CarPackages'].forEach((v) {
        carPackages!.add(CarPackages.fromJson(v));
      });
    }
    if (json['UsedPromosPackages'] != null) {
      usedPromosPackages = [];
      json['UsedPromosPackages'].forEach((v) {
        usedPromosPackages!.add(v);
      });
    }
    assignedCars = json['assignedCars'];
    requestsInThisPackag = json['requestsInThisPackag'];
    requestsInThisPackageOtherServices = json['requestsInThisPackageOtherServices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['enName'] = this.enName;
    data['arName'] = this.arName;
    data['originalFees'] = this.originalFees;
    data['price'] = this.price;
    data['fees'] = this.fees;
    data['numberOfCars'] = this.numberOfCars;
    data['maxDiscountPerTime'] = this.maxDiscountPerTime;
    data['numberOfDiscountTimes'] = this.numberOfDiscountTimes;
    data['numberOfDiscountTimesOther'] = this.numberOfDiscountTimesOther;
    data['discountPercentage'] = this.discountPercentage;
    data['discountAfterMaxTimes'] = this.discountAfterMaxTimes;
    data['numberOfDays'] = this.numberOfDays;
    data['arDescription'] = this.arDescription;
    data['enDescription'] = this.enDescription;
    data['active'] = this.active;
    data['private'] = this.private;
    data['activateAfterDays'] = this.activateAfterDays;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['insuranceCompanyId'] = this.insuranceCompanyId;
    data['BrokerId'] = this.brokerId;
    data['corporateCompanyId'] = this.corporateCompanyId;
    if (this.packageBenefits != null) {
      data['PackageBenefits'] =
          this.packageBenefits!.map((v) => v.toJson()).toList();
    }
    data['CorporateCompany'] = this.corporateCompany;
    data['insuranceCompany'] = this.insuranceCompany;
    data['Broker'] = this.broker;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['orderId'] = this.orderId;
    data['deletedAt'] = this.deletedAt;
    data['PackageId'] = this.packageId;
    data['ClientId'] = this.clientId;
    if (this.carPackages != null) {
      data['CarPackages'] = this.carPackages!.map((v) => v.toJson()).toList();
    }
    if (this.usedPromosPackages != null) {
      data['UsedPromosPackages'] =
          this.usedPromosPackages!.map((v) => v.toJson()).toList();
    }
    data['assignedCars'] = this.assignedCars;
    data['requestsInThisPackag'] = this.requestsInThisPackag;
    data['requestsInThisPackageOtherServices'] = this.requestsInThisPackageOtherServices;
    return data;
  }
}

class PackageBenefits {
  int? id;
  String? enName;
  String? arName;
  String? createdAt;
  String? updatedAt;
  int? packageId;

  PackageBenefits(
      {this.id,
        this.enName,
        this.arName,
        this.createdAt,
        this.updatedAt,
        this.packageId});

  PackageBenefits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['enName'] = this.enName;
    data['arName'] = this.arName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['packageId'] = this.packageId;
    return data;
  }
}

class CarPackages {
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  int? carId;
  int? clientPackageId;
  int? packageId;
  Car? car;

  CarPackages(
      {this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.carId,
        this.clientPackageId,
        this.packageId,
        this.car});

  CarPackages.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    carId = json['CarId'];
    clientPackageId = json['ClientPackageId'];
    packageId = json['PackageId'];
    car = json['Car'] != null ? Car.fromJson(json['Car']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['CarId'] = this.carId;
    data['ClientPackageId'] = this.clientPackageId;
    data['PackageId'] = this.packageId;
    if (this.car != null) {
      data['Car'] = this.car!.toJson();
    }
    return data;
  }
}

class Car {
  int? id;
  String? plateNumber;
  int? year;
  var policyNumber;
  var policyStarts;
  var policyEnds;
  var appendixNumber;
  String? vinNumber;
  var policyCanceled;
  String? color;
  var frontLicense;
  var backLicense;
  int? createdBy;
  int? manufacturerId;
  int? carModelId;
  int? clientId;
  var brokerId;
  bool? active;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  var insuranceCompanyId;

  Car(
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
        this.brokerId,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.insuranceCompanyId});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plateNumber = json['plateNumber'];
    year = json['year'];
    policyNumber = json['policyNumber'];
    policyStarts = json['policyStarts'];
    policyEnds = json['policyEnds'];
    appendixNumber = json['appendix_number'];
    vinNumber = json['vin_number'];
    policyCanceled = json['policyCanceled'];
    color = json['color'];
    frontLicense = json['frontLicense'];
    backLicense = json['backLicense'];
    createdBy = json['CreatedBy'];
    manufacturerId = json['ManufacturerId'];
    carModelId = json['CarModelId'];
    clientId = json['ClientId'];
    brokerId = json['BrokerId'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    insuranceCompanyId = json['insuranceCompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['plateNumber'] = this.plateNumber;
    data['year'] = this.year;
    data['policyNumber'] = this.policyNumber;
    data['policyStarts'] = this.policyStarts;
    data['policyEnds'] = this.policyEnds;
    data['appendix_number'] = this.appendixNumber;
    data['vin_number'] = this.vinNumber;
    data['policyCanceled'] = this.policyCanceled;
    data['color'] = this.color;
    data['frontLicense'] = this.frontLicense;
    data['backLicense'] = this.backLicense;
    data['CreatedBy'] = this.createdBy;
    data['ManufacturerId'] = this.manufacturerId;
    data['CarModelId'] = this.carModelId;
    data['ClientId'] = this.clientId;
    data['BrokerId'] = this.brokerId;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['insuranceCompanyId'] = this.insuranceCompanyId;
    return data;
  }
}
