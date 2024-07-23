import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:helpoo_insurance_dashboard/core/models/stats/all_stats_response_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/stats/vehicles_stats_response_model.dart';
import '../error/exceptions.dart';
import '../models/accident_report_details_model.dart';
import '../models/accident_reports.dart';
import '../models/all_admin_cars.dart';
import '../models/assign_driver_response.dart';
import '../models/broker_model.dart';
import '../models/cars_model.dart';
import '../models/change_auto_driver_model.dart';
import '../models/corporate_search_model.dart';
import '../models/corporates/corporate_users_model.dart';
import '../models/corporates/corporates_model.dart';
import '../models/corporates/create_new_corporate_model.dart';
import '../models/create_package_dto.dart';
import '../models/create_package_model.dart';
import '../models/create_policy_model.dart';
import '../models/decoded_points.dart';
import '../models/drivers/drivers_map_model.dart';
import '../models/drivers/drivers_model.dart';
import '../models/drivers/drivers_statistics_model.dart';
import '../models/drivers/service_request_driver.dart';
import '../models/get_config_model.dart';
import '../models/get_package_customization_model.dart';
import '../models/image_model.dart';
import '../models/inspections/inspections.dart';
import '../models/inspections/inspectors_model.dart';
import '../models/insurance_companies_model.dart';
import '../models/insurance_company/get_my_inspections_companies.dart';
import '../models/login_model.dart';
import '../models/manufacturers_model.dart';
import '../models/maps/map_place_details__coordinates_model.dart';
import '../models/maps/map_place_details_model.dart';
import '../models/maps/map_place_model.dart';
import '../models/normal_promo_code_users.dart';
import '../models/package_bulk_user_model.dart';
import '../models/package_customization_model.dart';
import '../models/package_model.dart';
import '../models/package_users_model.dart';
import '../models/packages/add_user_to_package.dart';
import '../models/packages_promo_codes_model.dart';
import '../models/policies_model.dart';
import '../models/profile_model.dart';
import '../models/promo_code_users_model.dart';
import '../models/promo_codes_model.dart';
import '../models/roles/roles_model.dart';
import '../models/service_request/add_service_request_car_dto.dart';
import '../models/service_request/available_drivers_model.dart';
import '../models/service_request/calculate_fees.dart';
import '../models/service_request/create_service_dto.dart';
import '../models/service_request/customer_search_model.dart';
import '../models/service_request/get_all.dart';
import '../models/service_request/get_types.dart';
import '../models/service_request/service_request_customer_data_model.dart';
import '../models/service_request/service_request_list_model.dart';
import '../models/service_request/service_request_model.dart';
import '../models/service_request/existing_user_cars_model.dart';
import '../models/setting_types_model.dart';
import '../models/stats/promo_stats_response_model.dart';
import '../models/upload_pdf_response_model.dart';
import '../models/users/activate_car_dto.dart';
import '../models/users/create_new_user_dto.dart';
import '../models/users/create_user_response_model.dart';
import '../models/users/users_model.dart';
import '../models/vehicles/create_new_vehicle_model.dart';
import '../models/vehicles/vehicles_model.dart';
import '../models/vehicles/vehicles_statistics_model.dart';
import '../models/vehicles/vehicles_types_model.dart';
import 'local/cache_helper.dart';
import 'remote/api_endpoints.dart';
import 'remote/dio_helper.dart';
import '../util/constants.dart';
import '../util/enums.dart';
import '../util/utils.dart';

import '../models/service_request/getDistanceAndDurationResponse.dart';
import '../models/service_request/getRequestDuratonAndDistance.dart';

abstract class Repository {
  Future<Either<String, LoginModel>> login({
    required String identifier,
    required String password,
    required String fcmToken,
  });

  Future<Either<String, ProfileModel>> getProfile();

  Future<Either<String, PoliciesModel>> getPolicies();

  Future<Either<String, ManufacturersModel>> getManufacturers();

  Future<Either<String, CarsModel>> getCarsModels();

  Future<Either<String, void>> createNewPolicy({
    required CreatePolicyModel createPolicyData,
  });

  Future<Either<String, GetAccidentReportModel>> getAccidentReports({required int pageNumber});

  Future<Either<String, GetAccidentReportModel>> getAccidentReportsByStatus({required int pageNumber, required String status});

  Future<Either<String, GetAccidentDetailsModel>> getAccidentDetails({required int accidentId});

  Future<Either<String, InsuranceCompaniesModel>> getInsuranceCompanies();

  Future<Either<String, DecodedPoints>> getDecodedPoints({
    required String encodedPoints,
  });

  ///*************** Get My Inspectors [Companies && Individual] ******///
  Future<Either<String, InspectorsModel>> getMyInspectors({required bool isInspectionCompany});

  Future<Either<String, GetMyInspectionCompaniesAsInsuranceCompanyModel>> getMyInspectionCompaniesAsInsuranceCompany();

//******************************************************************************
  Future<Either<String, InspectionsModel>> getAllInspections({
    int? pageNumber,
    int? size,
    String? status,
    String? type,
    bool isInspectionCompany = false,
  });

  Future<Either<String, void>> createNewInspector({
    required Map<String, dynamic> createNewInspectorData,
    required bool isCompany,
  });

  Future<Either<String, CreateInspectionResponse>> createNewInspection({
    required FormData createNewInspectionData,
  });

  Future<Either<String, void>> updateInspection({
    required FormData updateInspectionData,
    required int inspectionId,
  });

  Future<Either<String, String>> uploadPdf({
    required String pdfBase64,
    required int id,
    required String mobileNumber,
    required ProgressCallback progressCallback,
  });

  Future<Either<String, void>> uploadImages({
    required List<UploadImageModel> insuranceImages,
    required int id,
    required ProgressCallback progressCallback,
  });

  Future<Either<String, InspectionsModel>> getInspectionsAsInspector({
    int? pageNumber,
    int? size,
    required String inspectorId,
    String? status,
    String? type,
  });

  Future<Either<String, GetAccidentDetailsModel>> updateFnol({
    required String voiceText,
    required String fnolId,
  });

  Future<Either<String, void>> uploadAnyAttachmentFiles(
      {required List<PlatformFile> platformFiles, required int inspectionId, required ProgressCallback progressCallback});

//******************************************************************************
  ///*************************** Service Request *********************************
  Future<Either<String, GetAllServicesRequests>> getAllServicesRequests({
    int? pageNumber,
    int? size,
    String? status,
    String? serviceType,
    String? clientType,
    String? sortBy,
    String? sortOrder,
  });

  Future<Either<String, GetServiceReqTypes>> getServiceReqTypes();

  Future<Either<String, ServiceRequestCustomerDataModel>> addServiceRequestCar({
    required AddServiceRequestCarDto car,
  });

  Future<Either<String, MapPlaceModel>> searchPlace({
    required String input,
  });

  Future<Either<String, MapPlaceDetailsModel>> getPlaceDetails({
    required String placeId,
  });

  Future<Either<String, MapPlaceDetailsCoordinatesModel>> getPlaceDetailsByCoordinates({
    required String latLng,
  });

  Future<Either<String, DriversModel>> getAllDriversMap();

  Future<Either<String, ServiceRequestDriver>> getServiceRequestDriver({
    required String carServiceId,
    required String location,
  });

  Future<Either<String, CalculateFeesModel>> calculateServiceFees({
    required int userId,
    required int carId,
    required String destinationDistance,
    // required String distance,
    // required String distanceEuro,
    // required String distanceNorm,
  });

  Future<Either<String, ServiceRequestDataListModel>> createNewServiceRequest({
    required CreateServiceDto createServiceDto,
  });

  Future<Either<String, ServiceRequestDataModel>> updateOneServiceRequest({
    required int serviceRequestId,
    required String status,
    String? paymentMethod,
    String? paymentStatus,
  });

  Future<Either<String, ServiceRequestDataListModel>> getOneServiceRequest({
    required int serviceRequestId,
  });

  Future<Either<String, GetOneServiceRequestModel>> getRequestById({
    required int serviceRequestId,
  });

  Future<Either<String, GetDistanceAndDurationResponse>> getRequestTimeAndDistance(
      {required GetRequestDurationAndDistanceDTO getRequestDurationAndDistanceDto});

  Future<Either<String, AssignDriverResponse>> assignDriver({
    required String driverId,
    required String serviceRequestId,
  });

  Future<Either<String, ChangeAutoDriverModel>> autoAssignDriver({
    required String driverId,
    required String serviceRequestId,
  });

  Future<Either<String, CustomerSearchModel>> searchForExistingCustomer({
    required String input,
  });

  Future<Either<String, void>> logGoogleMapsApi({
    required String endpoint,
    required int requestId,
    required String from,
  });

  Future<Either<String, ExistingUserCarsModel>> getExistingCustomerCars({
    required String input,
  });

  Future<Either<String, ExistingUserCarsModel>> searchCarsByVinNumber({required String vinNumber, required String insuranceCompanyId});

  Future<Either<String, String>> activateCar({
    required ActivateCarDTO activateCarDTO,
    required String carId,
  });


  Future<Either<String, void>> addCarToPackage({
    required String packageId,
    required clientPackageId,
    required String clientId,
    required String carId,
  });

  Future<Either<String, void>> cancelServiceRequest({
    required int serviceRequestId,
  });

  Future<Either<String, GetAllServicesRequests>> getServiceRequestsReports({
    required String startDate,
    required String endDate,
    String? filterType,
    dynamic filterValue,
  });

  Future<Either<String, void>> addWaitingTime({
    required int serviceRequestId,
    required int waitingTime,
    required int waitingFees,
  });

  Future<Either<String, void>> applyWaitingTime({
    required int serviceRequestId,
  });

  Future<Either<String, void>> removeWaitingTime({
    required int serviceRequestId,
  });

  Future<Either<String, void>> addDiscount({
    required int serviceRequestId,
    required int discount,
  });

  Future<Either<String, void>> applyDiscount({
    required int serviceRequestId,
    required String approvedBy,
    required String reason,
  });

  Future<Either<String, void>> removeDiscount({
    required int serviceRequestId,
  });

  Future<Either<String, void>> addCommentOnServiceRequest({
    required int serviceRequestId,
    required String comment,
  });

  Future<Either<String, CorporateSearchModel>> corporateSearch({
    required String input,
  });

  Future<Either<String, GetAllServicesRequests>> getCorporateServiceRequests({int? corporateId, int pageNumber});

  Future<Either<String, GetAllServicesRequests>> getAllOpenServiceRequests();

  Future<Either<String, DriversMapModel>> getAllDriversPlacesMap();

  Future<Either<String, SettingTypesModel>> getSettingsTypes();

  Future<Either<String, void>> editSettingsTypes({
    required int settingId,
    required int baseCost,
    required double costPerKm,
    required int carType,
  });

  Future<Either<String, GetAllServicesRequests>> serviceRequestSearch({
    String? serviceRequestId,
    String? clientName,
    String? clientPhoneNumber,
  });

  Future<Either<String, GetConfigModel>> getAllConfig();

  Future<Either<String, AllAdminCarsModel>> getAllAdminCars({
    required String page,
    required String size,
  });

  Future<Either<String, void>> updateConfig({
    required String minimumIOSVersion,
    required String minimumAndroidVersion,
    required bool underMaintaining,
    required String distanceLimit,
    required String durationLimit,
    String? termsAr,
    String? termsEn,

    required String minimumIOSVersionInspector,
    required String minimumAndroidVersionInspector,
    required bool underMaintainingInspector,
  });

  Future<Either<String, AvailableDriversModel>> getAvailableDrivers({
    required List<int> carServiceTypes,
  });

  Future<Either<String, void>> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
    String? id,
    String? type,
    bool? isInspectionNotification,
  });

  Future<Either<String, void>> cancelServiceRequestWithPayment({
    required String id,
    required String fees,
    required String reason,
  });

  Future<Either<String, VehiclesModel>> getAllVehicles();

  Future<Either<String, VehiclesTypesModel>> getAllVehiclesTypes();

  Future<Either<String, void>> createNewVehicle({
    required CreateNewVehicleModel data,
  });

  Future<Either<String, UsersModel>> getAllUsers();

  Future<Either<String, SearchedUserByPhoneResponseModel>> searchUserByPhone({String? clientPhoneNumber});

  Future<Either<String, CreateUserResponseModel>> createNewUser({
    required CreateNewUserDTO data,
  });

  Future<Either<String, RolesModel>> getAllRoles();

  Future<Either<String, CorporatesModel>> getAllCorporates();

  Future<Either<String, GetAllCorpBranchesResponseModel>> getAllCorpBranches({required String corpId});
  Future<Either<String, GetBranchByIdModel>> getCorpBranchById({required String branchId});

  Future<Either<String, void>> createNewCorporate({
    required CreateNewCorporateModel data,
  });

  ///************************* Packages *********************************

  Future<Either<String, GetAllPackagesResponse>> getAllPackages({
    String? corporateId,
    String? insuranceId,
    String? brokerId,
    bool isForCorporate = false,
    bool isForInsurance = false,
    bool isForBroker = false,
  });

  Future<Either<String, PackageUsersModel>> getPackageUsers({
    required int packageId,
  });

  Future<Either<String, CreatePackageModel>> createPackage({
    required CreatePackageDto data,
  });

  Future<Either<String, void>> createPackageCustomization({
    required PackageCustomizationModel data,
  });

  Future<Either<String, GetPackageCustomizationModel>> getPackageCustomization({
    required int packageId,
  });

  Future<Either<String, AddUserToPackageResponse>> addUsersToPackage({
    required int packageId,
    required List<PackageBulkUserModel> users,
  });

  Future<Either<String, CorporateUsersModel>> getCorporateUsers({
    required int corporateId,
  });

  Future<Either<String, PromoCodeUsersModel>> getPromoCodeUsers({
    int? packageId,
    int? promoId,
  });

  Future<Either<String, NormalPromoCodeUsers>> getNormalPromoCodeUsers({
    required int promoId,
  });

  Future<Either<String, PromoCodesModel>> getAllPromoCodes();

  Future<Either<String, PackagesPromoCodesModel>> getAllPackagesPromoCodes();

  Future<Either<String, DriversStatisticsModel>> getDriversStatistics();

  Future<Either<String, VehiclesStatisticsModel>> getVehiclesStatistics();

  Future<Either<String, GetAllBrokersResponse>> getAllBrokers();

  Future<Either<String, GetInsuranceModel>> getInsurance({
    required int id,
  });

  Future<Either<String, String>> sendPdfThrowEmail({
    required List<String> emails,
    required String subject,
    required String body,
    required String pdfPath,
    required String FNOLID,
    List<String?>? bcc,
  });

  Future<Either<String, UploadPdfResponseModel>> uploadFnolPdf({
    int? pdfReportId,
    required int accidentReportId,
    required int carId,
    String? type,
    required String pdfReportOne,
    required String pdfReportTwo,
  });

  Future<Either<String, String>> refuseRequestReject({
    required String serviceRequestId,
  });

  Future<Either<String, String>> approveReqCancel({
    required String serviceRequestId,
  });

  ///* stats

  Future<Either<String, AllStatsResponseModel>> getAllStats();

  Future<Either<String, VehiclesStatsResponseModel>> getVehiclesStats();

  Future<Either<String, PromoStatsResponseModel>> getPromoStats();

}

///*****************************************************************************
class RepoImplementation extends Repository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  RepoImplementation({
    required this.dioHelper,
    required this.cacheHelper,
  });

  @override
  Future<Either<String, String>> refuseRequestReject({
    required String serviceRequestId,
  }) {
    return _basicErrorHandling<String>(
      onSuccess: () async {
        final Response response = await dioHelper.post(
          url: refuseRequestEndPoint,
          token: token,
          data: {
            "requestId": serviceRequestId,
          },
        );
        printMeLog('refuseRequestReject :: ${response.data}');
        return '';
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, String>> approveReqCancel({
    required String serviceRequestId,
  }) {
    return _basicErrorHandling<String>(
      onSuccess: () async {
        final Response response = await dioHelper.post(
          url: approveReqCancelEndPoint,
          token: token,
          data: {
            "requestId": serviceRequestId,
          },
        );
        printMeLog('refuseRequestReject :: ${response.data}');
        return '';
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, UploadPdfResponseModel>> uploadFnolPdf({
    int? pdfReportId,
    required int accidentReportId,
    required int carId,
    String? type,
    required String pdfReportOne,
    required String pdfReportTwo,
  }) {
    return _basicErrorHandling<UploadPdfResponseModel>(
      onSuccess: () async {
        final Response response = await dioHelper.post(
          url: uploadTwoFnolPdfsEndPoint,
          token: token,
          withDebugPrint: false,
          data: {
            "pdfReportId": 15,
            "AccidentReportId": accidentReportId,
            "carId": carId,
            "Type": 'FNOLForAi',
            "pdfReportOne": pdfReportOne,
            "pdfReportTwo": pdfReportTwo,
          },
        );
        return UploadPdfResponseModel.fromJson(response.data);
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, String>> sendPdfThrowEmail({
    required List<String> emails,
    required String subject,
    required String body,
    required String pdfPath,
    required String FNOLID,
    List<String?>? bcc,
  }) {
    return _basicErrorHandling<String>(
      onSuccess: () async {
        final Response response = await dioHelper.post(
          url: sendPdfThrowEmailEndPoint,
          token: token,
          data: {
            "to": emails,
            "subject": subject,
            "text": body,
            "filePath": pdfPath,
            'arId': FNOLID,
            if (bcc != null && bcc.isNotEmpty && !bcc.contains(null)) 'bcc': bcc,
          },
        );
        return response.data.toString();
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, GetInsuranceModel>> getInsurance({
    required int id,
  }) {
    return _basicErrorHandling<GetInsuranceModel>(
      onSuccess: () async {
        final Response response = await dioHelper.get(
          url: '$getInsuranceEndPoint/$id',
          token: token,
        );
        debugPrintFullText('getInsurance :: ${response.data}');
        return GetInsuranceModel.fromJson(response.data);
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, GetAllBrokersResponse>> getAllBrokers() {
    return _basicErrorHandling<GetAllBrokersResponse>(
      onSuccess: () async {
        final Response response = await dioHelper.get(
          url: getAllBrokersEndPoint,
          token: token,
        );
        return GetAllBrokersResponse.fromJson(response.data);
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, String>> uploadPdf({
    required String pdfBase64,
    required int id,
    required String mobileNumber,
    required ProgressCallback progressCallback,
  }) {
    return _basicErrorHandling<String>(
      onSuccess: () async {
        final Response response = await dioHelper.post(
            url: '$uploadPdfEndPoint$id',
            data: {
              'pdfBase64': pdfBase64,
              'mobileNumber': mobileNumber,
            },
            token: token,
            progressCallback: progressCallback);
        return response.data['inspection']['pdfReports'].last;
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, void>> uploadImages({
    required List<UploadImageModel> insuranceImages,
    required int id,
    required ProgressCallback progressCallback,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response response = await dioHelper.post(
          url: '$uploadImagesEndPoint/$id',
          data: {
            'insuranceImages': insuranceImages.map((e) => e.toJson()).toList(),
          },
          token: token,
          progressCallback: progressCallback,
        );
        return;
      },
      onServerError: (e) async {
        return e.message;
      },
    );
  }

  @override
  Future<Either<String, LoginModel>> login({
    required String identifier,
    required String password,
    required String fcmToken,
  }) async {
    return _basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: loginEndPoint,
          data: {
            'identifier': identifier,
            'password': password,
            'fcmtoken': fcmToken,
          },
        );

        return LoginModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, ProfileModel>> getProfile() async {
    return _basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: profileEndPoint,
        );

        return ProfileModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, PoliciesModel>> getPolicies() async {
    return _basicErrorHandling<PoliciesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$policiesEndPoint$currentCompanyId',
        );

        return PoliciesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, ManufacturersModel>> getManufacturers() async {
    return _basicErrorHandling<ManufacturersModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: manufacturersEndPoint,
        );

        return ManufacturersModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, CarsModel>> getCarsModels() async {
    return _basicErrorHandling<CarsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: carsModelsEndPoint,
        );

        return CarsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, void>> createNewPolicy({
    required CreatePolicyModel createPolicyData,
  }) async {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createPolicyEndPoint,
          data: createPolicyData.toJson(),
        );
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      // onOtherError: (exception) async {
      //   debugPrint(exception.token);
      //   debugPrint(exception.title.toString());
      //   debugPrint(exception.error);
      //   return exception.token;
      // },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, GetAccidentReportModel>> getAccidentReports({required int pageNumber}) async {
    return _basicErrorHandling<GetAccidentReportModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: userRoleName == Rules.Super.name || userRoleName == Rules.SuperVisor.name
              ? getAllAdminAccidentReports
              : userRoleName == Rules.Broker.name
                  ? '$getAllBrokerAccidentReports/$generalID'
                  : '$accidentReportsPoint/$currentCompanyId',
          query: {
            'page': pageNumber,
          },
        );
        debugPrintFullText('=====>>>>> ${f.data}');
        return GetAccidentReportModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAccidentReportModel>> getAccidentReportsByStatus({required int pageNumber, required String status}) async {
    return _basicErrorHandling<GetAccidentReportModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: userRoleName == Rules.Super.name || userRoleName == Rules.SuperVisor.name
              ? getAllAdminAccidentReportsByStatus
              : '$accidentReportsByStatus/$currentCompanyId',
          query: {
            'page': pageNumber,
            'status': status,
          },
        );
        debugPrintFullText('====>>>> [By Status ] ${f.data} *******');
        return GetAccidentReportModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, GetAccidentDetailsModel>> getAccidentDetails({required int accidentId}) async {
    return _basicErrorHandling<GetAccidentDetailsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$accidentReportsDetailsPoint/$accidentId',
        );
        debugPrintFullText('******* ::: >>> ${f.data}');
        return GetAccidentDetailsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
      // onOtherError: (exception) async {
      //   debugPrint('********** onOtherError **********');
      //   // debugPrint('exception.token :: ${exception.token ?? 'null'}');
      //   // debugPrint('exception.title :: ${exception.title ?? 'null'}');
      //   // debugPrint('exception.error :: ${exception.error ?? 'null'}');
      //   return 'onOtherError';
      // },
    );
  }

  //******************************************************************************

  @override
  Future<Either<String, MapPlaceDetailsModel>> getPlaceDetails({
    required String placeId,
  }) async {
    return _basicErrorHandling<MapPlaceDetailsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: getApiDataUrl,
          data: {
            'url': 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId',
            'isMap': true,
          },
        );

        return MapPlaceDetailsModel.fromJson(f.data['response']);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

  @override
  Future<Either<String, MapPlaceDetailsCoordinatesModel>> getPlaceDetailsByCoordinates({
    required String latLng,
  }) async {
    return _basicErrorHandling<MapPlaceDetailsCoordinatesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: getApiDataUrl,
          data: {
            'url': 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latLng',
            'isMap': true,
          },
        );

        return MapPlaceDetailsCoordinatesModel.fromJson(f.data['response']);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      onOtherError: (exception) async {
        debugPrint(exception.token);
        debugPrint(exception.title.toString());
        debugPrint(exception.error);
        return exception.token;
      },
    );
  }

  //******************************************************************************

  @override
  Future<Either<String, MapPlaceModel>> searchPlace({
    required String input,
  }) async {
    return _basicErrorHandling<MapPlaceModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: getApiDataUrl,
          data: {
            'url':
                'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:eg&language=${isEnglish ? 'en' : 'ar'}',
          },
        );

        return MapPlaceModel.fromJson(f.data['response']);
      },
      onServerError: (exception) async {
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        // debugPrint(exception.error);
        return exception.message;
      },
      // onOtherError: (exception) async {
      //   debugPrint(exception.token);
      //   debugPrint(exception.title.toString());
      //   debugPrint(exception.error);
      //   return exception.token;
      // },
    );
  }

  //******************************************************************************
  @override
  Future<Either<String, DecodedPoints>> getDecodedPoints({
    required String encodedPoints,
  }) {
    return _basicErrorHandling<DecodedPoints>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: decodedPointsUrl,
          data: {
            'decoded': encodedPoints,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return DecodedPoints.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, InsuranceCompaniesModel>> getInsuranceCompanies() {
    return _basicErrorHandling<InsuranceCompaniesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: insuranceCompaniesEndPoint,
        );
        debugPrintFullText('${f.data} *******');
        return InsuranceCompaniesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, void>> uploadAnyAttachmentFiles(
      {required List<PlatformFile> platformFiles, required int inspectionId, required ProgressCallback progressCallback}) async {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        debugPrint('============ ${platformFiles.first.name} ===============');
        debugPrint('============ ${platformFiles.first.size} ===============');
        debugPrint('============ ${platformFiles.first.extension} ===============');
        debugPrint('============ ${platformFiles.first.runtimeType} ===============');

        List<MultipartFile> multiPartFiles = [];
        for (int i = 0; i < platformFiles.length; i++) {
          final fileBytes = platformFiles[i].bytes!;
          multiPartFiles.add(
            MultipartFile.fromBytes(
              fileBytes,
              filename: platformFiles[i].name,
            ),
          );
        }

        debugPrint('============ ${multiPartFiles.first.filename} ===============x');
        debugPrint('============ ${multiPartFiles.first.contentType} ===============x');

        FormData formData = FormData.fromMap({"media": multiPartFiles});

        final Response response = await dioHelper.patch(
          token: token,
          url: '$updateInspectionEndPoint/$inspectionId',
          data: formData,
          progressCallback: progressCallback,
        );

        debugPrint('============ success ===============');
        debugPrint('============ ${response.data} ===============');
        debugPrint('============ ${response.data['inspection']} ===============');
        debugPrint('============ ${response.data['inspection']['attachments']} ===============');

        return response.data['inspection']['attachments'];
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, void>> createNewInspector({
    required Map<String, dynamic> createNewInspectorData,
    required bool isCompany,
  }) {
    debugPrintFullText('dddddddddddx1 $userRoleName *******');
    debugPrintFullText('dddddddddddx2 ${Rules.InspectionManager.name} *******');
    debugPrintFullText('dddddddddddx3 $isCompany *******');
    debugPrintFullText('dddddddddddx4 $createNewInspectorData *******');

    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: userRoleName == Rules.InspectionManager.name
              ? createInspectorForInspectionCompanyEndPoint
              : isCompany
                  ? createNewInspectionCompanyEndPoint
                  : createNewInspectorForInsuranceCompanyEndPoint,
          data: createNewInspectorData,
        );
        // debugPrintFullText('${f.data} *******');
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, InspectorsModel>> getMyInspectors({required bool isInspectionCompany}) {
    return _basicErrorHandling<InspectorsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: isInspectionCompany ? '$getMyInspectorsAsAnInspectionCompanyEndPoint/$currentCompanyId' : '$inspectorsEndPoint/$currentCompanyId',
          // url: isInspectionCompany
          //     ? '$getMyInspectorsAsAnInspectionCompanyEndPoint/10' // TODO: $currentCompanyId
          //     : '$inspectorsEndPoint/19', // TODO: $currentCompanyId
        );
        // debugPrintFullText('${f.data} *******');
        return InspectorsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, GetMyInspectionCompaniesAsInsuranceCompanyModel>> getMyInspectionCompaniesAsInsuranceCompany() async {
    // int currID = await sl<CacheHelper>().get(Keys.currentCompanyId);
    return _basicErrorHandling<GetMyInspectionCompaniesAsInsuranceCompanyModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getMyInspectionsCompanyAsInsuranceCompanyEndPoint/$currentCompanyId',
        );
        // debugPrintFullText('${f.data} *******');
        return GetMyInspectionCompaniesAsInsuranceCompanyModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  @override
  Future<Either<String, InspectionsModel>> getAllInspections({
    int? pageNumber,
    int? size,
    String? status,
    String? type,
    bool isInspectionCompany = false,
  }) {
    return _basicErrorHandling<InspectionsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: isInspectionCompany ? '$getMyInspectionsAsAnInspectionCompanyEndPoint/$currentCompanyId' : '$inspectionsEndPoint/$currentCompanyId',
          // url: isInspectionCompany
          //     ? '$getMyInspectionsAsAnInspectionCompanyEndPoint/10' //TODO: $currentCompanyId
          //     : '$inspectionsEndPoint/19', //TODO: $currentCompanyId
          query: {
            if (pageNumber != null) 'page': pageNumber,
            if (size != null) 'size': size,
            if (status != null) 'status': status,
            if (type != null) 'type': type,
          },
        );
        debugPrintFullText('${f.data} *******');
        return InspectionsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************

  @override
  Future<Either<String, CreateInspectionResponse>> createNewInspection({
    required FormData createNewInspectionData,
  }) {
    return _basicErrorHandling<CreateInspectionResponse>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createInspectionEndPoint,
          isMultipart: true,
          data: createNewInspectionData,
        );
        // debugPrintFullText('${f.data} *******');
        return CreateInspectionResponse.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> updateInspection({
    required FormData updateInspectionData,
    required int inspectionId,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.patch(
          token: token,
          url: '$updateInspectionEndPoint/$inspectionId',
          // isMultipart: true,
          data: updateInspectionData,
        );
        // debugPrintFullText('${f.data} *******');
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, InspectionsModel>> getInspectionsAsInspector({
    required String inspectorId,
    String? status,
    String? type,
    int? pageNumber,
    int? size,
  }) {
    return _basicErrorHandling<InspectionsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getMyInspectionsAsAnInspectorEndPoint/$inspectorId',
          query: {
            if (pageNumber != null) 'page': pageNumber,
            if (size != null) 'size': size,
            if (status != null) 'status': status,
            if (type != null) 'type': type,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return InspectionsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

//******************************************************************************
  ///************************ Service Request *****************************
  @override
  Future<Either<String, GetAllServicesRequests>> getAllServicesRequests({
    int? pageNumber,
    int? size,
    String? status,
    String? serviceType,
    String? clientType,
    String? sortBy,
    String? sortOrder,
  }) {
    return _basicErrorHandling<GetAllServicesRequests>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllServiceRequest,
          query: {
            if (pageNumber != null) 'page': pageNumber,
            if (size != null) 'size': size,
            if (status != null) 'status': status,
            if (serviceType != null) 'serviceType': serviceType,
            if (clientType != null) 'clientType': clientType,
            if (sortBy != null) 'sortBy': sortBy,
            if (sortOrder != null) 'sortOrder': sortOrder,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return GetAllServicesRequests.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetServiceReqTypes>> getServiceReqTypes() {
    return _basicErrorHandling<GetServiceReqTypes>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getServiceRequestTypes,
        );
        debugPrintFullText('${f.data} *******');
        return GetServiceReqTypes.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, DriversModel>> getAllDriversMap() {
    return _basicErrorHandling<DriversModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getDriversUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return DriversModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ServiceRequestCustomerDataModel>> addServiceRequestCar({required AddServiceRequestCarDto car}) {
    return _basicErrorHandling<ServiceRequestCustomerDataModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: addServiceRequestCarEndPoint,
          data: car.toJson(),
        );
        debugPrintFullText('${f.data} *******');
        return ServiceRequestCustomerDataModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ServiceRequestDriver>> getServiceRequestDriver({required String carServiceId, required String location}) {
    return _basicErrorHandling<ServiceRequestDriver>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: getServiceRequestDriverEndPoint,
          data: {
            "carServiceTypeId": carServiceId,
            "location": location,
          },
        );
        debugPrintFullText('${f.data} *******');
        return ServiceRequestDriver.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CalculateFeesModel>> calculateServiceFees({
    required int userId,
    required int carId,
    required String destinationDistance,
    // required String distance,
    // required String distanceEuro,
    // required String distanceNorm,
  }) {
    return _basicErrorHandling<CalculateFeesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: calculateFeesUrl,
          data: {
            'userId': userId,
            'carId': carId,
            'destinationDistance': destinationDistance,
            // 'distance': distance,
            // 'distanceEuro': distanceEuro,
            // 'distanceNorm': distanceNorm,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return CalculateFeesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ServiceRequestDataListModel>> createNewServiceRequest({
    required CreateServiceDto createServiceDto,
  }) {
    return _basicErrorHandling<ServiceRequestDataListModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createNewServiceRequestUrl,
          data: createServiceDto.toJson(),
        );
        debugPrintFullText('${f.data} *******');
        return ServiceRequestDataListModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ServiceRequestDataModel>> updateOneServiceRequest({
    required int serviceRequestId,
    required String status,
    String? paymentMethod,
    String? paymentStatus,
  }) {
    return _basicErrorHandling<ServiceRequestDataModel>(
      onSuccess: () async {
        final Response f = await dioHelper.patch(
          token: token,
          url: '$updateOneServiceRequestUrl/$serviceRequestId',
          data: {
            'status': status,
            if (paymentMethod != null) 'paymentMethod': paymentMethod,
            if (paymentStatus != null) 'paymentStatus': paymentStatus,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return ServiceRequestDataModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ServiceRequestDataListModel>> getOneServiceRequest({
    required int serviceRequestId,
  }) {
    return _basicErrorHandling<ServiceRequestDataListModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getOneServiceRequestUrl/$serviceRequestId',
        );
        debugPrintFullText('${f.data} *******');
        return ServiceRequestDataListModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetOneServiceRequestModel>> getRequestById({
    required int serviceRequestId,
  }) {
    return _basicErrorHandling<GetOneServiceRequestModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getOneServiceRequestUrl/$serviceRequestId',
        );
        debugPrintFullText(f.data.toString());
        return GetOneServiceRequestModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetDistanceAndDurationResponse>> getRequestTimeAndDistance(
      {required GetRequestDurationAndDistanceDTO getRequestDurationAndDistanceDto}) {
    return _basicErrorHandling<GetDistanceAndDurationResponse>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: getRequestTimeAndDistanceByIdEndPoint,
          data: getRequestDurationAndDistanceDto.toJson(),
        );
        printMeLog(f.data.toString());
        return GetDistanceAndDurationResponse.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, AssignDriverResponse>> assignDriver({required String driverId, required String serviceRequestId}) {
    return _basicErrorHandling<AssignDriverResponse>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: assignDriverUrl,
          data: {
            'driverId': driverId,
            'requestId': serviceRequestId,
          },
        );
        debugPrintFullText('AssignDriverResponse : ${f.data}');
        return AssignDriverResponse.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ChangeAutoDriverModel>> autoAssignDriver({
    required String driverId,
    required String serviceRequestId,
  }) {
    return _basicErrorHandling<ChangeAutoDriverModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: autoAssignDriverUrl,
          data: {
            'driverId': driverId,
            'requestId': serviceRequestId,
          },
        );
        debugPrintFullText('AssignDriverResponse : ${f.data}');

        return ChangeAutoDriverModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CustomerSearchModel>> searchForExistingCustomer({required String input}) {
    return _basicErrorHandling<CustomerSearchModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$searchForExistingCustomerUrl/$input',
        );
        // debugPrintFullText('${f.data} *******');
        return CustomerSearchModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> logGoogleMapsApi({
    required String endpoint,
    required int requestId,
    required String from,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: logGoogleMapsApiUrl,
          data: {
            'api': endpoint,
            'requestId': requestId,
            'from': from,
          },
        );

        debugPrintFullText('${f.data} *******');
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ExistingUserCarsModel>> getExistingCustomerCars({required String input}) {
    return _basicErrorHandling<ExistingUserCarsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getExistingCustomerCarsUrl/$input',
        );
        // debugPrintFullText('${f.data} *******');
        return ExistingUserCarsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, ExistingUserCarsModel>> searchCarsByVinNumber({required String vinNumber, required String insuranceCompanyId}) {
    return _basicErrorHandling<ExistingUserCarsModel>(
      onSuccess: () async {
        var data = {
          "insuranceCompanyId": insuranceCompanyId,
          "vinNo": vinNumber,
        };

        final Response f = await dioHelper.post(
          token: token,
          url: getCarsByVinNumberEndPoint,
          data: data,
        );
        return ExistingUserCarsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, String>> activateCar({
    required ActivateCarDTO activateCarDTO,
    required String carId,
  }) {
    return _basicErrorHandling<String>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          url: "$confirmAndActivateCarEndPoint/$carId",
          token: token,
          data: activateCarDTO.toJson(clientIdKey: "clientId"),
        );
        return f.data.toString();
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> addCarToPackage({
    required String packageId,
    required String clientId,
    required clientPackageId,
    required String carId,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        var data = {
          "packageId": packageId,
          "clientId": clientId,
          "clientPackageId": clientPackageId,
          "carId": carId,
        };

        final Response f = await dioHelper.post(
          url: subscribeCarToPackageEndPoint,
          token: token,
          data: data,
        );
        return;
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> cancelServiceRequest({required int serviceRequestId}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: '$cancelRequestUrl/$serviceRequestId',
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAllServicesRequests>> getServiceRequestsReports({
    required String startDate,
    required String endDate,
    String? filterType,
    dynamic filterValue,
  }) {
    return _basicErrorHandling<GetAllServicesRequests>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: getServiceRequestReportsUrl,
          data: {
            'startDate': startDate,
            'endDate': endDate,
            if (filterType != null && filterValue != null) filterType: filterValue,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return GetAllServicesRequests.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> addWaitingTime({required int serviceRequestId, required int waitingTime, required int waitingFees}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: addWaitingTimeUrl,
          data: {
            'id': serviceRequestId,
            'waitingTime': waitingTime,
            'waitingFees': waitingFees,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> applyWaitingTime({required int serviceRequestId}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: applyWaitingTimeUrl,
          data: {
            'id': serviceRequestId,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> removeWaitingTime({required int serviceRequestId}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: removeWaitingTimeUrl,
          data: {
            'id': serviceRequestId,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> addDiscount({required int serviceRequestId, required int discount}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: addDiscountUrl,
          data: {
            'id': serviceRequestId,
            'discount': discount,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> applyDiscount({required int serviceRequestId, required String approvedBy, required String reason}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: applyDiscountUrl,
          data: {
            'id': serviceRequestId,
            'approvedBy': approvedBy,
            'reason': reason,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> removeDiscount({required int serviceRequestId}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: removeDiscountUrl,
          data: {
            'id': serviceRequestId,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CorporateSearchModel>> corporateSearch({required String input}) {
    return _basicErrorHandling<CorporateSearchModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(token: token, url: corporateSearchUrl, query: {
          'name': input,
        });

        return CorporateSearchModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> addCommentOnServiceRequest({required int serviceRequestId, required String comment}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: addCommentUrl,
          data: {
            'id': serviceRequestId,
            'comment': comment,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAllServicesRequests>> getCorporateServiceRequests({int? corporateId, int? pageNumber}) {
    return _basicErrorHandling<GetAllServicesRequests>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getCorporateServiceRequestsUrl/${corporateId ?? currentCompanyId}',
          query: {
            if (pageNumber != null) 'page': pageNumber,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return GetAllServicesRequests.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, DriversMapModel>> getAllDriversPlacesMap() {
    return _basicErrorHandling<DriversMapModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getDriversMapUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return DriversMapModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAllServicesRequests>> getAllOpenServiceRequests() {
    return _basicErrorHandling<GetAllServicesRequests>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllOpenServiceRequestsUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return GetAllServicesRequests.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, SettingTypesModel>> getSettingsTypes() {
    return _basicErrorHandling<SettingTypesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getSettingsTypesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return SettingTypesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> editSettingsTypes({
    required int settingId,
    required int baseCost,
    required double costPerKm,
    required int carType,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.patch(
          token: token,
          url: '$getSettingsTypesUrl/$settingId',
          data: {
            'base_cost': baseCost,
            'costPerKm': costPerKm,
            'car_type': carType,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAllServicesRequests>> serviceRequestSearch({
    String? serviceRequestId,
    String? clientName,
    String? clientPhoneNumber,
  }) {
    return _basicErrorHandling<GetAllServicesRequests>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: serviceRequestSearchUrl,
          query: {
            if (serviceRequestId != null) 'id': serviceRequestId,
            if (clientName != null) 'name': clientName,
            if (clientPhoneNumber != null) 'mobile': clientPhoneNumber,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return GetAllServicesRequests.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetConfigModel>> getAllConfig() {
    return _basicErrorHandling<GetConfigModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getConfigUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return GetConfigModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> updateConfig({
    required String minimumIOSVersion,
    required String minimumAndroidVersion,
    required bool underMaintaining,
    required String distanceLimit,
    required String durationLimit,
    String? termsAr,
    String? termsEn,

    required String minimumIOSVersionInspector,
    required String minimumAndroidVersionInspector,
    required bool underMaintainingInspector,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.patch(
          token: token,
          url: updateConfigUrl,
          data: {
            'minimumIOSVersion': minimumIOSVersion,
            'minimumAndroidVersion': minimumAndroidVersion,
            'underMaintaining': underMaintaining,

            'minimumIOSVersionInspector': minimumIOSVersionInspector,
            'minimumAndroidVersionInspector': minimumAndroidVersionInspector,
            'underMaintainingInspector': underMaintainingInspector,

            'distanceLimit': distanceLimit,
            'durationLimit': durationLimit,
            if (termsEn != null) 'termsAndConditionsEn': termsEn,
            if (termsAr != null) 'termsAndConditionsAr': termsAr,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, AllAdminCarsModel>> getAllAdminCars({required String page, required String size}) {
    return _basicErrorHandling<AllAdminCarsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllAdminCarsUrl,
          query: {
            'page': page,
            'size': size,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return AllAdminCarsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.message);
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, AvailableDriversModel>> getAvailableDrivers({required List<int> carServiceTypes}) {
    return _basicErrorHandling<AvailableDriversModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: getAvailableDriversUrl,
          data: {
            'carServiceTypes': carServiceTypes,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return AvailableDriversModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
    String? id,
    String? type,
    bool? isInspectionNotification,
  }) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: sendNotificationUrl,
          data: {
            'token': fcmToken,
            'title': title,
            'body': body,
            if (id != null) 'id': id,
            if (type != null) 'type': type,
            if (isInspectionNotification != null && isInspectionNotification) 'key': 1,
          },
        );
        debugPrintFullText('----- success notify > ${f.data} ------');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> cancelServiceRequestWithPayment({required String id, required String fees, required String reason}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: '$cancelWithPaymentUrl$id',
          data: {
            'fees': fees,
            'comment': reason,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, VehiclesModel>> getAllVehicles() {
    return _basicErrorHandling<VehiclesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllVehiclesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return VehiclesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> createNewVehicle({required CreateNewVehicleModel data}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createNewVehicleUrl,
          data: data.toMap(),
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, UsersModel>> getAllUsers() {
    return _basicErrorHandling<UsersModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllUsersUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return UsersModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, SearchedUserByPhoneResponseModel>> searchUserByPhone({String? clientPhoneNumber}) {
    return _basicErrorHandling<SearchedUserByPhoneResponseModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$searchUserByPhoneEndPoint$clientPhoneNumber',
        );
        return SearchedUserByPhoneResponseModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CreateUserResponseModel>> createNewUser({required CreateNewUserDTO data}) {
    return _basicErrorHandling<CreateUserResponseModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createNewUserUrl,
          data: data.toJson(),
        );
        // debugPrintFullText('${f.data} *******');
        return CreateUserResponseModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, VehiclesTypesModel>> getAllVehiclesTypes() {
    return _basicErrorHandling<VehiclesTypesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllVehiclesTypesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return VehiclesTypesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, RolesModel>> getAllRoles() {
    return _basicErrorHandling<RolesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllRolesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return RolesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CorporatesModel>> getAllCorporates() {
    return _basicErrorHandling<CorporatesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllCorporatesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return CorporatesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> createNewCorporate({required CreateNewCorporateModel data}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createNewCorporateUrl,
          data: data.toMap(),
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAllCorpBranchesResponseModel>> getAllCorpBranches({required String corpId}) {
    return _basicErrorHandling<GetAllCorpBranchesResponseModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getAllCorpBranchesEndpoint/$corpId',
        );
        debugPrint('********** success **********');
        debugPrint('**********>> ${f.data}');
        return GetAllCorpBranchesResponseModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetBranchByIdModel>> getCorpBranchById({required String branchId}) {
    return _basicErrorHandling<GetBranchByIdModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: '$getCorpBranchByIdEndpoint/$branchId',
        );
        debugPrint('********** success **********');
        debugPrint('**********>> ${f.data}');
        return GetBranchByIdModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        return exception.message;
      },
    );
  }

  ///**************************** Packages ************************************
  @override
  Future<Either<String, GetAllPackagesResponse>> getAllPackages({
    String? corporateId,
    String? insuranceId,
    String? brokerId,
    bool isForCorporate = false,
    bool isForInsurance = false,
    bool isForBroker = false,
  }) {
    return _basicErrorHandling<GetAllPackagesResponse>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          query: isForCorporate
              ? {'corprateCompanyId': corporateId}
              : isForInsurance
                  ? {'insuranceCompanyId': insuranceId}
                  : isForBroker
                      ? {'BrokerId': brokerId}
                      : null,
          url: getAllPackagesUrl,
        );

        return GetAllPackagesResponse.fromJson(f.data);
      },
      onServerError: (exception) async {
        debugPrint('********** onServerError **********');
        debugPrint(exception.toString());
        debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, void>> createPackageCustomization({required PackageCustomizationModel data}) {
    return _basicErrorHandling<void>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createCustomizationsUrl,
          data: data.toJson(),
        );
        // debugPrintFullText('${f.data} *******');
        return;
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CreatePackageModel>> createPackage({required CreatePackageDto data}) {
    return _basicErrorHandling<CreatePackageModel>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: createPackageUrl,
          data: data.toJson(),
        );
        // debugPrintFullText('${f.data} *******');
        return CreatePackageModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, PackageUsersModel>> getPackageUsers({
    required int packageId,
  }) {
    return _basicErrorHandling<PackageUsersModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getPackageUsersUrl$packageId',
        );
        // debugPrintFullText('${f.data} *******');
        return PackageUsersModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetPackageCustomizationModel>> getPackageCustomization({required int packageId}) {
    return _basicErrorHandling<GetPackageCustomizationModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getPackageCustomizationsUrl$packageId',
        );
        // debugPrintFullText('${f.data} *******');
        return GetPackageCustomizationModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, AddUserToPackageResponse>> addUsersToPackage({required int packageId, required List<PackageBulkUserModel> users}) {
    return _basicErrorHandling<AddUserToPackageResponse>(
      onSuccess: () async {
        final Response f = await dioHelper.post(
          token: token,
          url: addUsersToPackageUrl,
          base: 'https://$ENVIRONMENT.helpooapp.net/',
          data: {
            'packageId': packageId,
            'users': users.map((e) => e.toJson()).toList(),
          },
        );
        // debugPrintFullText('${f.data} *******');
        return AddUserToPackageResponse.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, CorporateUsersModel>> getCorporateUsers({required int corporateId}) {
    return _basicErrorHandling<CorporateUsersModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: '$getCorporateUsersUrl$corporateId',
        );
        // debugPrintFullText('${f.data} *******');
        return CorporateUsersModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, PromoCodeUsersModel>> getPromoCodeUsers({
    int? packageId,
    int? promoId,
  }) {
    return _basicErrorHandling<PromoCodeUsersModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getPackagesPromoUsersUrl,
          query: {
            if (packageId != null) 'pkgId': packageId,
            if (promoId != null) 'promoId': promoId,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return PromoCodeUsersModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, PromoCodesModel>> getAllPromoCodes() {
    return _basicErrorHandling<PromoCodesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: getAllPromoCodesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return PromoCodesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, PackagesPromoCodesModel>> getAllPackagesPromoCodes() {
    return _basicErrorHandling<PackagesPromoCodesModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: packagesPromoCodesUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return PackagesPromoCodesModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, NormalPromoCodeUsers>> getNormalPromoCodeUsers({
    required int promoId,
  }) {
    return _basicErrorHandling<NormalPromoCodeUsers>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: "$getPromoUsersUrl$promoId",
        );
        // debugPrintFullText('${f.data} *******');
        return NormalPromoCodeUsers.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, DriversStatisticsModel>> getDriversStatistics() {
    return _basicErrorHandling<DriversStatisticsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: driversStatisticsUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return DriversStatisticsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, VehiclesStatisticsModel>> getVehiclesStatistics() {
    return _basicErrorHandling<VehiclesStatisticsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: vehiclesStatisticsUrl,
        );
        // debugPrintFullText('${f.data} *******');
        return VehiclesStatisticsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        // debugPrint('********** onServerError **********');
        // debugPrint(exception.toString());
        // debugPrint(exception.code.toString());
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, GetAccidentDetailsModel>> updateFnol({
    required String voiceText,
    required String fnolId,
  }) {
    return _basicErrorHandling<GetAccidentDetailsModel>(
      onSuccess: () async {
        final Response f = await dioHelper.patch(
          token: token,
          url: '$updateFnolEndPoint/$fnolId',
          data: {
            'audioCommentWritten': voiceText.isEmpty ? null : voiceText,
          },
        );
        // debugPrintFullText('${f.data} *******');
        return GetAccidentDetailsModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }


  ///* stats

  @override
  Future<Either<String, AllStatsResponseModel>> getAllStats() {
    return _basicErrorHandling<AllStatsResponseModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: allStatsEndPoint,
        );
        return AllStatsResponseModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, VehiclesStatsResponseModel>> getVehiclesStats() {
    return _basicErrorHandling<VehiclesStatsResponseModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: vehiclesStatsEndPoint,
        );
        return VehiclesStatsResponseModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

  @override
  Future<Either<String, PromoStatsResponseModel>> getPromoStats() {
    return _basicErrorHandling<PromoStatsResponseModel>(
      onSuccess: () async {
        final Response f = await dioHelper.get(
          token: token,
          url: promoStatsEndPoint,
        );
        return PromoStatsResponseModel.fromJson(f.data);
      },
      onServerError: (exception) async {
        return exception.message;
      },
    );
  }

}

extension on Repository {
  Future<Either<String, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<String> Function(ServerException exception)? onServerError,
    Future<String> Function(CacheException exception)? onCacheError,
    Future<String> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on ServerException catch (e) {
      // recordError(e, s);
      // debugPrint(s.toString());
      if (onServerError != null) {
        final f = await onServerError(e);
        return Left(f);
      }
      return const Left('Server Error');
    } on CacheException catch (e) {
      // debugPrint(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return const Left('Cache Error');
    } catch (e) {
      // recordError(e, s);
      // debugPrint(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(e.toString());
    }
  }
}
