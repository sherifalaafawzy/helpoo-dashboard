class CustomerSearchModel {
  String? status;
  RequestUser? user;
  RequestClient? client;
  List<Packages>? packages;

  CustomerSearchModel({this.status, this.user, this.client, this.packages});

  CustomerSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? RequestUser.fromJson(json['user']) : null;
    client =
        json['client'] != null ? RequestClient.fromJson(json['client']) : null;
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestUser {
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

  RequestUser(
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

  RequestUser.fromJson(Map<String, dynamic> json) {
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

class RequestClient {
  int? id;
  bool? active;
  bool? confirmed;
  String? fcmtoken;
  String? createdAt;
  String? updatedAt;
  int? userId;

  RequestClient(
      {this.id,
      this.active,
      this.confirmed,
      this.fcmtoken,
      this.createdAt,
      this.updatedAt,
      this.userId});

  RequestClient.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    active = json['active'] ?? false;
    confirmed = json['confirmed'] ?? false;
    fcmtoken = json['fcmtoken'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    userId = json['UserId'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['confirmed'] = confirmed;
    data['fcmtoken'] = fcmtoken;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['UserId'] = userId;
    return data;
  }
}

class Packages {
  int? id;
  String? enName;
  String? arName;
  int? fees;
  int? numberOfCars;
  int? maxDiscountPerTime;
  int? numberOfDiscountTimes;
  int? discountPercentage;
  int? discountAfterMaxTimes;
  int? numberOfDays;
  String? arDescription;
  String? enDescription;
  bool? active;
  bool? private;
  String? createdAt;
  String? updatedAt;
  int? insuranceCompanyId;
  int? corporateCompanyId;
  String? startDate;
  String? endDate;
  int? orderId;
  int? packageId;
  int? clientId;
  int? assignedCars;

  Packages(
      {this.id,
      this.enName,
      this.arName,
      this.fees,
      this.numberOfCars,
      this.maxDiscountPerTime,
      this.numberOfDiscountTimes,
      this.discountPercentage,
      this.discountAfterMaxTimes,
      this.numberOfDays,
      this.arDescription,
      this.enDescription,
      this.active,
      this.private,
      this.createdAt,
      this.updatedAt,
      this.insuranceCompanyId,
      this.corporateCompanyId,
      this.startDate,
      this.endDate,
      this.orderId,
      this.packageId,
      this.clientId,
      this.assignedCars});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['enName'] ?? '';
    arName = json['arName'] ?? '';
    fees = json['fees'] ?? 0;
    numberOfCars = json['numberOfCars'] ?? 0;
    maxDiscountPerTime = json['maxDiscountPerTime'] ?? 0;
    numberOfDiscountTimes = json['numberOfDiscountTimes'] ?? 0;
    discountPercentage = json['discountPercentage'] ?? 0;
    discountAfterMaxTimes = json['discountAfterMaxTimes'] ?? 0;
    numberOfDays = json['numberOfDays'] ?? 0;
    arDescription = json['arDescription'] ?? '';
    enDescription = json['enDescription'] ?? '';
    active = json['active'] ?? false;
    private = json['private'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    insuranceCompanyId = json['insuranceCompanyId'] ?? 0;
    corporateCompanyId = json['corporateCompanyId'] ?? 0;
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    orderId = json['orderId'] ?? 0;
    packageId = json['PackageId'] ?? 0;
    clientId = json['ClientId'] ?? 0;
    assignedCars = json['assignedCars'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enName'] = enName;
    data['arName'] = arName;
    data['fees'] = fees;
    data['numberOfCars'] = numberOfCars;
    data['maxDiscountPerTime'] = maxDiscountPerTime;
    data['numberOfDiscountTimes'] = numberOfDiscountTimes;
    data['discountPercentage'] = discountPercentage;
    data['discountAfterMaxTimes'] = discountAfterMaxTimes;
    data['numberOfDays'] = numberOfDays;
    data['arDescription'] = arDescription;
    data['enDescription'] = enDescription;
    data['active'] = active;
    data['private'] = private;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['insuranceCompanyId'] = insuranceCompanyId;
    data['corporateCompanyId'] = corporateCompanyId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['orderId'] = orderId;
    data['PackageId'] = packageId;
    data['ClientId'] = clientId;
    data['assignedCars'] = assignedCars;
    return data;
  }
}
