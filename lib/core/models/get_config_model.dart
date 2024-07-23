class GetConfigModel {
  String? status;
  List<Config>? config;

  GetConfigModel({this.status, this.config});

  GetConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['config'] != null) {
      config = <Config>[];
      json['config'].forEach((v) {
        config!.add(Config.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;

    if (config != null) {
      data['config'] = config!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Config {
  int? id;
  String? minimumIOSVersion;
  String? minimumAndroidVersion;
  bool? underMaintaining;

  String? minimumIOSVersionInspector;
  String? minimumAndroidVersionInspector;
  bool? underMaintainingInspector;

  String? distanceLimit;
  String? durationLimit;
  String? createdAt;
  String? updatedAt;
  String? termsAndConditionsEn;
  String? termsAndConditionsAr;

  num? finishTime;
  num? waitingTimeFree;
  num? waitingTimeLimit;
  num? waitingTimePrice;
  num? carryingTime;

  Config({
    this.id,
    this.minimumIOSVersion,
    this.minimumAndroidVersion,
    this.underMaintaining,

    this.minimumIOSVersionInspector,
    this.minimumAndroidVersionInspector,
    this.underMaintainingInspector,

    this.distanceLimit,
    this.durationLimit,
    this.createdAt,
    this.updatedAt,
    this.termsAndConditionsEn,
    this.termsAndConditionsAr,

    this.finishTime,
    this.waitingTimeFree,
    this.waitingTimeLimit,
    this.waitingTimePrice,
    this.carryingTime,
  });

  Config.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minimumIOSVersion = json['minimumIOSVersion'];
    minimumAndroidVersion = json['minimumAndroidVersion'];
    underMaintaining = json['underMaintaining'];

    minimumIOSVersionInspector = json['minimumIOSVersionInspector'];
    minimumAndroidVersionInspector = json['minimumAndroidVersionInspector'];
    underMaintainingInspector = json['underMaintainingInspector'];

    distanceLimit = json['distanceLimit'];
    durationLimit = json['durationLimit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    termsAndConditionsEn = json['termsAndConditionsEn'];
    termsAndConditionsAr = json['termsAndConditionsAr'];

    finishTime = json['finishTime'];
    waitingTimeFree = json['waitingTimeFree'];
    waitingTimeLimit = json['waitingTimeLimit'];
    waitingTimePrice = json['waitingTimePrice'];
    carryingTime = json['carryingTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minimumIOSVersion': minimumIOSVersion,
      'minimumAndroidVersion': minimumAndroidVersion,
      'underMaintaining': underMaintaining,
      'distanceLimit': distanceLimit,
      'durationLimit': durationLimit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'termsAndConditionsEn': termsAndConditionsEn,
      'termsAndConditionsAr': termsAndConditionsAr,
    };
  }
}
