class CreateNewInspectorModel {
  String identifier;
  List<String> phoneNumbers;
  String email;
  List<String> emails;
  String name;
  int insuranceId;

  CreateNewInspectorModel({
    required this.identifier,
    required this.phoneNumbers,
    required this.email,
    required this.emails,
    required this.name,
    required this.insuranceId,
  });

  factory CreateNewInspectorModel.fromJson(Map<String, dynamic> json) {
    return CreateNewInspectorModel(
      identifier: json['identifier'] ?? '',
      phoneNumbers: json['phoneNumbers'] != null
          ? List<String>.from(json['phoneNumbers'])
          : [],
      email: json['email'] ?? '',
      emails: json['emails'] != null ? List<String>.from(json['emails']) : [],
      name: json['name'] ?? '',
      insuranceId: json['insuranceId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'phoneNumbers': phoneNumbers,
      'email': email,
      'emails': emails,
      'name': name,
      'insuranceId': insuranceId,
    };
  }
}
