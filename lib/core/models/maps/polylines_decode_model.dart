class PolyLinesDecodeModel {
  final String status;
  final List<List<double>> points;

  PolyLinesDecodeModel({
    required this.status,
    required this.points,
  });

  factory PolyLinesDecodeModel.fromJson(Map<String, dynamic> json) {
    return PolyLinesDecodeModel(
      status: json['status'],
      points: _convertToDouble(json['encodedString']),
    );
  }

  static List<List<double>> _convertToDouble(List points) {
    List<List<double>> result = [];
    for (var point in points) {
      result.add([point[0].toDouble(), point[1].toDouble()]);
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'points': points,
    };
  }
}
