import 'drivers_map_model.dart';

class ServiceRequestDriver {
  String? status;
  Driver? driver;
  Distance? distance;

  // //* use From if it exist instead of above distance [
  // Distance? distanceFromDestination;
  // Distance? distanceForDestination;
  Location? destinationLocation;
  int? requestId;

  ServiceRequestDriver({
    this.status,
    this.driver,
    this.distance,
    this.destinationLocation,
    this.requestId,
  });

  ServiceRequestDriver.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    distance = json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    destinationLocation = json['location'] != null ? Location.fromJson(json['location']) : null;
    requestId = json['requestId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'driver': driver!.toJson(),
      'distance': distance!.toJson(),
      'location': destinationLocation!.toJson(),
      'requestId': requestId,
    };
  }
}

class Driver {
  int? id;
  bool? offline;
  String? averageRating;
  int? ratingCount;
  double? lat;
  double? lng;
  String? heading;
  bool? available;
  int? userId;
  String? photo;
  String? name;
  String? phoneNumber;
  String? fcmtoken;

  Driver(
      {this.id,
      this.offline,
      this.averageRating,
      this.ratingCount,
      this.lat,
      this.lng,
      this.heading,
      this.available,
      this.userId,
      this.photo,
      this.name,
      this.phoneNumber,
      this.fcmtoken});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offline = json['offline'];
    averageRating = json['averageRating'];
    ratingCount = json['ratingCount'];
    lat = json['lat'];
    lng = json['lng'];
    heading = json['heading'];
    available = json['available'];
    userId = json['UserId'];
    photo = json['photo'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    fcmtoken = json['fcmtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offline'] = offline;
    data['averageRating'] = averageRating;
    data['ratingCount'] = ratingCount;
    data['lat'] = lat;
    data['lng'] = lng;
    data['heading'] = heading;
    data['available'] = available;
    data['UserId'] = userId;
    data['photo'] = photo;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['fcmtoken'] = fcmtoken;
    return data;
  }
}

class Distance {
  SubDistance? distance;
  SubDistance? duration;
  String? status;

  Distance({this.distance, this.duration, this.status});

  Distance.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null ? SubDistance.fromJson(json['distance']) : null;
    duration = json['duration'] != null ? SubDistance.fromJson(json['duration']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class SubDistance {
  String? text;
  int? value;

  SubDistance({this.text, this.value});

  SubDistance.fromJson(Map<String, dynamic> json) {
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
