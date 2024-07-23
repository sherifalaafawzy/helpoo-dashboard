import 'inspection_company_model.dart';

class GetMyInspectionCompaniesAsInsuranceCompanyModel {
  String? status;
  List<InspectionCompany>? inspectionCompanies;

  GetMyInspectionCompaniesAsInsuranceCompanyModel({
    this.status,
    this.inspectionCompanies,
  });

  GetMyInspectionCompaniesAsInsuranceCompanyModel.fromJson(
      Map<String, dynamic> json) {
    status = json['status'] ?? '';
    inspectionCompanies = json['inspectionCompanies'] != null
        ? (json['inspectionCompanies'] as List)
            .map((i) => InspectionCompany.fromJson(i))
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'inspectionCompanies':
          inspectionCompanies!.map((i) => i.toJson()).toList(),
    };
  }
}
