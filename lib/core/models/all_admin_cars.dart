class AllAdminCarsModel {
  String? status;
  int? totalCount;
  int? currentPage;
  int? totalPages;
  List<AdminCarModel>? cars;

  AllAdminCarsModel(
      {this.status,
      this.totalCount,
      this.currentPage,
      this.totalPages,
      this.cars});

  AllAdminCarsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    totalCount = json['totalCount'] ?? 0;
    currentPage = json['currentPage'] ?? 0;
    totalPages = json['totalPages'] ?? 0;
    if (json['cars'] != null) {
      cars = <AdminCarModel>[];
      json['cars'].forEach((v) {
        cars!.add(AdminCarModel.fromJson(v));
      });
    } else {
      cars = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalCount'] = totalCount;
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminCarModel {
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
  int? createdBy;
  int? manufacturerId;
  int? carModelId;
  int? clientId;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? insuranceCompanyId;
  Manufacturer? manufacturer;
  CarDataModel? carModel;
  Client? client;
  AdminCarInsuranceCompany? insuranceCompany;

  AdminCarModel(
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
      this.createdBy,
      this.manufacturerId,
      this.carModelId,
      this.clientId,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.insuranceCompanyId,
      this.manufacturer,
      this.carModel,
      this.client,
      this.insuranceCompany});

  AdminCarModel.fromJson(Map<String, dynamic> json) {
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

    createdBy = json['CreatedBy'] ?? 0;
    manufacturerId = json['ManufacturerId'] ?? 0;
    carModelId = json['CarModelId'] ?? 0;
    clientId = json['ClientId'] ?? 0;
    active = json['active'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';

    insuranceCompanyId = json['insuranceCompanyId'] ?? 0;
    manufacturer = json['Manufacturer'] != null
        ? Manufacturer.fromJson(json['Manufacturer'])
        : null;
    carModel = json['CarModel'] != null
        ? CarDataModel.fromJson(json['CarModel'])
        : null;
    client = json['Client'] != null ? Client.fromJson(json['Client']) : null;
    insuranceCompany = json['insuranceCompany'] != null
        ? AdminCarInsuranceCompany.fromJson(json['insuranceCompany'])
        : null;
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

    data['CreatedBy'] = createdBy;
    data['ManufacturerId'] = manufacturerId;
    data['CarModelId'] = carModelId;
    data['ClientId'] = clientId;
    data['active'] = active;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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

  Manufacturer(
      {this.id, this.enName, this.arName, this.createdAt, this.updatedAt});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
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

class CarDataModel {
  int? id;
  String? enName;
  String? arName;
  String? createdAt;
  String? updatedAt;
  int? manufacturerId;

  CarDataModel(
      {this.id,
      this.enName,
      this.arName,
      this.createdAt,
      this.updatedAt,
      this.manufacturerId});

  CarDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    manufacturerId = json['ManufacturerId'] ?? 0;
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
  bool? confirmed;
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

class AdminCarInsuranceCompany {
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

  AdminCarInsuranceCompany(
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

  AdminCarInsuranceCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    packageRequestCount = json['package_request_count'] ?? 0;
    packageDiscountPercentage = json['package_discount_percentage'] ?? 0;
    maxTotalDiscount = json['max_total_discount'] ?? 0;
    discountPercentAfterPolicyExpires =
        json['discount_percent_after_policy_expires'] ?? 0;
    startDate = json['startDate'] ?? '';
    endDate = json['endDate'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
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
