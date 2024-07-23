import 'drivers/drivers_map_model.dart';

class AssignDriverResponse {
  String? status;
  double? newFees;
  double? differenceFees;
  Location? destinationLocation;
  int? requestId;

  AssignDriverResponse({
    this.status,
    this.newFees,
    this.differenceFees,
    this.destinationLocation,
    this.requestId,
  });

  AssignDriverResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    newFees = json['newFees'] ?? 0;
    differenceFees = json['differenceFees'] ?? 0;
    destinationLocation = json['location'] != null ? Location.fromJson(json['location']) : null;
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'new_fees': newFees,
      'difference_fees': differenceFees,
      'location': destinationLocation?.toJson(),
      'requestId': requestId,
    };
  }
}
