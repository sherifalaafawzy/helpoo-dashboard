class VehiclesTypesModel {
  String? status;
  List<VehicleTypeModel>? types;

  VehiclesTypesModel({this.status, this.types});

  VehiclesTypesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    if (json['types'] != null) {
      types = <VehicleTypeModel>[];
      json['types'].forEach((v) {
        types!.add(VehicleTypeModel.fromJson(v));
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

class VehicleTypeModel {
  int? id;
  String? typeName;
  String? createdAt;
  String? updatedAt;

  VehicleTypeModel({this.id, this.typeName, this.createdAt, this.updatedAt});

  VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    typeName = json['TypeName'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['TypeName'] = typeName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
