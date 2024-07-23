class InspectionCompany {
  int? id;
  // String? fcmtoken;
  String? name;
  List<String>? phoneNumbers;
  List<String>? emails;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  InspectionCompany({
    this.id,
    this.name,
    this.phoneNumbers,
    this.emails,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  InspectionCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    // fcmtoken = json['fcmtoken'] ?? '';
    name = json['name'] ?? '';
    phoneNumbers = json['phoneNumbers'] != null
        ? json['phoneNumbers'].cast<String>()
        : [];
    emails = json['emails'] != null ? json['emails'].cast<String>() : [];
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    deletedAt = json['deletedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'fcmtoken': fcmtoken,
      'name': name,
      'phoneNumbers': phoneNumbers,
      'emails': emails,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}