class SettingTypesModel {
  String? status;
  List<SettingTypes>? types;

  SettingTypesModel({this.status, this.types});

  SettingTypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['types'] != null) {
      types = <SettingTypes>[];
      json['types'].forEach((v) {
        types!.add(SettingTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SettingTypes {
  int? id;
  String? enName;
  String? arName;
  int? baseCost;
  num? costPerKm;
  String? createdAt;
  String? updatedAt;
  int? carType;

  SettingTypes(
      {this.id,
      this.enName,
      this.arName,
      this.baseCost,
      this.costPerKm,
      this.createdAt,
      this.updatedAt,
      this.carType});

  SettingTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    baseCost = json['base_cost'];
    costPerKm = json['costPerKm'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    carType = json['car_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['base_cost'] = baseCost;
    data['costPerKm'] = costPerKm;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['car_type'] = carType;
    return data;
  }
}
