class VehiclesStatsResponseModel {
  String? status;
  Stats? stats;

  VehiclesStatsResponseModel({this.status, this.stats});

  VehiclesStatsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    return data;
  }
}

class Stats {
  AllVec? allVehicles;
  AllVec? onlineVehicles;
  AllVec? offlineVehicles;
  AllVec? busyVehicles;
  AllVec? availableVehicles;

  Stats(
      {this.allVehicles,
        this.onlineVehicles,
        this.offlineVehicles,
        this.busyVehicles,
        this.availableVehicles});

  Stats.fromJson(Map<String, dynamic> json) {
    allVehicles = json['allVehicles'] != null
        ? new AllVec.fromJson(json['allVehicles'])
        : null;
    onlineVehicles = json['onlineVehicles'] != null
        ? new AllVec.fromJson(json['onlineVehicles'])
        : null;
    offlineVehicles = json['offlineVehicles'] != null
        ? new AllVec.fromJson(json['offlineVehicles'])
        : null;
    busyVehicles = json['busyVehicles'] != null
        ? new AllVec.fromJson(json['busyVehicles'])
        : null;
    availableVehicles = json['availableVehicles'] != null
        ? new AllVec.fromJson(json['availableVehicles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allVehicles != null) {
      data['allVehicles'] = this.allVehicles!.toJson();
    }
    if (this.onlineVehicles != null) {
      data['onlineVehicles'] = this.onlineVehicles!.toJson();
    }
    if (this.offlineVehicles != null) {
      data['offlineVehicles'] = this.offlineVehicles!.toJson();
    }
    if (this.busyVehicles != null) {
      data['busyVehicles'] = this.busyVehicles!.toJson();
    }
    if (this.availableVehicles != null) {
      data['availableVehicles'] = this.availableVehicles!.toJson();
    }
    return data;
  }
}

class AllVec {
  int? count;
  List<RowsItems>? rows;

  AllVec({this.count, this.rows});

  AllVec.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <RowsItems>[];
      json['rows'].forEach((v) {
        rows!.add(new RowsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RowsItems {
  int? id;
  String? vecPlate;
  String? vecName;
  int? vecNum;
  String? phoneNumber;
  String? iMEI;
  bool? available;
  String? url;
  int? fuelTanks;
  int? battery;
  String? createdAt;
  String? updatedAt;
  int? activeDriver;
  int? vecType;

  RowsItems(
      {this.id,
        this.vecPlate,
        this.vecName,
        this.vecNum,
        this.phoneNumber,
        this.iMEI,
        this.available,
        this.url,
        this.fuelTanks,
        this.battery,
        this.createdAt,
        this.updatedAt,
        this.activeDriver,
        this.vecType});

  RowsItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vecPlate = json['Vec_plate'];
    vecName = json['Vec_name'];
    vecNum = json['Vec_num'];
    phoneNumber = json['PhoneNumber'];
    iMEI = json['IMEI'];
    available = json['available'];
    url = json['url'];
    fuelTanks = json['fuelTanks'];
    battery = json['battery'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    activeDriver = json['Active_Driver'];
    vecType = json['Vec_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Vec_plate'] = this.vecPlate;
    data['Vec_name'] = this.vecName;
    data['Vec_num'] = this.vecNum;
    data['PhoneNumber'] = this.phoneNumber;
    data['IMEI'] = this.iMEI;
    data['available'] = this.available;
    data['url'] = this.url;
    data['fuelTanks'] = this.fuelTanks;
    data['battery'] = this.battery;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['Active_Driver'] = this.activeDriver;
    data['Vec_type'] = this.vecType;
    return data;
  }
}

