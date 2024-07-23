class CreateUserResponseModel {
  String? status;
  User? user;
  String? msg;

  CreateUserResponseModel({this.status, this.user, this.msg});

  CreateUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class User {
  String? phoneNumber;
  String? name;
  String? email;
  int? roleId;
  int? clientId;
  int? userId;

  User(
      {this.phoneNumber,
        this.name,
        this.email,
        this.roleId,
        this.clientId,
        this.userId});

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['PhoneNumber'];
    name = json['name'];
    email = json['email'];
    roleId = json['RoleId'];
    clientId = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PhoneNumber'] = this.phoneNumber;
    data['name'] = this.name;
    data['email'] = this.email;
    data['RoleId'] = this.roleId;
    data['id'] = this.clientId;
    data['userId'] = this.userId;
    return data;
  }
}
