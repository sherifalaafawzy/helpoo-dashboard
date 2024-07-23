import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetDistanceAndDurationResponse {
  String? status;
  DistanceAndDuration? distanceAndDuration;

  GetDistanceAndDurationResponse({this.status, this.distanceAndDuration});

  GetDistanceAndDurationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    distanceAndDuration = json['distanceAndDuration'] != null
        ? DistanceAndDuration.fromJson(json['distanceAndDuration'])
        : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['status'] = status;
  //   if (distanceAndDuration != null) {
  //     data['distanceAndDuration'] = distanceAndDuration!.toJson();
  //   }
  //   return data;
  // }
}

class DistanceAndDuration {
  DriverDistanceMatrix? driverDistanceMatrix;
  List? points;

  DistanceAndDuration({this.driverDistanceMatrix, this.points});

  DistanceAndDuration.fromJson(Map<String, dynamic> json) {
    driverDistanceMatrix = json['driverDistanceMatrix'] != null
        ? DriverDistanceMatrix.fromJson(json['driverDistanceMatrix'])
        : null;

    if (json['points'] != null) {
      points = [];
      // json['points'].forEach((v) {
      //   points!.add(new List.fromJson(v));
      // });
      points = _convertToLatLng(json['points']);
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, List<LatLng>>();
  //   if (this.driverDistanceMatrix != null) {
  //     data['driverDistanceMatrix'] = this.driverDistanceMatrix!.toJson();
  //   }
  //   if (this.points != null) {
  //     // data['points'] = this.points!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

  static List<LatLng> _convertToLatLng(List points) {
    List<LatLng> latLngList = [];

    for (var coordinates in points) {
      double lat = coordinates[0];
      double lng = coordinates[1];
      latLngList.add(LatLng(lat, lng));
    }
    return latLngList;
  }
}

class DriverDistanceMatrix {
  Distance? distance;
  Distance? duration;

  DriverDistanceMatrix({this.distance, this.duration});

  DriverDistanceMatrix.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    duration = json['duration'] != null ? Distance.fromJson(json['duration']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}