class CorporateSearchModel {
  String? status;
  List<Corporates>? corporates;

  CorporateSearchModel({this.status, this.corporates});

  CorporateSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['corporates'] != null) {
      corporates = <Corporates>[];
      json['corporates'].forEach((v) {
        corporates!.add(Corporates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (corporates != null) {
      data['corporates'] = corporates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Corporates {
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
  // Null? numofrequeststhismonth;
  String? createdAt;
  String? updatedAt;

  Corporates(
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
      // this.numofrequeststhismonth,
      this.createdAt,
      this.updatedAt});

  Corporates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    discountRatio = json['discount_ratio'];
    deferredPayment = json['deferredPayment'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    cash = json['cash'];
    cardToDriver = json['cardToDriver'];
    online = json['online'];
    photo = json['photo'];
    // numofrequeststhismonth = json['numofrequeststhismonth'];
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
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['cash'] = cash;
    data['cardToDriver'] = cardToDriver;
    data['online'] = online;
    data['photo'] = photo;
    // data['numofrequeststhismonth'] = this.numofrequeststhismonth;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
