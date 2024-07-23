// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:helpoo_insurance_dashboard/core/models/assign_driver_response.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/cubit.dart';
import 'package:helpoo_insurance_dashboard/core/util/enums.dart';

abstract class AppState {}

class SetCommitmentState extends AppState {}

class Empty extends AppState {}

class EmptyStateToRebuild extends AppState {}

class SearchState extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class ThemeLoaded extends AppState {}

class LanguageLoaded extends AppState {}

class ChangeLanguage extends AppState {}

class LogOutState extends AppState {}

class LoginLoading extends AppState {}

class LoginError extends AppState {
  final String error;

  LoginError({
    required this.error,
  });
}

class LoginSuccess extends AppState {}

class SideMenuChanged extends AppState {}

class PasswordVisibilityChanged extends AppState {}

class FnolCurrentIndexChanged extends AppState {}

class ProfileLoading extends AppState {}

class ProfileSuccess extends AppState {}

class ProfileError extends AppState {
  final String error;

  ProfileError({
    required this.error,
  });
}

class PoliciesLoading extends AppState {}

class PoliciesSuccess extends AppState {}

class PoliciesError extends AppState {
  final String error;

  PoliciesError({
    required this.error,
  });
}

class ManufacturersSuccess extends AppState {}

class ManufacturersError extends AppState {
  final String error;

  ManufacturersError({
    required this.error,
  });
}

class ManufacturersLoading extends AppState {}

class CarsModelsSuccess extends AppState {}

class CarsModelsError extends AppState {
  final String error;

  CarsModelsError({
    required this.error,
  });
}

class CarsModelsLoading extends AppState {}

class ManufacturerChanged extends AppState {}

class CarModelChanged extends AppState {}

class CreateNewPolicyLoadingState extends AppState {}

class CreateNewPolicySuccessState extends AppState {}

class CreateNewPolicyErrorState extends AppState {
  final String error;

  CreateNewPolicyErrorState({
    required this.error,
  });
}

class AccidentReportsLoading extends AppState {}

class AccidentReportsSuccess extends AppState {}

class AccidentReportsError extends AppState {
  final String error;

  AccidentReportsError({
    required this.error,
  });
}

class AccidentReportsByStatusLoading extends AppState {}

class AccidentReportsByStatusSuccess extends AppState {
  final bool isFirstTime;

  AccidentReportsByStatusSuccess({
    required this.isFirstTime,
  });
}

class AccidentReportsByStatusSecondSuccess extends AppState {}

class AccidentReportsByStatusError extends AppState {
  final String error;

  AccidentReportsByStatusError({
    required this.error,
  });
}

class SetCurrentAccidentReport extends AppState {}

class AccidentDetailsLoading extends AppState {}

class AccidentDetailsSuccess extends AppState {
  final bool isFirstTime;

  AccidentDetailsSuccess({
    required this.isFirstTime,
  });
}

class AccidentDetailsError extends AppState {
  final String error;

  AccidentDetailsError({
    required this.error,
  });
}

class Logout extends AppState {}

class IsOldPlateChanged extends AppState {}

class CarColorChanged extends AppState {}

class CarFirstCharChanged extends AppState {}

class CarSecondCharChanged extends AppState {}

class CarThirdCharChanged extends AppState {}

class MyTimer extends AppState {}

class CurrentImageIndexChanged extends AppState {}

class AudioSeeking extends AppState {}

class AudioDurationChanged extends AppState {}

class AudioPositionChanged extends AppState {}

class AudioPlayingChanged extends AppState {}

class GetSubList extends AppState {}

class IncreaseNumberLoading extends AppState {}

class IncreaseNumberSuccess extends AppState {}

class GetAllInsuranceCompaniesLoadingState extends AppState {}

class GetAllInsuranceCompaniesSuccessState extends AppState {}

class GetAllInsuranceCompaniesErrorState extends AppState {
  final String error;

  GetAllInsuranceCompaniesErrorState({
    required this.error,
  });
}

class InsuranceCompanyChanged extends AppState {}

class CreateNewInspectorLoadingState extends AppState {}

class CreateNewInspectorSuccessState extends AppState {}

class CreateNewInspectorErrorState extends AppState {
  final String error;

  CreateNewInspectorErrorState({
    required this.error,
  });
}

class GetAllInspectorsLoadingState extends AppState {}

class GetAllInspectorsSuccessState extends AppState {}

class GetAllInspectorsErrorState extends AppState {
  final String error;

  GetAllInspectorsErrorState({
    required this.error,
  });
}

class GetMyInspectionsCompanyAsInsuranceCompanyLoadingState extends AppState {}

class GetMyInspectionsCompanyAsInsuranceCompanySuccessState extends AppState {}

class GetMyInspectionsCompanyAsInsuranceCompanyErrorState extends AppState {
  final String error;

  GetMyInspectionsCompanyAsInsuranceCompanyErrorState({
    required this.error,
  });
}

class ChangeServiceRequestStep extends AppState {}

class ChangeTowingService extends AppState {}

class AddDataToFirstExistIds extends AppState {}

class InspectorPhone2Shown extends AppState {}

class InspectorEmail2Shown extends AppState {}

class GetAllInspectionsLoadingState extends AppState {}

class GetAllInspectionsSuccessState extends AppState {}

class GetAllInspectionsErrorState extends AppState {
  final String error;

  GetAllInspectionsErrorState({
    required this.error,
  });
}

class ChangeCurrentSelectedServiceType extends AppState {}

class GetAllServiceRequestLoadingState extends AppState {
  final bool isRefreshServiceRequest;

  GetAllServiceRequestLoadingState({
    required this.isRefreshServiceRequest,
  });
}

class GetAllServiceRequestSuccessState extends AppState {
  final bool isRefreshServiceRequest;

  GetAllServiceRequestSuccessState({
    required this.isRefreshServiceRequest,
  });
}
class ServiceRequestsSecondSuccess extends AppState {

  ServiceRequestsSecondSuccess(
  );
}

class GetAllServiceRequestErrorState extends AppState {
  final String error;

  GetAllServiceRequestErrorState({
    required this.error,
  });
}

class GetServiceRequestTypesLoadingState extends AppState {}

class GetServiceRequestTypesSuccessState extends AppState {}

class GetServiceRequestTypesErrorState extends AppState {
  final String error;

  GetServiceRequestTypesErrorState({
    required this.error,
  });
}

//createInspection
class CreateInspectionLoadingState extends AppState {}

class CreateInspectionSuccessState extends AppState {}

class CreateInspectionErrorState extends AppState {
  final String error;

  CreateInspectionErrorState({
    required this.error,
  });
}

class NewPartAddedToListState extends AppState {}

class NewAccidentAddedLoadingState extends AppState {}

class NewAccidentAddedSuccessState extends AppState {}

class NewAccidentAddedErrorState extends AppState {
  final String error;

  NewAccidentAddedErrorState({
    required this.error,
  });
}

class UpdateInspectionLoadingState extends AppState {}

class UpdateInspectionSuccessState extends AppState {}

class UpdateInspectionErrorState extends AppState {
  final String error;

  UpdateInspectionErrorState({
    required this.error,
  });
}

class GovernmentChanged extends AppState {}

class AreasByGovernmentChanged extends AppState {}

class AreaChanged extends AppState {}

class InspectionTypeChanged extends AppState {}

class FilesSelected extends AppState {}

class SelectedInspection extends AppState {}

class FileRemoved extends AppState {}

class DownloadImagesAsZipLoading extends AppState {}

class ClearControllers extends AppState {}

class SetInspectionControllers extends AppState {}

class SelectedInspectorTypeChanged extends AppState {}

class UploadPdfLoadingState extends AppState {}

class UploadPdfSuccessState extends AppState {}

class UploadPdfErrorState extends AppState {
  final String error;

  UploadPdfErrorState({
    required this.error,
  });
}

class UploadInsuranceImagesLoadingState extends AppState {}

class UploadInsuranceImagesSuccessState extends AppState {}

class UploadInsuranceImagesErrorState extends AppState {
  final String error;

  UploadInsuranceImagesErrorState({
    required this.error,
  });
}

class AddServiceRequestCarLoadingState extends AppState {}

class AddServiceRequestCarSuccessState extends AppState {}

class AddServiceRequestCarErrorState extends AppState {
  final String error;

  AddServiceRequestCarErrorState({
    required this.error,
  });
}

class SetIsEuropeanVehicleState extends AppState {}

class SetSelectedVehicleServiceTypeState extends AppState {}

class SearchMapPlaceLoading extends AppState {}

class SearchMapPlaceSuccess extends AppState {}

class SearchMapPlaceError extends AppState {
  final String error;

  SearchMapPlaceError({
    required this.error,
  });
}

class GetMapPlaceDetailsLoading extends AppState {}

class GetMapPlaceDetailsSuccess extends AppState {}

class GetMapPlaceDetailsError extends AppState {
  final String error;

  GetMapPlaceDetailsError({
    required this.error,
  });
}

class DisplayIconSuccess extends AppState {}

class ChangeIsOrigin extends AppState {}

class ChangeOrigin extends AppState {}

class ChangeDestination extends AppState {}

class GetAllDriversMapLoading extends AppState {}

class GetAllDriversMapSuccess extends AppState {}

class GetAllDriversMapError extends AppState {
  final String error;

  GetAllDriversMapError({
    required this.error,
  });
}

class GetDriverBasedOnSelectedServiceTypeLoadingState extends AppState {}

class GetDriverBasedOnSelectedServiceTypeSuccessState extends AppState {}

class GetDriverBasedOnSelectedServiceTypeErrorState extends AppState {
  final String error;

  GetDriverBasedOnSelectedServiceTypeErrorState({
    required this.error,
  });
}

class ChangeOriginAddress extends AppState {}

class ChangeDestinationAddress extends AppState {}

class ChangeOriginLatLng extends AppState {}

class ChangeDestinationLatLng extends AppState {}

class ChangeDriverLatLng extends AppState {}

class CameraMovementPositionChanged extends AppState {}

class DrawPathLoadingState extends AppState {}

class DrawPathSuccessState extends AppState {}

class DrawPathErrorState extends AppState {
  final String error;

  DrawPathErrorState({
    required this.error,
  });
}

class GetMainTripPathLoadingState extends AppState {}

class GetMainTripPathSuccessState extends AppState {}

class GetMainTripPathErrorState extends AppState {
  final String error;

  GetMainTripPathErrorState({
    required this.error,
  });
}

class CalculateServiceFeesLoadingState extends AppState {}

class CalculateServiceFeesSuccessState extends AppState {
  bool isSecondTime;

  CalculateServiceFeesSuccessState({
    required this.isSecondTime,
  });
}

class CalculateServiceFeesErrorState extends AppState {
  final String error;

  CalculateServiceFeesErrorState({
    required this.error,
  });
}

class IsGettingPathLoading extends AppState {}

class CreateNewRequestLoadingState extends AppState {}

class CreateNewRequestSuccessState extends AppState {}

class NewFeesChangedState extends AppState {}

class CreateNewRequestErrorState extends AppState {
  final String error;

  CreateNewRequestErrorState({
    required this.error,
  });
}

class GetDriverPathToDrawSuccess extends AppState {
  final bool isCreateNew;

  GetDriverPathToDrawSuccess({
    required this.isCreateNew,
  });
}

class GetDriverPathToDrawError extends AppState {
  final String error;

  GetDriverPathToDrawError({
    required this.error,
  });
}

class GetPaymentMethodsListSuccess extends AppState {}

class SelectedPaymentMethodSuccess extends AppState {}

class UpdateServiceRequestLoadingState extends AppState {}

class UpdateServiceRequestSuccessState extends AppState {}

class UpdateServiceRequestErrorState extends AppState {
  final String error;

  UpdateServiceRequestErrorState({
    required this.error,
  });
}

class GetRequestByIdLoadingState extends AppState {}

class GetRequestByIdSuccessState extends AppState {}

class GetRequestByIdErrorState extends AppState {
  String error;

  GetRequestByIdErrorState(this.error);
}

class GetCurrentActiveServiceRequestLoadingState extends AppState {
  final bool isRefresh;

  GetCurrentActiveServiceRequestLoadingState({
    required this.isRefresh,
  });
}

class GetCurrentActiveServiceRequestSuccessState extends AppState {
  final bool isRefresh;
  final bool isThereActiveServiceRequest;

  GetCurrentActiveServiceRequestSuccessState({
    required this.isThereActiveServiceRequest,
    required this.isRefresh,
  });
}

class GetCurrentActiveServiceRequestErrorState extends AppState {
  final String error;

  GetCurrentActiveServiceRequestErrorState({
    required this.error,
  });
}

class SelectedServiceRequestChangedState extends AppState {}

class GetCurrentServiceRequestStatusState extends AppState {
  final ServiceRequestStatus serviceRequestStatus;

  GetCurrentServiceRequestStatusState({
    required this.serviceRequestStatus,
  });
}

class ServiceRequestListModelToNullState extends AppState {}


class LogGoogleMapsApiLoadingState extends AppState {}

class LogGoogleMapsApiSuccessState extends AppState {}

class LogGoogleMapsApiErrorState extends AppState {
  final String error;

  LogGoogleMapsApiErrorState({
    required this.error,
  });
}

class AssignDriverToServiceRequestLoadingState extends AppState {}

class AssignDriverToServiceRequestSuccessState extends AppState {
  AssignDriverResponse assignDriverResponse;

  AssignDriverToServiceRequestSuccessState({
    required this.assignDriverResponse,
  });
}

class AutoAssignDriverToServiceRequestSuccessState extends AppState {
  String message;

  AutoAssignDriverToServiceRequestSuccessState({
    required this.message,
  });
}

class AssignDriverToServiceRequestErrorState extends AppState {
  final String error;

  AssignDriverToServiceRequestErrorState({
    required this.error,
  });
}

class SetIsNewCustomerSuccessState extends AppState {}

class SearchForExistingCustomerLoadingState extends AppState {}

class SearchForExistingCustomerSuccessState extends AppState {}

class SearchForExistingCustomerErrorState extends AppState {
  final String error;

  SearchForExistingCustomerErrorState({
    required this.error,
  });
}

class GetExistingCustomerCarsLoadingState extends AppState {}

class GetExistingCustomerCarsSuccessState extends AppState {}

class GetExistingCustomerCarsErrorState extends AppState {
  final String error;

  GetExistingCustomerCarsErrorState({
    required this.error,
  });
}

class AddCarToPackageLoadingState extends AppState {}

class AddCarToPackageSuccessState extends AppState {}

class AddCarToPackageErrorState extends AppState {
  final String error;

  AddCarToPackageErrorState({
    required this.error,
  });
}

class SelectedUserCarSuccessState extends AppState {}

class GetAllDriversLoadingState extends AppState {}

class GetAllDriversSuccessState extends AppState {}

class GetAllDriversErrorState extends AppState {
  final String error;

  GetAllDriversErrorState({
    required this.error,
  });
}

class SelectedDriverSuccessState extends AppState {}

class SelectedApprovedBySuccessState extends AppState {}

class CancelServiceRequestLoadingState extends AppState {}

class CancelServiceRequestSuccessState extends AppState {}

class CancelServiceRequestErrorState extends AppState {
  final String error;

  CancelServiceRequestErrorState({
    required this.error,
  });
}

class YearOfManufactureChanged extends AppState {}

class GetServiceRequestReportsLoadingState extends AppState {}

class GetServiceRequestReportsSuccessState extends AppState {}

class GetServiceRequestReportsErrorState extends AppState {
  final String error;

  GetServiceRequestReportsErrorState({
    required this.error,
  });
}

class StartDateChanged extends AppState {}

class EndDateChanged extends AppState {}

class AddNewExcelColumnSuccessState extends AppState {}

class AddNewExcelDataSuccessState extends AppState {}

class AddWaitingTimeLoadingState extends AppState {}

class AddWaitingTimeSuccessState extends AppState {}

class AddWaitingTimeErrorState extends AppState {
  final String error;

  AddWaitingTimeErrorState({
    required this.error,
  });
}

class ApplyWaitingTimeLoadingState extends AppState {}

class ApplyWaitingTimeSuccessState extends AppState {}

class ApplyWaitingTimeErrorState extends AppState {
  final String error;

  ApplyWaitingTimeErrorState({
    required this.error,
  });
}

class RemoveWaitingTimeLoadingState extends AppState {}

class RemoveWaitingTimeSuccessState extends AppState {}

class RemoveWaitingTimeErrorState extends AppState {
  final String error;

  RemoveWaitingTimeErrorState({
    required this.error,
  });
}

class AddDiscountLoadingState extends AppState {}

class AddDiscountSuccessState extends AppState {}

class AddDiscountErrorState extends AppState {
  final String error;

  AddDiscountErrorState({
    required this.error,
  });
}

class ApplyDiscountLoadingState extends AppState {}

class ApplyDiscountSuccessState extends AppState {}

class ApplyDiscountErrorState extends AppState {
  final String error;

  ApplyDiscountErrorState({
    required this.error,
  });
}

class RemoveDiscountLoadingState extends AppState {}

class RemoveDiscountSuccessState extends AppState {}

class RemoveDiscountErrorState extends AppState {
  final String error;

  RemoveDiscountErrorState({
    required this.error,
  });
}

class SelectedDiscountReasonSuccessState extends AppState {}

class OpenWaitingTimeFormsSuccessState extends AppState {}

class OpenDiscountFormsSuccessState extends AppState {}

class SelectedReportsFilterOptionChanged extends AppState {}

class SearchCorporateLoadingState extends AppState {}

class SearchCorporateSuccessState extends AppState {}

class SearchCorporateErrorState extends AppState {
  final String error;

  SearchCorporateErrorState({
    required this.error,
  });
}

class SelectedCorporateChanged extends AppState {}

class CommentOnRequestLoadingState extends AppState {}

class CommentOnRequestSuccessState extends AppState {}

class CommentOnRequestErrorState extends AppState {
  final String error;

  CommentOnRequestErrorState({
    required this.error,
  });
}

class GetSavedFixedColumnsSuccessState extends AppState {}

class AddNewFixedColumnSuccessState extends AppState {}

class SaveNewFixedColumnsSuccessState extends AppState {}

class GetCorporateServiceRequestsLoadingState extends AppState {
  final bool isRefreshServiceRequest;

  GetCorporateServiceRequestsLoadingState({
    required this.isRefreshServiceRequest,
  });
}

class GetCorporateServiceRequestsSuccessState extends AppState {
  final bool isRefreshServiceRequest;

  GetCorporateServiceRequestsSuccessState({
    required this.isRefreshServiceRequest,
  });
}

class GetCorporateServiceRequestsErrorState extends AppState {
  final String error;

  GetCorporateServiceRequestsErrorState({
    required this.error,
  });
}

class SelectedServiceRequestStatusChanged extends AppState {}

class GetAllOpenServiceRequestsLoadingState extends AppState {}

class GetAllOpenServiceRequestsSuccessState extends AppState {}

class GetAllOpenServiceRequestsErrorState extends AppState {
  final String error;

  GetAllOpenServiceRequestsErrorState({
    required this.error,
  });
}

class GetDriversMapLoadingState extends AppState {}

class GetDriversMapSuccessState extends AppState {}

class GetDriversMapErrorState extends AppState {
  final String error;

  GetDriversMapErrorState({
    required this.error,
  });
}

class HideClientsChanged extends AppState {}

class BusyDriversChanged extends AppState {}

class FreeDriversChanged extends AppState {}

class IsWinchVehicleChanged extends AppState {}

class IsN300VehicleChanged extends AppState {}

class GetSettingTypesLoadingState extends AppState {}

class GetSettingTypesSuccessState extends AppState {}

class GetSettingTypesErrorState extends AppState {
  final String error;

  GetSettingTypesErrorState({
    required this.error,
  });
}

class EditSettingTypeLoadingState extends AppState {}

class EditSettingTypeSuccessState extends AppState {}

class EditSettingTypeErrorState extends AppState {
  final String error;

  EditSettingTypeErrorState({
    required this.error,
  });
}

class SelectedServiceRequestModelChangedState extends AppState {}

class IsSearchingServiceRequestChanged extends AppState {}

class SearchServiceRequestLoadingState extends AppState {}

class SearchServiceRequestSuccessState extends AppState {}

class SearchServiceRequestErrorState extends AppState {
  final String error;

  SearchServiceRequestErrorState({
    required this.error,
  });
}

class SearchCarByVinNumberLoadingState extends AppState {}

class SearchCarByVinNumberSuccessState extends AppState {}

class SearchCarByVinNumberErrorState extends AppState {
  final String error;

  SearchCarByVinNumberErrorState({
    required this.error,
  });
}

class SelectedFilterTypeChanged extends AppState {}

class SelectedClientPackageChanged extends AppState {}


class SelectedServiceStatusChanged extends AppState {}

class SelectedServiceRequestTypeChanged extends AppState {}

class SelectedClientTypeState extends AppState {}

class SortServiceRequestsState extends AppState {}

class SelectedSortingByChanged extends AppState {}

class ChangeInfoWindowState extends AppState {}

class ChangeClientCarTimerState extends AppState {}

class SelectedServiceRequestModelForActiveChangedState extends AppState {}

class GetAllConfigLoadingState extends AppState {}

class GetAllConfigSuccessState extends AppState {}

class GetAllConfigErrorState extends AppState {
  final String error;

  GetAllConfigErrorState({
    required this.error,
  });
}

class SelectedUnderMaintainingOptionChanged extends AppState {}
class InspectorSelectedUnderMaintainingOptionChanged extends AppState {}

class UpdateConfigLoadingState extends AppState {}

class UpdateConfigSuccessState extends AppState {}

class UpdateConfigErrorState extends AppState {
  final String error;

  UpdateConfigErrorState({
    required this.error,
  });
}

class HandleCarPlateCharState extends AppState {}

class AccidentReportsSecondSuccess extends AppState {}

class GetAllAdminCarsLoadingState extends AppState {}

class GetAllAdminCarsSuccessState extends AppState {}

class GetAllAdminCarsErrorState extends AppState {
  final String error;

  GetAllAdminCarsErrorState({
    required this.error,
  });
}

class GetAllAdminCarsSuccessSecondState extends AppState {}

class PolicyStartDateChanged extends AppState {}

class PolicyEndDateChanged extends AppState {}

class UploadInspectorPdfLoadingState extends AppState {}

class GetAllAvailableDriversLoading extends AppState {}

class GetAllAvailableDriversSuccess extends AppState {}

class GetAllAvailableDriversError extends AppState {
  final String error;

  GetAllAvailableDriversError({
    required this.error,
  });
}

class UpdateDriversMapSuccessState extends AppState {}

class DrawDriversMapSuccessState extends AppState {}

class CalcBoundsSuccessState extends AppState {}

class DrawMainTripIconsSuccessState extends AppState {}

class ChangeCameraZoomToFitThePath extends AppState {}

class SendNotificationLoadingState extends AppState {}

class SendNotificationSuccessState extends AppState {}

class SendNotificationErrorState extends AppState {
  final String error;

  SendNotificationErrorState({
    required this.error,
  });
}

class FnolRequestPageChanged extends AppState {}
class ServiceRequestPageChanged extends AppState {}

class NewPageOpenedState extends AppState {}

class CancelServiceRequestWithPaymentLoadingState extends AppState {}

class CancelServiceRequestWithPaymentSuccessState extends AppState {}

class CancelServiceRequestWithPaymentErrorState extends AppState {
  final String error;

  CancelServiceRequestWithPaymentErrorState({
    required this.error,
  });
}

class GetAllVehiclesLoadingState extends AppState {}

class GetAllVehiclesSuccessState extends AppState {}

class GetAllVehiclesErrorState extends AppState {
  final String error;

  GetAllVehiclesErrorState({
    required this.error,
  });
}

class CreateNewVehicleLoadingState extends AppState {}

class CreateNewVehicleSuccessState extends AppState {}

class CreateNewVehicleErrorState extends AppState {
  final String error;

  CreateNewVehicleErrorState({
    required this.error,
  });
}

class VehicleTypeSelectedState extends AppState {}

class GetAllUsersLoadingState extends AppState {}

class GetAllUsersSuccessState extends AppState {}

class GetAllUsersErrorState extends AppState {
  final String error;

  GetAllUsersErrorState({
    required this.error,
  });
}

class UserRoleSelectedState extends AppState {}

class CreateNewUserLoadingState extends AppState {}

class CreateNewUserSuccessState extends AppState {}

class CreateNewUserErrorState extends AppState {
  final String error;

  CreateNewUserErrorState({
    required this.error,
  });
}

class GetAllVehiclesTypesLoadingState extends AppState {}

class GetAllVehiclesTypesSuccessState extends AppState {}

class GetAllVehiclesTypesErrorState extends AppState {
  final String error;

  GetAllVehiclesTypesErrorState({
    required this.error,
  });
}

class AddVehicleTypeToListState extends AppState {}

class RemoveVehicleTypeFromListState extends AppState {}

class ClearSelectedVehicleTypesListState extends AppState {}

class GetAllRolesLoadingState extends AppState {}

class GetAllRolesSuccessState extends AppState {}

class GetAllRolesErrorState extends AppState {
  final String error;

  GetAllRolesErrorState({
    required this.error,
  });
}

class ToggleSideMenuState extends AppState {}

class SetWidgetWidthState extends AppState {}

class GetAllCorporatesLoadingState extends AppState {}

class GetAllCorporatesSuccessState extends AppState {}

class GetAllCorporatesErrorState extends AppState {
  final String error;

  GetAllCorporatesErrorState({
    required this.error,
  });
}

class SelectedCorporateIdChanged extends AppState {}

class CorporateEndDateChanged extends AppState {}

class IsDeferredPaymentChanged extends AppState {}

class IsCashPaymentChanged extends AppState {}

class IsCreditPaymentChanged extends AppState {}

class IsOnlinePaymentChanged extends AppState {}

class CreateNewCorporateLoadingState extends AppState {}

class CreateNewCorporateSuccessState extends AppState {}

class CreateNewCorporateErrorState extends AppState {
  final String error;

  CreateNewCorporateErrorState({
    required this.error,
  });
}

class SelectedCorporateForUserChanged extends AppState {}

class ChangeAvailablePaymentsSuccessState extends AppState {}

class SearchCorporatesState extends AppState {}

class SetPopupWidthState extends AppState {}

class ChangeDoneReportsOnlyState extends AppState {}

class GetAllPackagesLoadingState extends AppState {}

class GetAllPackagesSuccessState extends AppState {
  final Rules role;

  GetAllPackagesSuccessState({
    required this.role,
  });
}

class GetAllPackagesErrorState extends AppState {
  final String error;

  GetAllPackagesErrorState({
    required this.error,
  });
}

class AddControllerToBenefitsListState extends AppState {}

class RemoveControllerFromBenefitsListState extends AppState {}

class ChangePackageCustomizationState extends AppState {}

class CreatePackageCustomizationLoadingState extends AppState {}

class CreatePackageCustomizationSuccessState extends AppState {}

class CreatePackageCustomizationErrorState extends AppState {
  final String error;

  CreatePackageCustomizationErrorState({
    required this.error,
  });
}


class ActivateCarLoadingState extends AppState {}

class ActivateCarSuccessState extends AppState {}

class ActivateCarErrorState extends AppState {
  final String error;

  ActivateCarErrorState({
    required this.error,
  });
}


class CreatePackageLoadingState extends AppState {}

class CreatePackageSuccessState extends AppState {}

class CreatePackageErrorState extends AppState {
  final String error;

  CreatePackageErrorState({
    required this.error,
  });
}

class ClearCreatePackageControllersState extends AppState {}

class SelectedPackageCorporateChanged extends AppState {}

class SelectedPackageInsuranceChanged extends AppState {}

class GetPackageUsersLoadingState extends AppState {}

class GetPackageUsersSuccessState extends AppState {}

class GetPackageUsersErrorState extends AppState {
  final String error;

  GetPackageUsersErrorState({
    required this.error,
  });
}

class ChangeSelectedPackageIdState extends AppState {}

class GetPackageCustomizationLoadingState extends AppState {}

class GetPackageCustomizationSuccessState extends AppState {
  final bool exportSheetAfterSuccess;

  GetPackageCustomizationSuccessState({
    required this.exportSheetAfterSuccess,
  });
}

class GetPackageCustomizationErrorState extends AppState {
  final String error;

  GetPackageCustomizationErrorState({
    required this.error,
  });
}

class ExportExcelTemplateLoadingState extends AppState {}

class ExportExcelTemplateSuccessState extends AppState {}

class ExportExcelTemplateErrorState extends AppState {
  final String error;

  ExportExcelTemplateErrorState({
    required this.error,
  });
}

class ImportExcelFileLoadingState extends AppState {}

class ImportExcelFileSuccessState extends AppState {}

class ImportExcelFileErrorState extends AppState {
  final String error;

  ImportExcelFileErrorState({
    required this.error,
  });
}

class AddUsersToPackageSuccessState extends AppState {}

class AddUsersToPackageCallDone extends AppState {}

class FailedToAddSomeUsersToPackageState extends AppState {}

class AddUsersToPackageLoadingState extends AppState {}

class AddUsersToPackageErrorState extends AppState {
  final String error;

  AddUsersToPackageErrorState({
    required this.error,
  });
}

class GetCorporateUsersLoadingState extends AppState {}

class GetCorporateUsersSuccessState extends AppState {}

class GetCorporateUsersErrorState extends AppState {
  final String error;

  GetCorporateUsersErrorState({
    required this.error,
  });
}

class GetPromoCodeUsersLoadingState extends AppState {}

class GetPromoCodeUsersSuccessState extends AppState {}

class GetPromoCodeUsersErrorState extends AppState {
  final String error;

  GetPromoCodeUsersErrorState({
    required this.error,
  });
}

class GetAllPromoCodesLoadingState extends AppState {}

class GetAllPromoCodesSuccessState extends AppState {}

class GetAllPromoCodesErrorState extends AppState {
  final String error;

  GetAllPromoCodesErrorState({
    required this.error,
  });
}

class SelectedPromoCodeIdChanged extends AppState {}

class GetAllPackagesPromoCodesLoadingState extends AppState {}

class GetAllPackagesPromoCodesSuccessState extends AppState {}

class GetAllPackagesPromoCodesErrorState extends AppState {
  final String error;

  GetAllPackagesPromoCodesErrorState({
    required this.error,
  });
}

class GetNormalPromoCodeUsersLoadingState extends AppState {}

class GetNormalPromoCodeUsersSuccessState extends AppState {}

class GetNormalPromoCodeUsersErrorState extends AppState {
  final String error;

  GetNormalPromoCodeUsersErrorState({
    required this.error,
  });
}

class SelectedPromoNameChanged extends AppState {}

class SelectedNormalPromoNameChanged extends AppState {}

class GetDriversStatisticsLoadingState extends AppState {}

class GetDriversStatisticsSuccessState extends AppState {}

class GetDriversStatisticsErrorState extends AppState {
  final String error;

  GetDriversStatisticsErrorState({
    required this.error,
  });
}

class GetVehiclesStatisticsLoadingState extends AppState {}

class GetVehiclesStatisticsSuccessState extends AppState {}

class GetVehiclesStatisticsErrorState extends AppState {
  final String error;

  GetVehiclesStatisticsErrorState({
    required this.error,
  });
}

class GetAllBrokersLoadingState extends AppState {}

class GetAllBrokersSuccessState extends AppState {}

class GetAllBrokersErrorState extends AppState {
  final String error;

  GetAllBrokersErrorState({
    required this.error,
  });
}

class ShowExtractVoiceFailedState extends AppState {}

class UpdateFnolLoadingState extends AppState {}

class UpdateFnolErrorState extends AppState {
  final String error;

  UpdateFnolErrorState({
    required this.error,
  });
}

class UpdateFnolSuccessState extends AppState {}

class GetInsuranceLoadingState extends AppState {}

class GetInsuranceSuccessState extends AppState {}

class GetInsuranceErrorState extends AppState {
  final String error;

  GetInsuranceErrorState({
    required this.error,
  });
}

class SelectEmailState extends AppState {}

class SendPdfThrowEmailLoadingState extends AppState {}

class SendPdfThrowEmailSuccessState extends AppState {}

class SendPdfThrowEmailErrorState extends AppState {
  final String error;

  SendPdfThrowEmailErrorState({
    required this.error,
  });
}

class SelectPdfPathState extends AppState {}

class UploadFnolPdfLoadingState extends AppState {}

class UploadFnolPdfSuccessState extends AppState {}

class UploadFnolPdfErrorState extends AppState {
  final String error;

  UploadFnolPdfErrorState({
    required this.error,
  });
}

class RefuseRequestRejectLoading extends AppState {}

class RefuseRequestRejectSuccess extends AppState {}

class RefuseRequestRejectError extends AppState {
  final String error;

  RefuseRequestRejectError({
    required this.error,
  });
}

class ApproveReqCancelLoading extends AppState {}

class ApproveReqCancelSuccess extends AppState {}

class ApproveReqCancelError extends AppState {
  final String error;

  ApproveReqCancelError({
    required this.error,
  });
}

class GetAllBranchesLoadingState extends AppState {}

class GetAllBranchesSuccessState extends AppState {}

class GetAllBranchesErrorState extends AppState {
  final String error;

  GetAllBranchesErrorState({
    required this.error,
  });
}

class GetCorpBranchByIdLoadingState extends AppState {}

class GetCorpBranchByIdSuccessState extends AppState {}

class GetCorpBranchByIdErrorState extends AppState {
  final String error;

  GetCorpBranchByIdErrorState({
    required this.error,
  });
}

class DriverAlreadyInReqChangedState extends AppState {}
class GetRequestTimeAndDistanceByIdLoadingState extends AppState {}

class GetRequestTimeAndDistanceByIdSuccessState extends AppState {}

class GetRequestTimeAndDistanceByIdErrorState extends AppState {
  final String error;

  GetRequestTimeAndDistanceByIdErrorState({
    required this.error,
  });
}

class StepperUpdateStepState extends AppState {}

///* stats

// all stats
class GetAllStatsLoading extends AppState {}

class GetAllStatsSuccessState extends AppState {}

class GetAllStatsErrorState extends AppState {
  final String error;

  GetAllStatsErrorState({
    required this.error,
  });
}

// Vehicles stats
class GetVehiclesStatsLoading extends AppState {}

class GetVehiclesStatsSuccessState extends AppState {}

class GetVehiclesStatsErrorState extends AppState {
  final String error;

  GetVehiclesStatsErrorState({
    required this.error,
  });
}
