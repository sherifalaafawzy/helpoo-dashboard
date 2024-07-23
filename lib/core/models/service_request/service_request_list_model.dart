import 'service_request_details_model.dart';

class ServiceRequestDataListModel {
  final String status;
  final ServiceRequestDetails serviceRequestDetails;
  final LocationPrevRequestModel? locationPrevRequestModel;
  final LocationPrevRequestModel? firstClientLocation;
  final String? oldRequestStatus;

  ServiceRequestDataListModel({
    required this.status,
    required this.serviceRequestDetails,
    this.locationPrevRequestModel,
    this.firstClientLocation,
    this.oldRequestStatus,
  });

  factory ServiceRequestDataListModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDataListModel(
      status: json['status'] ?? '',
      serviceRequestDetails: ServiceRequestDetails.fromJson(json['request'][0]),
      locationPrevRequestModel: json['location'] != null
          ? LocationPrevRequestModel.fromJson(json['location'])
          : null,
      firstClientLocation: json['firstClientLocation'] != null
          ? LocationPrevRequestModel.fromJson(json['firstClientLocation'])
          : null,
      oldRequestStatus: json['oldRequestStatus'] ?? '',
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

class LocationPrevRequestModel {
  final num latitude;
  final num longitude;

  LocationPrevRequestModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationPrevRequestModel.fromJson(Map<String, dynamic> json) {
    return LocationPrevRequestModel(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}