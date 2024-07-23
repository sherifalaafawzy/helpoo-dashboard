import 'package:intl/intl.dart';

class CorporatesModel {
  String? status;
  int? count;
  List<Rows>? rows;

  CorporatesModel({this.status, this.count, this.rows});

  CorporatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    count = json['count'] ?? 0;
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// ===================================

class GetAllCorpBranchesResponseModel {
  String? status;
  List<Branch>? branches;

  GetAllCorpBranchesResponseModel({this.status, this.branches});

  GetAllCorpBranchesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['branches'] != null) {
      branches = <Branch>[];
      json['branches'].forEach((v) {
        branches!.add(Branch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetBranchByIdModel {
  String? status;
  Branch? branch;

  GetBranchByIdModel({this.status, this.branch});

  GetBranchByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    branch =
    json['branch'] != null ? Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}

class Branch {
  var id;
  String? name;
  String? phoneNumber;
  String? address;
  var corporateCompanyId;
  String? createdAt;
  String? updatedAt;

  Branch(
      {this.id,
        this.name,
        this.phoneNumber,
        this.address,
        this.corporateCompanyId,
        this.createdAt,
        this.updatedAt,
      });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    corporateCompanyId = json['CorporateCompanyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['CorporateCompanyId'] = corporateCompanyId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

// ===================================

class Rows {
  int? id;
  String? enName;
  String? arName;
  int? discountRatio;
  bool? deferredPayment;
  String? startDate;
  String? endDate;
  bool? cash;
  bool? cardToDriver;
  bool? online;
  String? photo;
  num? numofrequeststhismonth;
  String? createdAt;
  String? updatedAt;

  Rows(
      {this.id,
      this.enName,
      this.arName,
      this.discountRatio,
      this.deferredPayment,
      this.startDate,
      this.endDate,
      this.cash,
      this.cardToDriver,
      this.online,
      this.photo,
      this.numofrequeststhismonth,
      this.createdAt,
      this.updatedAt});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    discountRatio = json['discount_ratio'] ?? 0;
    deferredPayment = json['deferredPayment'] ?? false;
    startDate = json['startDate'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['startDate'])
                .toLocal())
        : '';
    endDate = json['endDate'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['endDate'])
                .toLocal())
        : '';
    cash = json['cash'] ?? false;
    cardToDriver = json['cardToDriver'] ?? false;
    online = json['online'] ?? false;
    photo = json['photo'] ?? '';
    numofrequeststhismonth = json['numofrequeststhismonth'] ?? 0;
    createdAt = json['createdAt'] != null
        ? DateFormat('dd MMM yyyy hh:mm a').format(
            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                .parseUTC(json['createdAt'])
                .toLocal())
        : '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['discount_ratio'] = discountRatio;
    data['deferredPayment'] = deferredPayment;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['cash'] = cash;
    data['cardToDriver'] = cardToDriver;
    data['online'] = online;
    data['photo'] = photo;
    data['numofrequeststhismonth'] = numofrequeststhismonth;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
