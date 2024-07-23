class CreatePolicyModel {
  String? phoneNumber;
  String? name;
  String? email;
  PolicyCarModel? car;

  CreatePolicyModel({this.phoneNumber, this.name, this.email, this.car});

  CreatePolicyModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    email = json['email'];
    car = json['car'] != null ? PolicyCarModel.fromJson(json['car']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['name'] = name;
    data['email'] = email;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    return data;
  }
}

class PolicyCarModel {
  String? plateNumber;
  String? year;
  String? policyNumber;
  int? insuranceCompanyId;
  String? color;
  int? manufacturerId;
  int? carModelId;
  String? policyEnds;
  String? policyStarts;
  String? appendixNumber;
  String? vinNumber;

  PolicyCarModel(
      {this.plateNumber,
      this.year,
      this.policyNumber,
      this.insuranceCompanyId,
      this.color,
      this.manufacturerId,
      this.carModelId,
      this.policyEnds,
      this.policyStarts,
      this.appendixNumber,
      this.vinNumber});

  PolicyCarModel.fromJson(Map<String, dynamic> json) {
    plateNumber = json['plateNumber'];
    year = json['year'];
    policyNumber = json['policyNumber'];
    insuranceCompanyId = json['insuranceCompanyId'];
    color = json['color'];
    manufacturerId = json['ManufacturerId'];
    carModelId = json['CarModelId'];
    policyEnds = json['policyEnds'];
    policyStarts = json['policyStarts'];
    appendixNumber = json['appendix_number'];
    vinNumber = json['vin_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plateNumber'] = plateNumber;
    data['year'] = year;
    data['policyNumber'] = policyNumber;
    data['insuranceCompanyId'] = insuranceCompanyId;
    data['color'] = color;
    data['ManufacturerId'] = manufacturerId;
    data['CarModelId'] = carModelId;
    data['policyEnds'] = policyEnds;
    data['policyStarts'] = policyStarts;
    data['appendix_number'] = appendixNumber;
    data['vin_number'] = vinNumber;
    return data;
  }
}
