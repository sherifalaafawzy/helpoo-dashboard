class CorporateCompanyModel {
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

  CorporateCompanyModel(
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

  CorporateCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    enName = json['en_name'] ?? '';
    arName = json['ar_name'] ?? '';
    discountRatio = json['discount_ratio'] ?? 0;
    deferredPayment = json['deferredPayment'] ?? false;
    cash = json['cash'] ?? false;
    cardToDriver = json['cardToDriver'] ?? false;
    online = json['online'] ?? false;
    photo = json['photo'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
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
