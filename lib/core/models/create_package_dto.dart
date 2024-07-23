class CreatePackageDto {
  final String enName;
  final String arName;
  final String enDescription;
  final String arDescription;
  final int fees;
  final int price;
  final int originalFees;
  final int maxDiscountPerTime;
  final int discountPercentage;
  final int numberOfDays;
  final int numberOfCars;
  final bool active;
  final bool private;
  final int? corporateCompanyId;
  final int? insuranceCompanyId;
  final int? brokerId;
  final int discountAfterMaxTimes;
  final List<CreatePackageBenefits> benefits;

  CreatePackageDto({
    required this.enName,
    required this.arName,
    required this.enDescription,
    required this.arDescription,
    required this.fees,
    required this.price,
    required this.originalFees,
    required this.maxDiscountPerTime,
    required this.discountPercentage,
    required this.numberOfDays,
    required this.numberOfCars,
    required this.active,
    required this.private,
    this.corporateCompanyId,
    this.insuranceCompanyId,
    this.brokerId,
    required this.discountAfterMaxTimes,
    required this.benefits,
  });

  Map<String, dynamic> toJson() {
    return {
      'enName': enName,
      'arName': arName,
      'enDescription': enDescription,
      'arDescription': arDescription,
      'fees': fees,
      'price': price,
      'originalFees': originalFees,
      'maxDiscountPerTime': maxDiscountPerTime,
      'discountPercentage': discountPercentage,
      'numberOfDays': numberOfDays,
      'numberOfCars': numberOfCars,
      'active': active,
      'private': private,
      'corporateCompanyId': corporateCompanyId,
      'insuranceCompanyId': insuranceCompanyId,
      'BrokerId': brokerId,
      'discountAfterMaxTimes': discountAfterMaxTimes,
      'benefits': benefits.map((e) => e.toJson()).toList(),
    };
  }
}

class CreatePackageBenefits {
  final String enName;
  final String arName;

  CreatePackageBenefits({
    required this.enName,
    required this.arName,
  });

  Map<String, dynamic> toJson() {
    return {
      'enName': enName,
      'arName': arName,
    };
  }
}
