class PromoCodeUsersModel {
  String? status;
  List<Promoes>? promoes;

  PromoCodeUsersModel({this.status, this.promoes});

  PromoCodeUsersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['promoes'] != null) {
      promoes = <Promoes>[];
      json['promoes'].forEach((v) {
        promoes!.add(Promoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (promoes != null) {
      data['promoes'] = promoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promoes {
  int? id;
  int? fees;
  String? createdAt;
  String? updatedAt;
  int? packageId;
  int? packagePromoCodeId;
  int? userId;
  PromoUser? user;
  PackagePromoCode? packagePromoCode;
  Package? package;

  Promoes(
      {this.id,
      this.fees,
      this.createdAt,
      this.updatedAt,
      this.packageId,
      this.packagePromoCodeId,
      this.userId,
      this.user,
      this.packagePromoCode,
      this.package});

  Promoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fees = json['fees'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    packageId = json['PackageId'];
    packagePromoCodeId = json['PackagePromoCodeId'];
    userId = json['UserId'];

    user = json['User'] != null ? PromoUser.fromJson(json['User']) : null;
    packagePromoCode = json['PackagePromoCode'] != null
        ? PackagePromoCode.fromJson(json['PackagePromoCode'])
        : null;
    package =
        json['Package'] != null ? Package.fromJson(json['Package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fees'] = fees;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['PackageId'] = packageId;
    data['PackagePromoCodeId'] = packagePromoCodeId;
    data['UserId'] = userId;

    if (user != null) {
      data['User'] = user!.toJson();
    }
    if (packagePromoCode != null) {
      data['PackagePromoCode'] = packagePromoCode!.toJson();
    }
    if (package != null) {
      data['Package'] = package!.toJson();
    }
    return data;
  }
}

class PromoUser {
  int? id;
  String? phoneNumber;

  String? password;
  String? username;
  String? name;
  bool? blocked;
  String? photo;
  bool? deleted;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  PromoUser({
    this.id,
    this.phoneNumber,
    this.password,
    this.username,
    this.name,
    this.blocked,
    this.photo,
    this.deleted,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  PromoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['PhoneNumber'];

    password = json['password'];
    username = json['username'];
    name = json['name'];
    blocked = json['blocked'];
    photo = json['photo'];
    deleted = json['deleted'];
    roleId = json['RoleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['PhoneNumber'] = phoneNumber;

    data['password'] = password;
    data['username'] = username;
    data['name'] = name;
    data['blocked'] = blocked;
    data['photo'] = photo;
    data['deleted'] = deleted;
    data['RoleId'] = roleId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}

class PackagePromoCode {
  int? id;
  String? name;
  String? value;
  String? startDate;
  String? expiryDate;
  String? usageExpiryDate;
  int? percentage;
  int? count;
  int? maxCount;
  int? feesDiscount;
  bool? private;
  bool? active;
  String? sMS;
  String? createdAt;
  String? updatedAt;
  int? corporateCompanyId;
  CorporateCompany? corporateCompany;

  PackagePromoCode(
      {this.id,
      this.name,
      this.value,
      this.startDate,
      this.expiryDate,
      this.usageExpiryDate,
      this.percentage,
      this.count,
      this.maxCount,
      this.feesDiscount,
      this.private,
      this.active,
      this.sMS,
      this.createdAt,
      this.updatedAt,
      this.corporateCompanyId,
      this.corporateCompany});

  PackagePromoCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    startDate = json['startDate'];
    expiryDate = json['expiryDate'];
    usageExpiryDate = json['usageExpiryDate'];
    percentage = json['percentage'];
    count = json['count'];
    maxCount = json['maxCount'];
    feesDiscount = json['feesDiscount'];
    private = json['private'];
    active = json['active'];
    sMS = json['SMS'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    corporateCompanyId = json['CorporateCompanyId'];
    corporateCompany = json['CorporateCompany'] != null
        ? CorporateCompany.fromJson(json['CorporateCompany'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['startDate'] = startDate;
    data['expiryDate'] = expiryDate;
    data['usageExpiryDate'] = usageExpiryDate;
    data['percentage'] = percentage;
    data['count'] = count;
    data['maxCount'] = maxCount;
    data['feesDiscount'] = feesDiscount;
    data['private'] = private;
    data['active'] = active;
    data['SMS'] = sMS;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['CorporateCompanyId'] = corporateCompanyId;
    if (corporateCompany != null) {
      data['CorporateCompany'] = corporateCompany!.toJson();
    }
    return data;
  }
}

class CorporateCompany {
  int? id;
  String? enName;
  String? arName;
  int? discountRatio;
  bool? deferredPayment;

  bool? cash;
  bool? cardToDriver;
  bool? online;
  String? photo;

  String? createdAt;
  String? updatedAt;

  CorporateCompany(
      {this.id,
      this.enName,
      this.arName,
      this.discountRatio,
      this.deferredPayment,
      this.cash,
      this.cardToDriver,
      this.online,
      this.photo,
      this.createdAt,
      this.updatedAt});

  CorporateCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    discountRatio = json['discount_ratio'];
    deferredPayment = json['deferredPayment'];

    cash = json['cash'];
    cardToDriver = json['cardToDriver'];
    online = json['online'];
    photo = json['photo'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['discount_ratio'] = discountRatio;
    data['deferredPayment'] = deferredPayment;

    data['cash'] = cash;
    data['cardToDriver'] = cardToDriver;
    data['online'] = online;
    data['photo'] = photo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Package {
  int? id;
  String? enName;
  String? arName;
  int? originalFees;
  int? price;
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

  Package({
    this.id,
    this.enName,
    this.arName,
    this.originalFees,
    this.price,
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
  });

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    originalFees = json['originalFees'];
    price = json['price'];
    fees = json['fees'];
    numberOfCars = json['numberOfCars'];
    maxDiscountPerTime = json['maxDiscountPerTime'];
    numberOfDiscountTimes = json['numberOfDiscountTimes'];
    discountPercentage = json['discountPercentage'];
    discountAfterMaxTimes = json['discountAfterMaxTimes'];
    numberOfDays = json['numberOfDays'];
    arDescription = json['arDescription'];
    enDescription = json['enDescription'];
    active = json['active'];
    private = json['private'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enName'] = enName;
    data['arName'] = arName;
    data['originalFees'] = originalFees;
    data['price'] = price;
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
    return data;
  }
}
