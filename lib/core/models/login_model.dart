import 'user_model.dart';

class LoginModel {
  final String status;
  final UserModel user;
  final String token;

  LoginModel({
    required this.status,
    required this.user,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'user': user.toJson(),
      'token': token,
    };
  }
}
