class CreatePackageModel {
  String? status;
  NewPackage? newPackage;

  CreatePackageModel({this.status, this.newPackage});

  CreatePackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    newPackage = json['newPackage'] != null
        ? NewPackage.fromJson(json['newPackage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (newPackage != null) {
      data['newPackage'] = newPackage!.toJson();
    }
    return data;
  }
}

class NewPackage {
  Package? newPackage;
  List<PackageBenefits>? packageBenefits;

  NewPackage({this.newPackage, this.packageBenefits});

  NewPackage.fromJson(Map<String, dynamic> json) {
    newPackage = json['newPackage'] != null
        ? Package.fromJson(json['newPackage'])
        : null;
    if (json['packageBenefits'] != null) {
      packageBenefits = <PackageBenefits>[];
      json['packageBenefits'].forEach((v) {
        packageBenefits!.add(PackageBenefits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newPackage != null) {
      data['newPackage'] = newPackage!.toJson();
    }
    if (packageBenefits != null) {
      data['packageBenefits'] =
          packageBenefits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  int? id;
  String? enName;
  String? arName;
  String? enDescription;
  String? arDescription;
  int? fees;
  int? price;
  int? originalFees;
  int? maxDiscountPerTime;
  int? discountPercentage;
  int? numberOfDays;
  int? numberOfCars;
  bool? active;
  bool? private;
  int? corporateCompanyId;
  int? discountAfterMaxTimes;
  String? updatedAt;
  String? createdAt;

  Package({
    this.id,
    this.enName,
    this.arName,
    this.enDescription,
    this.arDescription,
    this.fees,
    this.price,
    this.originalFees,
    this.maxDiscountPerTime,
    this.discountPercentage,
    this.numberOfDays,
    this.numberOfCars,
    this.active,
    this.private,
    this.corporateCompanyId,
    this.discountAfterMaxTimes,
    this.updatedAt,
    this.createdAt,
  });

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    enDescription = json['enDescription'];
    arDescription = json['arDescription'];
    fees = json['fees'];
    price = json['price'];
    originalFees = json['originalFees'];
    maxDiscountPerTime = json['maxDiscountPerTime'];
    discountPercentage = json['discountPercentage'];
    numberOfDays = json['numberOfDays'];
    numberOfCars = json['numberOfCars'];
    active = json['active'];
    private = json['private'];
    corporateCompanyId = json['corporateCompanyId'];
    discountAfterMaxTimes = json['discountAfterMaxTimes'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enName'] = enName;
    data['arName'] = arName;
    data['enDescription'] = enDescription;
    data['arDescription'] = arDescription;
    data['fees'] = fees;
    data['price'] = price;
    data['originalFees'] = originalFees;
    data['maxDiscountPerTime'] = maxDiscountPerTime;
    data['discountPercentage'] = discountPercentage;
    data['numberOfDays'] = numberOfDays;
    data['numberOfCars'] = numberOfCars;
    data['active'] = active;
    data['private'] = private;
    data['corporateCompanyId'] = corporateCompanyId;
    data['discountAfterMaxTimes'] = discountAfterMaxTimes;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;

    return data;
  }
}

class PackageBenefits {
  int? id;
  String? enName;
  String? arName;
  int? packageId;
  String? createdAt;
  String? updatedAt;

  PackageBenefits(
      {this.id,
      this.enName,
      this.arName,
      this.packageId,
      this.createdAt,
      this.updatedAt});

  PackageBenefits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    packageId = json['packageId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enName'] = enName;
    data['arName'] = arName;
    data['packageId'] = packageId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
