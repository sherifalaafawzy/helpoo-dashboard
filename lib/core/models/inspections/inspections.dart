
import '../car_model.dart';
import '../image_model.dart';
import 'inspectors_model.dart';
import 'part_model.dart';
import '../insurance_companies_model.dart';
import '../manufacturer_model.dart';

import '../../util/enums.dart';
import '../insurance_company/inspection_company_model.dart';
import 'accident_model.dart';

class InspectionsModel {
  String? status;
  List<Inspection>? inspections;

  InspectionsModel({this.status, this.inspections});

  InspectionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['inspections'] != null) {
      inspections = <Inspection>[];
      json['inspections'].forEach((v) {
        inspections!.add(Inspection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (inspections != null) {
      data['inspections'] = inspections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inspection {
  int? id;
  String? clientName;
  String? clientPhone;
  String? engPhone;
  String? government;
  String? city;
  String? area;
  String? addressInfo;
  int? carBrand;
  int? carModelId;
  String? vinNumber;
  String? engineNumber;
  String? plateNumber;
  String? accidentDescription;
  String? exceptions;
  int? inspectorId;
  String? type;
  String? date;
  List<String>? insuranceAttachments;
  List<ImageModel>? insuranceImages;
  List<ImageModel>? inspectorImages;
  List<ImageModel>? additionalPaperImages;
  List<SupplementImageModel>? supplementImages;
  List<String>? pdfReports;

  List<InspectionSoleraReportModel>? inspectionsReports;

  String? notes;
  List<ExtractedAudioRecordModel>? audioRecords;
  String? commitmentStatus;
  String? notCommittedReason;
  String? status;
  int? insuranceCompanyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? color;
  String? inspectDate;
  String? arrivedAt;
  String? assignDate;
  String? followDate;
  InsuranceCompany? insuranceCompany;
  Inspector? inspector;
  InspectionCompany? inspectionCompany;
  CarModel? carModel;
  ManufacturerModel? manufacturer;
  List<AccidentModel>? accidentList;
  List<PartViewModel>? partsList;
  String? workerFeesBefore;
  String? workerFeesAfter;
  String? damageDescription;
  InspectionType? inspectionType;
  InspectionsStatus? inspectionStatus;

  Inspection({
    this.id,
    this.clientName,
    this.clientPhone,
    this.engPhone,
    this.government,
    this.city,
    this.area,
    this.addressInfo,
    this.carBrand,
    this.carModelId,
    this.vinNumber,
    this.engineNumber,
    this.plateNumber,
    this.accidentDescription,
    this.exceptions,
    this.inspectorId,
    this.type,
    this.date,
    this.color,
    this.inspectDate,
    this.arrivedAt,
    this.assignDate,
    this.followDate,
    this.insuranceImages,
    this.insuranceAttachments,
    this.inspectorImages,
    this.additionalPaperImages,
    this.supplementImages,
    this.pdfReports,
    this.inspectionsReports,
    this.notes,
    this.audioRecords,
    this.commitmentStatus,
    this.notCommittedReason,
    this.status,
    this.insuranceCompanyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.insuranceCompany,
    this.inspector,
    this.inspectionCompany,
    this.carModel,
    this.manufacturer,
    this.accidentList,
    this.partsList,
    this.workerFeesBefore,
    this.workerFeesAfter,
    this.damageDescription,
    this.inspectionType,
    this.inspectionStatus,
  });

  Inspection.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    clientName = json['clientName'] ?? '';
    clientPhone = json['clientPhone'] ?? '';
    engPhone = json['engPhone'] ?? '';
    government = json['government'] ?? '';
    city = json['city'] ?? '';
    area = json['area'] ?? '';
    addressInfo = json['addressInfo'] ?? '';
    carBrand = json['carBrand'] ?? 0;
    carModelId = json['carModel'] ?? 0;
    vinNumber = json['vinNumber'] ?? '';
    engineNumber = json['engineNumber'] ?? '';
    plateNumber = json['plateNumber'] ?? '';
    accidentDescription = json['accidentDescription'] ?? '';
    exceptions = json['exceptions'] ?? '';
    inspectorId = json['inspectorId'] ?? 0;
    type = json['type'] ?? '';
    date = json['date'] ?? '';
    color  = json['color'] ?? '';
    inspectDate  = json['inspectDate'] ?? '';
    arrivedAt  = json['arrivedAt'] ?? '';
    assignDate = json['assignDate'] ?? '';
    followDate = json['followDate'] ?? '';
    if (json['insuranceImages'] != null) {
      insuranceImages = <ImageModel>[];
      json['insuranceImages'].forEach((v) {
        insuranceImages!.add(ImageModel.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      insuranceAttachments = <String>[];
      json['attachments'].forEach((v) {
        insuranceAttachments!.add(v);
      });
    }
    if (json['inspectorImages'] != null) {
      inspectorImages = <ImageModel>[];
      json['inspectorImages'].forEach((v) {
        inspectorImages!.add(ImageModel.fromJson(v));
      });
    }
    if (json['additionalPaperImages'] != null) {
      additionalPaperImages = <ImageModel>[];
      json['additionalPaperImages'].forEach((v) {
        additionalPaperImages!.add(ImageModel.fromJson(v));
      });
    }
    if (json['supplementImages'] != null) {
      supplementImages = <SupplementImageModel>[];
      json['supplementImages'].forEach((v) {
        supplementImages!.add(SupplementImageModel.fromJson(v));
      });
    }
    if (json['pdfReports'] != null) {
      pdfReports = <String>[];
      json['pdfReports'].forEach((v) {
        pdfReports!.add(v);
      });
    }

    inspectionsReports = json['InspectionsReports'] != null ? List<InspectionSoleraReportModel>.from(json['InspectionsReports'].map((e) => InspectionSoleraReportModel.fromJson(e))) : [];

    if (json['audioRecordsWithNotes'] != null) {
      audioRecords = <ExtractedAudioRecordModel>[];
      json['audioRecordsWithNotes'].forEach((v) {
        audioRecords!.add(ExtractedAudioRecordModel.fromJson(v));
      });
    }
    notes = json['notes'] ?? '';
    commitmentStatus = json['commitmentStatus'];
    notCommittedReason = json['notCommittedReason'];
    status = json['status'] ?? '';
    insuranceCompanyId = json['insuranceCompanyId'] ?? 0;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    deletedAt = json['deletedAt'] ?? '';
    insuranceCompany = json['insuranceCompany'] != null
        ? InsuranceCompany.fromJson(json['insuranceCompany'])
        : null;
    inspector = json['Inspector'] != null
        ? Inspector.fromJson(json['Inspector'])
        : null;
    inspectionCompany = json['InspectionCompany'] != null
        ? InspectionCompany.fromJson(json['InspectionCompany'])
        : InspectionCompany();
    carModel =
        json['CarModel'] != null ? CarModel.fromJson(json['CarModel']) : null;
    manufacturer = json['Manufacturer'] != null
        ? ManufacturerModel.fromJson(json['Manufacturer'])
        : null;

    workerFeesBefore = json['workerFeesBefore'] ?? '';
    workerFeesAfter = json['workerFeesAfter'] ?? '';
    damageDescription = json['damageDescription'] ?? '';
    accidentList = json['accidentList'] != null
        ? List<AccidentModel>.from(json['accidentList'].map((v) => AccidentModel.fromJson(v)))
        : [];
    partsList = json['partsList'] != null
        ? List<PartViewModel>.from(json['partsList'].map((v) => PartViewModel.fromJson(v)))
        : [];
    inspectionType = _parseInspectionType(json['type'] ?? '');
    inspectionStatus = _parseInspectionStatus(json['status'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientName'] = clientName;
    data['clientPhone'] = clientPhone;
    data['engPhone'] = engPhone;
    data['government'] = government;
    data['city'] = city;
    data['area'] = area;
    data['addressInfo'] = addressInfo;
    data['carBrand'] = carBrand;
    data['carModel'] = carModelId;
    data['vinNumber'] = vinNumber;
    data['engineNumber'] = engineNumber;
    data['plateNumber'] = plateNumber;
    data['accidentDescription'] = accidentDescription;
    data['exceptions'] = exceptions;
    data['inspectorId'] = inspectorId;
    data['type'] = type;
    data['date'] = date;
    data['color'] = color;
    data['inspectDate'] = inspectDate;
    data['arrivedAt'] = arrivedAt;
    data['assignDate'] = assignDate;
    data['followDate'] = followDate;
    data['notes'] = notes;
    data['commitmentStatus'] = commitmentStatus;
    data['notCommittedReason'] = notCommittedReason;
    data['status'] = status;
    data['insuranceCompanyId'] = insuranceCompanyId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    if (insuranceImages != null) {
      data['insuranceImages'] =
          insuranceImages!.map((v) => v.toJson()).toList();
    }
    if (insuranceAttachments != null) {
      data['attachments'] = insuranceAttachments!.map((v) => v).toList();
    }
    if (inspectorImages != null) {
      data['inspectorImages'] =
          inspectorImages!.map((v) => v.toJson()).toList();
    }
    if (additionalPaperImages != null) {
      data['additionalPaperImages'] =
          additionalPaperImages!.map((v) => v.toJson()).toList();
    }
    if (supplementImages != null) {
      data['supplementImages'] =
          supplementImages!.map((v) => v.toJson()).toList();
    }
    if (pdfReports != null) {
      data['pdfReports'] = pdfReports!.map((v) => v).toList();
    }

    if (inspectionsReports != null) {
      data['InspectionsReports'] = inspectionsReports!.map((v) => v.toJson()).toList();
    }

    if (audioRecords != null) {
      data['audioRecordsWithNotes'] = audioRecords!.map((v) => v.toJson()).toList();
    }
    if (insuranceCompany != null) {
      data['insuranceCompany'] = insuranceCompany!.toJson();
    }
    if (inspector != null) {
      data['Inspector'] = inspector!.toJson();
    }
    if (inspectionCompany != null) {
      data['InspectionCompany'] = inspectionCompany!.toJson();
    }
    if (carModel != null) {
      data['CarModel'] = carModel!.toJson();
    }
    if (manufacturer != null) {
      data['Manufacturer'] = manufacturer!.toJson();
    }

    data['workerFeesBefore'] = workerFeesBefore;
    data['workerFeesAfter'] = workerFeesAfter;
    data['damageDescription'] = damageDescription;
    if (accidentList != null) {
      data['accidentList'] =
          accidentList!.map((v) => v.toJson()).toList();
    }
    if (partsList != null) {
      data['partsList'] =
          partsList!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  InspectionType _parseInspectionType(String type) {
    InspectionType inspectionType = InspectionType.preInception;
    switch (type) {
      case 'preInception':
        inspectionType = InspectionType.preInception;
        break;
      case 'beforeRepair':
        inspectionType = InspectionType.beforeRepair;
        break;
      case 'supplement':
        inspectionType = InspectionType.supplement;
        break;
      case 'rightSave':
        inspectionType = InspectionType.rightSave;
        break;
      case 'afterRepair':
        inspectionType = InspectionType.afterRepair;
        break;
    }
    return inspectionType;
  }

  InspectionsStatus _parseInspectionStatus(String status) {
    InspectionsStatus inspectionStatus = InspectionsStatus.pending;
    switch (status) {
      case 'pending':
        inspectionStatus = InspectionsStatus.pending;
        break;
      case 'finished':
        inspectionStatus = InspectionsStatus.finished;
        break;
      case 'done':
        inspectionStatus = InspectionsStatus.done;
        break;
    }
    return inspectionStatus;
  }
}


class ExtractedAudioRecordModel {
  String? text;
  String? audioPath;

  ExtractedAudioRecordModel({
    this.text,
    this.audioPath,
  });

  ExtractedAudioRecordModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    audioPath = json['audioPath'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'audioPath': audioPath,
    };
  }
}

class CreateInspectionResponse {
  String? status;
  Inspection? inspection;

  CreateInspectionResponse({this.status, this.inspection});

  CreateInspectionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    inspection = json['inspection'] != null
        ? Inspection.fromJson(json['inspection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (inspection != null) {
      data['inspection'] = inspection!.toJson();
    }
    return data;
  }
}


class InspectionSoleraReportModel {
  var id;
  String? report;
  String? createdAt;
  var inspectionId;

  InspectionSoleraReportModel({
    this.id,
    this.report,
    this.createdAt,
    this.inspectionId,
  });

  InspectionSoleraReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    report = json['report'];
    createdAt = json['createdAt'];
    inspectionId = json['InspectionId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report': report,
      'createdAt': createdAt,
      'InspectionId': inspectionId,
    };
  }
}
