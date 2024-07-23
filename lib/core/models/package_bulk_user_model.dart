class PackageBulkUserModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? year;
  String? carBrand;
  String? carModel;
  String? color;
  String? vinNumber;
  String? policyNumber;
  String? policyStartDate;
  String? policyEndDate;
  String? carPlate;
  String? insuranceCompanyId;
  String? error;

  PackageBulkUserModel({
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
    this.insuranceCompanyId,
    this.error,
  });

  PackageBulkUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    phoneNumber = json['PhoneNumber'] ?? '';
    email = json['email'] ?? '';
    year = json['year'] ?? '';
    carBrand = json['CarBrand'] ?? '';
    carModel = json['CarModel'] ?? '';
    color = json['color'] ?? '';
    vinNumber = json['Vin_number'] ?? '';
    policyNumber = json['PolicyNumber'] ?? '';
    policyStartDate = json['PolicyStartDate'] ?? '';
    policyEndDate = json['PolicyEndDate'] ?? '';
    carPlate = json['CarPlate'] ?? '';
    insuranceCompanyId = json['insuranceCompanyId'] ?? '';
    error = json['error'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'PhoneNumber': phoneNumber,
      'email': email,
      'year': year,
      'CarBrand': carBrand,
      'CarModel': carModel,
      'color': color,
      'Vin_number': vinNumber,
      'PolicyNumber': policyNumber,
      'PolicyStartDate': policyStartDate,
      'PolicyEndDate': policyEndDate,
      'CarPlate': carPlate,
      'insuranceCompanyId': insuranceCompanyId,
      'error': error,
    };
  }
}
