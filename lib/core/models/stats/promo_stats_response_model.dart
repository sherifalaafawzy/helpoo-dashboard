class PromoStatsResponseModel {
  String? status;
  Stats? stats;

  PromoStatsResponseModel({this.status, this.stats});

  PromoStatsResponseModel.fromJson(Map<String, dynamic> json) {
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
  Map<String, dynamic>? promoUsageByCorporate;
  List<PromoCodesUsageThisMonth>? promoCodesUsageThisMonth;

  Stats({this.promoUsageByCorporate, this.promoCodesUsageThisMonth});

  Stats.fromJson(Map<String, dynamic> json) {
    promoUsageByCorporate = json['promoUsageByCorporate'] != null
        ? json['promoUsageByCorporate']
        : null;
    if (json['promoCodesUsageThisMonth'] != null) {
      promoCodesUsageThisMonth = <PromoCodesUsageThisMonth>[];
      json['promoCodesUsageThisMonth'].forEach((v) {
        promoCodesUsageThisMonth!.add(new PromoCodesUsageThisMonth.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promoUsageByCorporate != null) {
      data['promoUsageByCorporate'] = this.promoUsageByCorporate;
    }
    if (this.promoCodesUsageThisMonth != null) {
      data['promoCodesUsageThisMonth'] =
          this.promoCodesUsageThisMonth!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromoCodesUsageThisMonth {
  String? name;
  String? usageCount;

  PromoCodesUsageThisMonth({this.name, this.usageCount});

  PromoCodesUsageThisMonth.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    usageCount = json['usageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['usageCount'] = this.usageCount;
    return data;
  }
}
