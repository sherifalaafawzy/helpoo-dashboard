import 'package:intl/intl.dart';

class PackagesPromoCodesModel {
  String? status;
  List<Promoes>? promoes;

  PackagesPromoCodesModel({this.status, this.promoes});

  PackagesPromoCodesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['promoes'] != null) {
      promoes = <Promoes>[];
      json['promoes'].forEach((v) {
        promoes!.add(Promoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (promoes != null) {
      data['promoes'] = promoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promoes {
  int? id;
  String? name;
  String? value;
  String? startDate;
  String? expiryDate;
  String? usageExpiryDate;
  int? percentage;
  int? count;
  int? maxCount;
  int? maxUse;
  int? feesDiscount;
  bool? private;
  bool? active;
  String? sMS;
  String? createdAt;
  String? updatedAt;
  int? corporateCompanyId;
  CorporateCompany? corporateCompany;

  Promoes(
      {this.id,
      this.name,
      this.value,
      this.startDate,
      this.expiryDate,
      this.usageExpiryDate,
      this.percentage,
      this.count,
      this.maxCount,
      this.maxUse,
      this.feesDiscount,
      this.private,
      this.active,
      this.sMS,
      this.createdAt,
      this.updatedAt,
      this.corporateCompanyId,
      this.corporateCompany});

  Promoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    startDate = json['startDate'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['startDate'])
                .toLocal())
        : '';
    expiryDate = json['expiryDate'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['expiryDate'])
                .toLocal())
        : '';
    usageExpiryDate = json['usageExpiryDate'];
    percentage = json['percentage'];
    count = json['count'];
    maxCount = json['maxCount'];
    maxUse = json['maxUse'];
    feesDiscount = json['feesDiscount'];
    private = json['private'];
    active = json['active'];
    sMS = json['SMS'];
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'];
    corporateCompanyId = json['CorporateCompanyId'];
    corporateCompany = json['CorporateCompany'] != null
        ? CorporateCompany.fromJson(json['CorporateCompany'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['startDate'] = startDate;
    data['expiryDate'] = expiryDate;
    data['usageExpiryDate'] = usageExpiryDate;
    data['percentage'] = percentage;
    data['count'] = count;
    data['maxCount'] = maxCount;
    data['maxUse'] = maxUse;
    data['feesDiscount'] = feesDiscount;
    data['private'] = private;
    data['active'] = active;
    data['SMS'] = sMS;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['CorporateCompanyId'] = corporateCompanyId;
    if (corporateCompany != null) {
      data['CorporateCompany'] = corporateCompany!.toJson();
    }
    return data;
  }
}

class CorporateCompany {
  int? id;
  String? enName;
  String? arName;
  int? discountRatio;
  bool? deferredPayment;

  bool? cash;
  bool? cardToDriver;
  bool? online;
  String? photo;

  String? createdAt;
  String? updatedAt;

  CorporateCompany(
      {this.id,
      this.enName,
      this.arName,
      this.discountRatio,
      this.deferredPayment,
      this.cash,
      this.cardToDriver,
      this.online,
      this.photo,
      this.createdAt,
      this.updatedAt});

  CorporateCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    discountRatio = json['discount_ratio'];
    deferredPayment = json['deferredPayment'];

    cash = json['cash'];
    cardToDriver = json['cardToDriver'];
    online = json['online'];
    photo = json['photo'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['discount_ratio'] = discountRatio;
    data['deferredPayment'] = deferredPayment;

    data['cash'] = cash;
    data['cardToDriver'] = cardToDriver;
    data['online'] = online;
    data['photo'] = photo;

    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
