class InsuranceCompaniesModel {
  String? status;
  List<InsuranceCompany>? insuranceCompanies;

  InsuranceCompaniesModel({this.status, this.insuranceCompanies});

  InsuranceCompaniesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['insuranceCompanies'] != null) {
      insuranceCompanies = <InsuranceCompany>[];
      json['insuranceCompanies'].forEach((v) {
        insuranceCompanies!.add(InsuranceCompany.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (insuranceCompanies != null) {
      data['insuranceCompanies'] = insuranceCompanies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InsuranceCompany {
  int? id;
  String? enName;
  String? arName;
  int? packageRequestCount;
  int? packageDiscountPercentage;
  int? maxTotalDiscount;
  int? discountPercentAfterPolicyExpires;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  List<String>? emails;

  InsuranceCompany({
    this.id,
    this.enName,
    this.arName,
    this.packageRequestCount,
    this.packageDiscountPercentage,
    this.maxTotalDiscount,
    this.discountPercentAfterPolicyExpires,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.emails,
  });

  InsuranceCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    packageRequestCount = json['package_request_count'];
    packageDiscountPercentage = json['package_discount_percentage'];
    maxTotalDiscount = json['max_total_discount'];
    discountPercentAfterPolicyExpires = json['discount_percent_after_policy_expires'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    emails = json['emails'] != null ? json['emails'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['package_request_count'] = packageRequestCount;
    data['package_discount_percentage'] = packageDiscountPercentage;
    data['max_total_discount'] = maxTotalDiscount;
    data['discount_percent_after_policy_expires'] = discountPercentAfterPolicyExpires;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['emails'] = emails;
    return data;
  }
}
