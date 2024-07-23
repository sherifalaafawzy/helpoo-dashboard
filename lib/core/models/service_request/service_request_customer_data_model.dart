class ServiceRequestCustomerDataModel {
  String? status;
  ServiceRequestCarData? car;
  User? user;

  ServiceRequestCustomerDataModel({this.status, this.car, this.user});

  ServiceRequestCustomerDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    car = json['car'] != null
        ? ServiceRequestCarData.fromJson(json['car'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ServiceRequestCarData {
  int? id;
  String? plateNumber;
  int? year;
  String? policyNumber;

  String? color;

  int? createdBy;
  int? manufacturerId;
  int? carModelId;
  int? clientId;

  bool? active;
  String? createdAt;
  String? updatedAt;

  int? insuranceCompanyId;
  Manufacturer? manufacturer;
  ServiceRequestInsuranceCompany? insuranceCompany;
  ServiceRequestCarModel? carModel;

  ServiceRequestCarData(
      {this.id,
      this.plateNumber,
      this.year,
      this.policyNumber,
      this.color,
      this.createdBy,
      this.manufacturerId,
      this.carModelId,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.insuranceCompanyId,
      this.manufacturer,
      this.insuranceCompany,
      this.clientId,
      this.carModel});

  ServiceRequestCarData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['ClientId'] ?? 0;
    plateNumber = json['plateNumber'];
    year = json['year'];
    policyNumber = json['policyNumber'];

    color = json['color'];

    createdBy = json['CreatedBy'];
    manufacturerId =
        json['ManufacturerId'];
    carModelId = json['CarModelId'];

    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    insuranceCompanyId =
        json['insuranceCompanyId'];
    manufacturer = json['Manufacturer'] != null
        ? Manufacturer.fromJson(json['Manufacturer'])
        : null;
    insuranceCompany = json['insuranceCompany'] != null
        ? ServiceRequestInsuranceCompany.fromJson(json['insuranceCompany'])
        : null;
    carModel = json['CarModel'] != null
        ? ServiceRequestCarModel.fromJson(json['CarModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plateNumber'] = plateNumber;
    data['year'] = year;
    data['policyNumber'] = policyNumber;

    data['color'] = color;

    data['CreatedBy'] = createdBy;
    data['ManufacturerId'] = manufacturerId;
    data['CarModelId'] = carModelId;

    data['active'] = active;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['insuranceCompanyId'] = insuranceCompanyId;
    if (manufacturer != null) {
      data['Manufacturer'] = manufacturer!.toJson();
    }
    if (insuranceCompany != null) {
      data['insuranceCompany'] = insuranceCompany!.toJson();
    }
    if (carModel != null) {
      data['CarModel'] = carModel!.toJson();
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

  Manufacturer(
      {this.id, this.enName, this.arName, this.createdAt, this.updatedAt});

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

class ServiceRequestInsuranceCompany {
  int? id;
  String? enName;
  String? arName;
  int? packageRequestCount;
  int? packageDiscountPercentage;
  int? maxTotalDiscount;
  int? discountPercentAfterPolicyExpires;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  ServiceRequestInsuranceCompany(
      {this.id,
      this.enName,
      this.arName,
      this.packageRequestCount,
      this.packageDiscountPercentage,
      this.maxTotalDiscount,
      this.discountPercentAfterPolicyExpires,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  ServiceRequestInsuranceCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    packageRequestCount = json['package_request_count'];
    packageDiscountPercentage = json['package_discount_percentage'];
    maxTotalDiscount =
        json['max_total_discount'];
    discountPercentAfterPolicyExpires =
        json['discount_percent_after_policy_expires'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['package_request_count'] = packageRequestCount;
    data['package_discount_percentage'] = packageDiscountPercentage;
    data['max_total_discount'] = maxTotalDiscount;
    data['discount_percent_after_policy_expires'] =
        discountPercentAfterPolicyExpires;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ServiceRequestCarModel {
  int? id;
  String? enName;
  String? arName;
  String? createdAt;
  String? updatedAt;
  int? manufacturerId;

  ServiceRequestCarModel(
      {this.id,
      this.enName,
      this.arName,
      this.createdAt,
      this.updatedAt,
      this.manufacturerId});

  ServiceRequestCarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    manufacturerId =
        json['ManufacturerId'];
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

class User {
  String? phoneNumber;
  String? name;
  String? email;
  int? roleId;
  int? id;
  int? userId;

  User(
      {this.phoneNumber,
      this.name,
      this.email,
      this.roleId,
      this.id,
      this.userId});

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['PhoneNumber'];
    name = json['name'];
    email = json['email'];
    roleId = json['RoleId'];
    id = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PhoneNumber'] = phoneNumber;
    data['name'] = name;
    data['email'] = email;
    data['RoleId'] = roleId;
    data['id'] = id;
    data['userId'] = userId;
    return data;
  }
}
