class AllStatsResponseModel {
  Stats? stats;

  AllStatsResponseModel({this.stats});

  AllStatsResponseModel.fromJson(Map<String, dynamic> json) {
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    return data;
  }
}

class Stats {
  int? thisMonthServiceRequests;
  int? thisMonthRevenue;
  int? lastMonthServiceRequests;
  int? lastMonthRevenue;
  int? thisMonthTarget;
  int? achievedTargetPercent;
  int? requestsForToday;
  int? registrationToday;
  int? registrationThisMonth;
  int? fNOLCreated;
  int? canceledRequestsThisMonth;
  int? canceledRequestsLastMonth;
  int? thisMonthAppRequests;
  int? thisMonthCallCenterRequests;
  int? thisMonthCorporateRequests;
  int? lastMonthAppRequests;
  int? lastMonthCallCenterRequests;
  int? lastMonthCorporateRequests;
  int? totalSubscribers;
  int? thisMonthSubscribers;
  TotalPackageIncome? totalPackageIncome;
  TotalPackageIncome? packageIncomeThisMonth;
  MostCorporate? mostCorporate;
  String? mostCorporateCount;
  MostCorporate? secondCorporate;
  String? secondCorporateCount;
  MostCorporate? thirdCorporate;
  String? thirdCorporateCount;

  Stats(
      {this.thisMonthServiceRequests,
        this.thisMonthRevenue,
        this.lastMonthServiceRequests,
        this.lastMonthRevenue,
        this.thisMonthTarget,
        this.achievedTargetPercent,
        this.requestsForToday,
        this.registrationToday,
        this.registrationThisMonth,
        this.fNOLCreated,
        this.canceledRequestsThisMonth,
        this.canceledRequestsLastMonth,
        this.thisMonthAppRequests,
        this.thisMonthCallCenterRequests,
        this.thisMonthCorporateRequests,
        this.lastMonthAppRequests,
        this.lastMonthCallCenterRequests,
        this.lastMonthCorporateRequests,
        this.totalSubscribers,
        this.thisMonthSubscribers,
        this.totalPackageIncome,
        this.packageIncomeThisMonth,
        this.mostCorporate,
        this.mostCorporateCount,
        this.secondCorporate,
        this.secondCorporateCount,
        this.thirdCorporate,
        this.thirdCorporateCount});

  Stats.fromJson(Map<String, dynamic> json) {
    thisMonthServiceRequests = json['thisMonthServiceRequests'];
    thisMonthRevenue = json['thisMonthRevenue'];
    lastMonthServiceRequests = json['lastMonthServiceRequests'];
    lastMonthRevenue = json['lastMonthRevenue'];
    thisMonthTarget = json['thisMonthTarget'];
    achievedTargetPercent = json['achievedTargetPercent'];
    requestsForToday = json['requestsForToday'];
    registrationToday = json['registrationToday'];
    registrationThisMonth = json['registrationThisMonth'];
    fNOLCreated = json['FNOLCreated'];
    canceledRequestsThisMonth = json['canceledRequestsThisMonth'];
    canceledRequestsLastMonth = json['canceledRequestsLastMonth'];
    thisMonthAppRequests = json['thisMonthAppRequests'];
    thisMonthCallCenterRequests = json['thisMonthCallCenterRequests'];
    thisMonthCorporateRequests = json['thisMonthCorporateRequests'];
    lastMonthAppRequests = json['lastMonthAppRequests'];
    lastMonthCallCenterRequests = json['lastMonthCallCenterRequests'];
    lastMonthCorporateRequests = json['lastMonthCorporateRequests'];
    totalSubscribers = json['totalSubscribers'];
    thisMonthSubscribers = json['thisMonthSubscribers'];
    totalPackageIncome = json['totalPackageIncome'] != null
        ? new TotalPackageIncome.fromJson(json['totalPackageIncome'])
        : null;
    packageIncomeThisMonth = json['packageIncomeThisMonth'] != null
        ? new TotalPackageIncome.fromJson(json['packageIncomeThisMonth'])
        : null;
    mostCorporate = json['mostCorporate'] != null
        ? new MostCorporate.fromJson(json['mostCorporate'])
        : null;
    mostCorporateCount = json['mostCorporateCount'];
    secondCorporate = json['secondCorporate'] != null
        ? new MostCorporate.fromJson(json['secondCorporate'])
        : null;
    secondCorporateCount = json['secondCorporateCount'];
    thirdCorporate = json['thirdCorporate'] != null
        ? new MostCorporate.fromJson(json['thirdCorporate'])
        : null;
    thirdCorporateCount = json['thirdCorporateCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thisMonthServiceRequests'] = this.thisMonthServiceRequests;
    data['thisMonthRevenue'] = this.thisMonthRevenue;
    data['lastMonthServiceRequests'] = this.lastMonthServiceRequests;
    data['lastMonthRevenue'] = this.lastMonthRevenue;
    data['thisMonthTarget'] = this.thisMonthTarget;
    data['achievedTargetPercent'] = this.achievedTargetPercent;
    data['requestsForToday'] = this.requestsForToday;
    data['registrationToday'] = this.registrationToday;
    data['registrationThisMonth'] = this.registrationThisMonth;
    data['FNOLCreated'] = this.fNOLCreated;
    data['canceledRequestsThisMonth'] = this.canceledRequestsThisMonth;
    data['canceledRequestsLastMonth'] = this.canceledRequestsLastMonth;
    data['thisMonthAppRequests'] = this.thisMonthAppRequests;
    data['thisMonthCallCenterRequests'] = this.thisMonthCallCenterRequests;
    data['thisMonthCorporateRequests'] = this.thisMonthCorporateRequests;
    data['lastMonthAppRequests'] = this.lastMonthAppRequests;
    data['lastMonthCallCenterRequests'] = this.lastMonthCallCenterRequests;
    data['lastMonthCorporateRequests'] = this.lastMonthCorporateRequests;
    data['totalSubscribers'] = this.totalSubscribers;
    data['thisMonthSubscribers'] = this.thisMonthSubscribers;
    if (this.totalPackageIncome != null) {
      data['totalPackageIncome'] = this.totalPackageIncome!.toJson();
    }
    if (this.packageIncomeThisMonth != null) {
      data['packageIncomeThisMonth'] = this.packageIncomeThisMonth!.toJson();
    }
    if (this.mostCorporate != null) {
      data['mostCorporate'] = this.mostCorporate!.toJson();
    }
    data['mostCorporateCount'] = this.mostCorporateCount;
    if (this.secondCorporate != null) {
      data['secondCorporate'] = this.secondCorporate!.toJson();
    }
    data['secondCorporateCount'] = this.secondCorporateCount;
    if (this.thirdCorporate != null) {
      data['thirdCorporate'] = this.thirdCorporate!.toJson();
    }
    data['thirdCorporateCount'] = this.thirdCorporateCount;
    return data;
  }
}

class TotalPackageIncome {
  int? totalFees;

  TotalPackageIncome({this.totalFees});

  TotalPackageIncome.fromJson(Map<String, dynamic> json) {
    totalFees = json['totalFees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalFees'] = this.totalFees;
    return data;
  }
}

class MostCorporate {
  String? enName;
  String? arName;
  int? id;

  MostCorporate({this.enName, this.arName, this.id});

  MostCorporate.fromJson(Map<String, dynamic> json) {
    enName = json['en_name'];
    arName = json['ar_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en_name'] = this.enName;
    data['ar_name'] = this.arName;
    data['id'] = this.id;
    return data;
  }
}
