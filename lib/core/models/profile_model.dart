import 'user_model.dart';

class ProfileModel {
  final String status;
  final UserModel user;

  ProfileModel({
    required this.status,
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'user': user.toJson(),
    };
  }
}
