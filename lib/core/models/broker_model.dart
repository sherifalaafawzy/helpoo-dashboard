import 'user_model.dart';

class Broker {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  UserModel? user;

  Broker({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.user,
  });

  Broker.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    userId = json['UserId'] ?? 0;
    user = json['User'] != null ? UserModel.fromJson(json['User']) : null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['createdAt'] = createdAt ?? '';
    data['updatedAt'] = updatedAt ?? '';
    data['UserId'] = userId ?? 0;
    data['User'] = user?.toJson();
    return data;
  }
}

class GetAllBrokersResponse {
  String? status;
  List<Broker>? brokers;

  GetAllBrokersResponse({
    this.status,
    this.brokers,
  });

  GetAllBrokersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    brokers = json['brokers'] != null ? (json['brokers'] as List).map((i) => Broker.fromJson(i)).toList() : null;
  }
}
