// ignore_for_file: public_member_api_docs, sort_constructors_first
class TableItemModel {
  final String? documentRef;
  final String? itemNumber;
  final String? itemName;
  final String? itemDescription;
  String? itemStatus;
  final String? itemPhoto;
  final String? itemPrice;
  final int? itemQuantity;
  final String? itemBarCode;
  final String? itemStorageUnit;
  final DateTime? itemDate;
  final DateTime? itemDateStart;
  final DateTime? itemDateEnd;
  String? englishName;
  final String? itemArabicName;
  final String? itemEnglishName;
  final String? inventoryUnit;
  final String? percentage;
  final String? usage;
  final String? store;
  final String? type;
  final String? phone;
  final String? profilePhoto;
  final bool? isGift;
  final bool? isRejected;
  final String? unitPrice;
  final String? discount;
  final String? tax;
  final String? totalPrice;
  final String? discountCode;

  TableItemModel({
    this.documentRef,
    this.itemNumber,
    this.itemName,
    this.itemDescription,
    this.itemStatus,
    this.itemPhoto,
    this.itemPrice,
    this.itemQuantity,
    this.inventoryUnit,
    this.itemBarCode,
    this.itemStorageUnit,
    this.itemDate,
    this.itemDateStart,
    this.itemDateEnd,
    this.itemArabicName,
    this.itemEnglishName,
    this.englishName,
    this.percentage,
    this.usage,
    this.store,
    this.type,
    this.phone,
    this.profilePhoto,
    this.isGift,
    this.isRejected,
    this.unitPrice,
    this.discount,
    this.tax,
    this.totalPrice,
    this.discountCode,
  });
}
