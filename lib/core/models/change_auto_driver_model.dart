class ChangeAutoDriverModel {
  final String status;
  final String driverID;
  final String fcmToken;

  ChangeAutoDriverModel({
    required this.status,
    required this.driverID,
    required this.fcmToken,
  });

  factory ChangeAutoDriverModel.fromJson(Map<String, dynamic> json) {
    return ChangeAutoDriverModel(
      status: json['status'] ?? '',
      driverID: json['driver']['id'].toString() ?? '',
      fcmToken: json['driver']['fcmtoken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'driver': {
        'id': driverID,
        'fcmtoken': fcmToken,
      },
    };
  }
}
