import 'broker_model.dart';
import 'insurance_companies_model.dart';
import 'package:intl/intl.dart';

class GetAllPackagesResponse {
  List<PackageModel>? packages;

  GetAllPackagesResponse({this.packages});

  GetAllPackagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages!.add(PackageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'packages': packages!.map((v) => v.toJson()).toList(),
    };
  }
}

//******************************************************************************
class PackageModel {
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
  int? insuranceCompanyId;
  int? brokerId;
  int? corporateCompanyId;
  List<PackageBenefits>? packageBenefits;

  List<PackageCustomizations>? packageCustomizations;
  PackageCorporateCompany? corporateCompany;
  InsuranceCompany? insuranceCompany;
  Broker? broker;

  PackageModel({
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
    this.insuranceCompanyId,
    this.brokerId,
    this.corporateCompanyId,
    this.packageBenefits,
    this.packageCustomizations,
    this.corporateCompany,
    this.insuranceCompany,
    this.broker,
  });

  PackageModel.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a')
            .format(DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(json['createdAt']).toLocal())
        : '';
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

    corporateCompany =
        json['CorporateCompany'] != null ? PackageCorporateCompany.fromJson(json['CorporateCompany']) : null;

    insuranceCompany = json['insuranceCompany'] != null ? InsuranceCompany.fromJson(json['insuranceCompany']) : null;
    broker = json['Broker'] != null ? Broker.fromJson(json['Broker']) : null;
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enName': enName,
      'arName': arName,
      'fees': fees,
      'numberOfCars': numberOfCars,
      'maxDiscountPerTime': maxDiscountPerTime,
      'numberOfDiscountTimes': numberOfDiscountTimes,
      'discountPercentage': discountPercentage,
      'discountAfterMaxTimes': discountAfterMaxTimes,
      'numberOfDays': numberOfDays,
      'arDescription': arDescription,
      'enDescription': enDescription,
      'active': active,
      'private': private,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'insuranceCompanyId': insuranceCompanyId,
      'corporateCompanyId': corporateCompanyId,

      'PackageBenefits': packageBenefits!.map((v) => v.toJson()).toList(),
    };
  }
}

//******************************************************************************
class PackageBenefits {
  int? id;
  String? enName;
  String? arName;
  String? createdAt;
  String? updatedAt;
  int? packageId;

  PackageBenefits({
    this.id,
    this.enName,
    this.arName,
    this.createdAt,
    this.updatedAt,
    this.packageId,
  });

  PackageBenefits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['enName'];
    arName = json['arName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enName': enName,
      'arName': arName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'packageId': packageId,
    };
  }
}

class PackageCustomizations {
  int? id;
  bool? name;
  bool? phoneNumber;
  bool? email;
  bool? year;
  bool? carBrand;
  bool? carModel;
  bool? color;
  bool? vinNumber;
  bool? policyNumber;
  bool? policyStartDate;
  bool? policyEndDate;
  bool? carPlate;
  String? sMS;
  String? createdAt;
  String? updatedAt;
  int? packageId;

  PackageCustomizations(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.year,
      this.carBrand,
      this.carModel,
      this.color,
      this.vinNumber,
      this.policyNumber,
      this.policyStartDate,
      this.policyEndDate,
      this.carPlate,
      this.sMS,
      this.createdAt,
      this.updatedAt,
      this.packageId});

  PackageCustomizations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['PhoneNumber'];
    email = json['email'];
    year = json['year'];
    carBrand = json['CarBrand'];
    carModel = json['CarModel'];
    color = json['color'];
    vinNumber = json['Vin_number'];
    policyNumber = json['PolicyNumber'];
    policyStartDate = json['PolicyStartDate'];
    policyEndDate = json['PolicyEndDate'];
    carPlate = json['CarPlate'];
    sMS = json['SMS'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    packageId = json['PackageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['PhoneNumber'] = phoneNumber;
    data['email'] = email;
    data['year'] = year;
    data['CarBrand'] = carBrand;
    data['CarModel'] = carModel;
    data['color'] = color;
    data['Vin_number'] = vinNumber;
    data['PolicyNumber'] = policyNumber;
    data['PolicyStartDate'] = policyStartDate;
    data['PolicyEndDate'] = policyEndDate;
    data['CarPlate'] = carPlate;
    data['SMS'] = sMS;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['PackageId'] = packageId;
    return data;
  }
}

class PackageCorporateCompany {
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

  PackageCorporateCompany(
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

  PackageCorporateCompany.fromJson(Map<String, dynamic> json) {
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
