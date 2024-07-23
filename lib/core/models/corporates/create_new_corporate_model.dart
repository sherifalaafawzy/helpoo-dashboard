// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateNewCorporateModel {
  final String enName;
  final String arName;
  final int discountRatio;
  final String endDate;
  final bool deferredPayment;
  final bool cash;
  final bool credit;
  final bool online;

  CreateNewCorporateModel({
    required this.enName,
    required this.arName,
    required this.discountRatio,
    required this.endDate,
    required this.deferredPayment,
    required this.cash,
    required this.credit,
    required this.online,
  });

  Map<String, dynamic> toMap() {
    return {
      'en_name': enName,
      'ar_name': arName,
      'discount_ratio': discountRatio,
      'endDate': endDate,
      'deferredPayment': deferredPayment,
      'cash': cash,
      'credit': credit,
      'online': online,
    };
  }
}
