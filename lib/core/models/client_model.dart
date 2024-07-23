import 'user_model.dart';

class ClientModel {
  final int id;
  final bool active;
  final String fcmToken;
  final int userId;
  final UserModel? user;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
    required this.fcmToken,
    required this.user,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] ?? 0,
      userId: json['UserId'] ?? 0,
      active: json['active'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      fcmToken: json['fcmtoken'] ?? '',
      user: json['User'] != null ? UserModel.fromJson(json['User']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'UserId': userId,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'fcmtoken': fcmToken,
      if(user != null)
      'User': user?.toJson(),
    };
  }
}
