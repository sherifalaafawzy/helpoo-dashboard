
/// <!-- TODO! -->
/// <!-- TODO! DON"T FORGET TO CHANGE THE KEY IN INDEX.HTML FILE! -->
/// <!--  dev & staging  -->
/// <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBac4Acjq25AhmnhFAeAbWnyNpeRSXb5Mc"></script>
/// <!--  production  -->
/// <!--  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBTGpJ7Z3XO6bpBu19iyWdm-5U6vs7xgvs"></script>-->


// ------------------------ api config -----------------------------------

String ENVIRONMENT = dev;

String baseUrl = 'https://$ENVIRONMENT.helpooapp.net/api/';
String imagesBaseUrl = 'https://$ENVIRONMENT.helpooapp.net'; // https://apidev.helpooapp.net/public/inspections/pdf/pdf-10-1694088403137.pdf

const String vNum = 'V2.2.12';

const String dev = 'apidev';
const String staging = 'apistaging';
const String production = 'api';



// ------------------------ endpoints -------------------------------

const String apiVersion = 'v2/';
const String loginEndPoint = 'users/login';
const String profileEndPoint = 'users/me';
const String policiesEndPoint = 'cars/policies/';
const String manufacturersEndPoint = 'manufacturers';
const String carsModelsEndPoint = 'carModels';
const String createPolicyEndPoint = 'cars/create';
const String accidentReportsPoint = 'accidentReports/insurance';
const String accidentReportsByStatus = 'accidentReports/getByStatus';
const String accidentReportsDetailsPoint = 'accidentReports/show';
const String insuranceCompaniesEndPoint = 'insuranceCompanies';
const String getInsuranceEndPoint = 'insuranceCompanies/insurance';
const String inspectorsEndPoint = 'inspect/getByInsurance';
const String inspectionsEndPoint = 'inspections/getAll';
const String createInspectionEndPoint = 'inspections/create';
const String updateInspectionEndPoint = 'inspections/one';
const String getMyInspectionsCompanyAsInsuranceCompanyEndPoint = 'inspectionsCompany/getByIns';
const String uploadPdfEndPoint = 'inspections/uploadPdf/';
const String uploadImagesEndPoint = 'inspections/uploadInsuranceImages';
const String decodedPointsUrl = 'settings/encodeString';

const String getDriversUrl = 'drivers/getall';

const String getAvailableDriversUrl = 'drivers/getDriversService';

const String getAllAdminAccidentReports = 'accidentReports/getAll';
const String getAllBrokerAccidentReports = 'accidentReports/broker';
const String getAllAdminAccidentReportsByStatus = 'accidentReports/getAllByStatus';

const String getSettingsTypesUrl = 'typeSettings';

const String getMyInspectionsAsAnInspectionCompanyEndPoint = 'inspections/forInspection';
const String getMyInspectorsAsAnInspectionCompanyEndPoint = 'inspect/getByInspectionCompany';




///************************** Inspection & insurance create inspectors **************************///
const String createInspectorForInspectionCompanyEndPoint = 'inspect/addInspector';
const String createNewInspectorForInsuranceCompanyEndPoint = 'inspect/createInspector';
const String createNewInspectionCompanyEndPoint = 'inspectionsCompany/create';


///************************** Inspector **************************///

const String getMyInspectionsAsAnInspectorEndPoint = 'inspections/forInspector';

///************************** Service Request **************************///

const String getAllAdminCarsUrl = 'cars/getAllCars';

const String addServiceRequestCarEndPoint = 'cars/addCar';

const String getAllServiceRequest = 'serviceRequest/getAll';
const String getServiceRequestTypes = 'serviceRequest/types';
const String getServiceRequestDriverEndPoint = 'drivers/getDriver';

const String getCorporateServiceRequestsUrl = 'serviceRequest/corporateRequests';

const String calculateFeesUrl = 'serviceRequest/calculateFees';
const String createNewServiceRequestUrl = 'serviceRequest/create';

const String updateOneServiceRequestUrl = 'serviceRequest/update';
const String getOneServiceRequestUrl = 'serviceRequest/getOne';

const String autoAssignDriverUrl = 'drivers/autoChangeDriver';

const String assignDriverUrl = 'drivers/assignDriver';
const String cancelRequestUrl = 'serviceRequest/cancel';

const String getServiceRequestReportsUrl = 'serviceRequest/getReports';

const String searchForExistingCustomerUrl = 'users/getOneByPhoneNumber';

const String getExistingCustomerCarsUrl = 'cars/getCarByUserPhone';

const String getCarsByVinNumberEndPoint = 'cars/getCarByVinNumber';

const String confirmAndActivateCarEndPoint = 'cars/confirmAndActivate'; // .../{carId}

const String corporateSearchUrl = 'corporates/search';

const String serviceRequestSearchUrl = 'serviceRequest/search';

const String getConfigUrl = 'settings/allConfig';
const String updateConfigUrl = 'settings/config/1';

const String logGoogleMapsApiUrl = 'trackinglogs';

// waiting time

const String addWaitingTimeUrl = 'serviceRequest/addWaitingTime';
const String applyWaitingTimeUrl = 'serviceRequest/applyWaitingTime';
const String removeWaitingTimeUrl = 'serviceRequest/removeWaitingTime';

// discount

const String addDiscountUrl = 'serviceRequest/addAdminDiscount';
const String applyDiscountUrl = 'serviceRequest/applyAdminDiscount';
const String removeDiscountUrl = 'serviceRequest/removeAdminDiscount';

// cancel with payment

const String cancelWithPaymentUrl = 'serviceRequest/cancelWithPayment/';

// comment

const String addCommentUrl = 'serviceRequest/addAdminComment';

// drivers map

const String getAllOpenServiceRequestsUrl = 'serviceRequest/getAllOpen';
const String getDriversMapUrl = 'drivers/getDriversMap';

// const mapUrl = 'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/';
const mapUrl = 'https://maps.googleapis.com/maps/api/';

/// TODO: make sure that the index.html line-37
/// <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBac4Acjq25AhmnhFAeAbWnyNpeRSXb5Mc"></script>
/// is also changed to the proper key
// const apiKey = 'AIzaSyBac4Acjq25AhmnhFAeAbWnyNpeRSXb5Mc';
String apiKey = ENVIRONMENT == production ? 'AIzaSyBTGpJ7Z3XO6bpBu19iyWdm-5U6vs7xgvs' : 'AIzaSyBac4Acjq25AhmnhFAeAbWnyNpeRSXb5Mc';

// const getPlacesUrl = 'place/autocomplete/json';
// const getPlacesDetailsUrl = 'place/details/json';
// const getPlacesDetailsByCoordinatesUrl = 'geocode/json';

const getApiDataUrl = 'settings/callGETApi';

// sms
const String sendSmsUrl = 'sms/sendSms';

// send notification
const String sendNotificationUrl = 'fcm/notifyMessage';

// vehicle

const String getAllVehiclesUrl = 'vehicles/';
const String createNewVehicleUrl = 'vehicles/create';
const String getAllVehiclesTypesUrl = 'vehicles/vecTypes';

// users

const String getAllUsersUrl = 'users/';
const String searchUserByPhoneEndPoint = 'users/getOneByPhoneNumber/'; //...{+2phone} // +201093115468
const String createNewUserUrl = 'users/createUser';

//roles
const String getAllRolesUrl = 'roles';

// corporates
const String getAllCorporatesUrl = 'corporates/getAll';
const String createNewCorporateUrl = 'corporates/create';
const String getCorporateUsersUrl = 'corporates/usersInCorporate/';

// corporate branches
const String getAllCorpBranchesEndpoint = 'branches/corp'; // .../{corpId}
const String getCorpBranchByIdEndpoint = 'branches/one'; // .../{id}

// packages
const String getAllPackagesUrl = 'packages/getAll';
const String createPackageUrl = 'packages/create';
const String createCustomizationsUrl = 'packagesCustomization';
const String getPackageUsersUrl = 'packages/clientsByPackage/';
const String getPackageCustomizationsUrl = 'packagesCustomization/';
const String addUsersToPackageUrl = 'integration/addUsersInPackage';
const String getPackagesPromoUsersUrl = 'packagePromo/usedPromos';
const String getPromoUsersUrl = 'promoCode/users/';
const String getAllPromoCodesUrl = 'promoCode/';
const String packagesPromoCodesUrl = 'packagePromo/';
const String subscribeCarToPackageEndPoint = 'packages/subscribeCar';

const String driversStatisticsUrl = 'drivers/driverStats';

const String vehiclesStatisticsUrl = 'vehicles/vehicleStats';
const String getAllBrokersEndPoint = 'brokers';

const String updateFnolEndPoint = 'accidentReports/updateReport';
const String sendPdfThrowEmailEndPoint = 'sms/sendEmail';

// const String uploadFnolPdfEndPoint = 'carAccidentReport/createPdfReport' ;
const String uploadTwoFnolPdfsEndPoint = 'carAccidentReport/createPdfReportCombine';

const String refuseRequestEndPoint = 'serviceRequest/refuseReject';
const String approveReqCancelEndPoint = 'serviceRequest/approveReject';

const String getRequestTimeAndDistanceByIdEndPoint = 'drivers/getDurationAndDistance/'; // .../{id}

// stats
const String allStatsEndPoint = 'settings/stats/';
const String vehiclesStatsEndPoint = 'vehicles/vehicleStats';
const String driversStatsEndPoint = 'drivers/driverStats/';
const String promoStatsEndPoint = 'settings/promoStats';

