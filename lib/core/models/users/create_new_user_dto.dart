// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateNewUserDTO {
  final String identifier;
  final String name;
  final String email;
  final String roleId;
  final String phoneNumber;
  final String password;
  final int? corporateCompanyId;
  final int? insuranceCompany;

  CreateNewUserDTO({
    required this.identifier,
    required this.name,
    required this.email,
    required this.roleId,
    required this.phoneNumber,
    required this.password,
    this.corporateCompanyId,
    this.insuranceCompany,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['name'] = name;
    data['email'] = email;
    data['roleId'] = roleId;
    data['PhoneNumber'] = phoneNumber;
    data['password'] = password;
    data['corporateCompanyId'] = corporateCompanyId;
    data['insuranceCompany'] = insuranceCompany;
    return data;
  }
}
