// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateNewVehicleModel {
  final String vehiclePlate;
  final String vehicleName;
  final String vehicleNumber;
  final String phoneNumber;
  final String imei;
  final String vehicleType;
  final String url;
  final List<int> carServiceType;
  CreateNewVehicleModel({
    required this.vehiclePlate,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.phoneNumber,
    required this.imei,
    required this.vehicleType,
    required this.url,
    required this.carServiceType,
  });

  Map<String, dynamic> toMap() {
    return {
      'Vec_plate': vehiclePlate,
      'Vec_name': vehicleName,
      'Vec_num': vehicleNumber,
      'PhoneNumber': phoneNumber,
      'IMEI': imei,
      'Vec_type': vehicleType,
      'url': url,
      'carServiceType': carServiceType,
    };
  }
}
