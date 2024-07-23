class VehiclesStatisticsModel {
  String? status;
  Stats? stats;

  VehiclesStatisticsModel({this.status, this.stats});

  VehiclesStatisticsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }
}

class Stats {
  AllVehicles? allVehicles;
  AllVehicles? onlineVehicles;
  AllVehicles? offlineVehicles;
  AllVehicles? busyVehicles;
  AllVehicles? availableVehicles;

  Stats(
      {this.allVehicles,
      this.onlineVehicles,
      this.offlineVehicles,
      this.busyVehicles,
      this.availableVehicles});

  Stats.fromJson(Map<String, dynamic> json) {
    allVehicles = json['allVehicles'] != null
        ? AllVehicles.fromJson(json['allVehicles'])
        : null;
    onlineVehicles = json['onlineVehicles'] != null
        ? AllVehicles.fromJson(json['onlineVehicles'])
        : null;
    offlineVehicles = json['offlineVehicles'] != null
        ? AllVehicles.fromJson(json['offlineVehicles'])
        : null;
    busyVehicles = json['busyVehicles'] != null
        ? AllVehicles.fromJson(json['busyVehicles'])
        : null;
    availableVehicles = json['availableVehicles'] != null
        ? AllVehicles.fromJson(json['availableVehicles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allVehicles != null) {
      data['allVehicles'] = allVehicles!.toJson();
    }
    if (onlineVehicles != null) {
      data['onlineVehicles'] = onlineVehicles!.toJson();
    }
    if (offlineVehicles != null) {
      data['offlineVehicles'] = offlineVehicles!.toJson();
    }
    if (busyVehicles != null) {
      data['busyVehicles'] = busyVehicles!.toJson();
    }
    if (availableVehicles != null) {
      data['availableVehicles'] = availableVehicles!.toJson();
    }
    return data;
  }
}

class AllVehicles {
  int? count;
  List<VehiclesRows>? rows;

  AllVehicles({this.count, this.rows});

  AllVehicles.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <VehiclesRows>[];
      json['rows'].forEach((v) {
        rows!.add(VehiclesRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehiclesRows {
  int? id;
  String? vecPlate;
  String? vecName;
  int? vecNum;
  String? phoneNumber;
  String? iMEI;
  bool? available;
  String? url;
  String? createdAt;
  String? updatedAt;
  int? activeDriver;
  int? vecType;

  VehiclesRows(
      {this.id,
      this.vecPlate,
      this.vecName,
      this.vecNum,
      this.phoneNumber,
      this.iMEI,
      this.available,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.activeDriver,
      this.vecType});

  VehiclesRows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vecPlate = json['Vec_plate'];
    vecName = json['Vec_name'];
    vecNum = json['Vec_num'];
    phoneNumber = json['PhoneNumber'];
    iMEI = json['IMEI'];
    available = json['available'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    activeDriver = json['Active_Driver'];
    vecType = json['Vec_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Vec_plate'] = vecPlate;
    data['Vec_name'] = vecName;
    data['Vec_num'] = vecNum;
    data['PhoneNumber'] = phoneNumber;
    data['IMEI'] = iMEI;
    data['available'] = available;
    data['url'] = url;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['Active_Driver'] = activeDriver;
    data['Vec_type'] = vecType;
    return data;
  }
}
