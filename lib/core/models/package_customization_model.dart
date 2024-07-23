class PackageCustomizationModel {
  final int packageId;
  final String sms;
  final bool year;
  final bool carBrand;
  final bool carModel;
  final bool color;
  final bool vinNumber;
  final bool policyNumber;
  final bool policyStartDate;
  final bool policyEndDate;
  final bool carPlate;
  final bool email;
  final bool insuranceCompanyId;

  PackageCustomizationModel({
    required this.packageId,
    required this.sms,
    required this.year,
    required this.carBrand,
    required this.carModel,
    required this.color,
    required this.vinNumber,
    required this.policyNumber,
    required this.policyStartDate,
    required this.policyEndDate,
    required this.carPlate,
    required this.email,
    required this.insuranceCompanyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'packageId': packageId,
      'SMS': sms,
      'year': year,
      'CarBrand': carBrand,
      'CarModel': carModel,
      'color': color,
      'Vin_number': vinNumber,
      'PolicyNumber': policyNumber,
      'PolicyStartDate': policyStartDate,
      'PolicyEndDate': policyEndDate,
      'CarPlate': carPlate,
      'email': email,
      'insuranceCompanyId': insuranceCompanyId,
    };
  }
}
