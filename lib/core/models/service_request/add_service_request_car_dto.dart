
class AddServiceRequestCarDto {
  String? phoneNumber;
  String? name;
  String? email;
  String? promoCode;
  String? car;

  AddServiceRequestCarDto(
      {this.phoneNumber, this.name, this.email, this.promoCode, this.car});

  AddServiceRequestCarDto.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    email = json['email'];
    promoCode = json['promoCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['name'] = name;
    data['email'] = email;
    data['promoCode'] = promoCode;
    if (car != null) {
      data['Car'] = car;
    }
    return data;
  }
}

class ServiceRequestCar {
  String? plateNumber;
  String? year;
  String? policyNumber;
  int? insuranceCompanyId;
  String? color;
  int? manufacturerId;
  int? carModelId;
  String? vinNumber;

  ServiceRequestCar(
      {this.plateNumber,
      this.year,
      this.policyNumber,
      this.insuranceCompanyId,
      this.color,
      this.manufacturerId,
      this.vinNumber,
      this.carModelId});

  ServiceRequestCar.fromJson(Map<String, dynamic> json) {
    plateNumber = json['plateNumber'];
    year = json['year'];
    policyNumber = json['policyNumber'];
    insuranceCompanyId = json['insuranceCompanyId'];
    color = json['color'];
    manufacturerId = json['ManufacturerId'];
    carModelId = json['CarModelId'];
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
    data['vin_number'] = vinNumber;
    return data;
  }
}
