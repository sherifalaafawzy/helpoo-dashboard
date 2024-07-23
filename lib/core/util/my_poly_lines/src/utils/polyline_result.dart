import '../PointLatLng.dart';

class PolylineResult {

  /// the api status retuned from google api
  ///
  /// returns OK if the api call is successful
  String? status;

  /// list of decoded points
  List<PointLatLng> points;

  String pointsString = '';

  String distance = '';

  String duration = '';

  String duration_in_traffic = '';

  num durationMinutesValue = 0.0;

  num distanceMeterValue = 0.0;
  /// the error message returned from google, if none, the result will be empty
  String? errorMessage;

  PolylineResult({this.status, this.points = const [], this.errorMessage = ""});
}