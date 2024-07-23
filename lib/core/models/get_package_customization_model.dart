class GetPackageCustomizationModel {
  Customization? customization;

  GetPackageCustomizationModel({this.customization});

  GetPackageCustomizationModel.fromJson(Map<String, dynamic> json) {
    customization = json['customization'] != null ? Customization.fromJson(json['customization']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customization != null) {
      data['customization'] = customization!.toJson();
    }
    return data;
  }
}

class Customization {
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
  bool? insuranceCompanyId;

  Customization({
    this.id,
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
    this.packageId,
    this.insuranceCompanyId,
  });

  Customization.fromJson(Map<String, dynamic> json) {
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
    insuranceCompanyId = json['insuranceCompanyId'];
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
    data['insuranceCompanyId'] = insuranceCompanyId;
    return data;
  }
}
