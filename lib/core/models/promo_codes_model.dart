import 'package:intl/intl.dart';

class PromoCodesModel {
  String? status;
  PromoCodes? promoCodes;

  PromoCodesModel({this.status, this.promoCodes});

  PromoCodesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    promoCodes = json['promoCodes'] != null
        ? PromoCodes.fromJson(json['promoCodes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (promoCodes != null) {
      data['promoCodes'] = promoCodes!.toJson();
    }
    return data;
  }
}

class PromoCodes {
  List<PromoCode>? promoCodes;
  int? totaldata;
  int? totalPages;

  PromoCodes({this.promoCodes, this.totaldata, this.totalPages});

  PromoCodes.fromJson(Map<String, dynamic> json) {
    if (json['promoCodes'] != null) {
      promoCodes = <PromoCode>[];
      json['promoCodes'].forEach((v) {
        promoCodes!.add(PromoCode.fromJson(v));
      });
    }
    totaldata = json['totaldata'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (promoCodes != null) {
      data['promoCodes'] = promoCodes!.map((v) => v.toJson()).toList();
    }
    data['totaldata'] = totaldata;
    data['totalPages'] = totalPages;
    return data;
  }
}

class PromoCode {
  int? id;
  String? name;
  String? value;
  String? startDate;
  String? expiryDate;
  String? usageExpiryDate;
  int? percentage;
  int? count;
  int? maxCount;
  int? feesDiscount;
  int? maxFeesDiscount;
  int? maxUse;
  bool? private;
  bool? voucher;
  bool? active;
  String? createdAt;
  String? updatedAt;

  PromoCode(
      {this.id,
      this.name,
      this.value,
      this.startDate,
      this.expiryDate,
      this.usageExpiryDate,
      this.percentage,
      this.count,
      this.maxCount,
      this.feesDiscount,
      this.maxFeesDiscount,
      this.maxUse,
      this.private,
      this.voucher,
      this.active,
      this.createdAt,
      this.updatedAt});

  PromoCode.fromJson(Map<String, dynamic> json) {
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
    feesDiscount = json['feesDiscount'];
    maxFeesDiscount = json['maxFeesDiscount'];
    maxUse = json['maxUse'];
    private = json['private'];
    voucher = json['voucher'];
    active = json['active'];
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'];
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
    data['feesDiscount'] = feesDiscount;
    data['maxFeesDiscount'] = maxFeesDiscount;
    data['maxUse'] = maxUse;
    data['private'] = private;
    data['voucher'] = voucher;
    data['active'] = active;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
