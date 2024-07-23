import 'service_request_details_model.dart';

class ServiceRequestDataModel {
  final String status;
  final ServiceRequestDetails serviceRequestDetails;

  ServiceRequestDataModel({
    required this.status,
    required this.serviceRequestDetails,
  });

  factory ServiceRequestDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDataModel(
      status: json['status'] ?? '',
      serviceRequestDetails: ServiceRequestDetails.fromJson(json['request']),
      // .runtimeType == List
      //     ? ServiceRequestDetails.fromJson(json['request'][0])
      //     : ServiceRequestDetails.fromJson(json['request']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'request': serviceRequestDetails.toJson(),
    };
  }
}
