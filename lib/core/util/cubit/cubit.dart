import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart' as dio;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:helpoo_insurance_dashboard/core/di/injection.dart';
import 'package:helpoo_insurance_dashboard/core/models/accident_report_details_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/accident_reports.dart';
import 'package:helpoo_insurance_dashboard/core/models/all_admin_cars.dart';
import 'package:helpoo_insurance_dashboard/core/models/broker_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/car_model.dart' as carModel;
import 'package:helpoo_insurance_dashboard/core/models/cars_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/corporate_search_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/corporates/corporate_users_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/corporates/corporates_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/corporates/create_new_corporate_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/create_package_dto.dart';
import 'package:helpoo_insurance_dashboard/core/models/create_policy_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/drivers/driver_location_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/drivers/drivers_map_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/drivers/drivers_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/drivers/drivers_statistics_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/drivers/service_request_driver.dart';
import 'package:helpoo_insurance_dashboard/core/models/get_config_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/get_package_customization_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/image_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/inspections/inspections.dart';
import 'package:helpoo_insurance_dashboard/core/models/inspections/inspectors_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/insurance_companies_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/insurance_company/inspection_company_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/login_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/manufacturer_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/manufacturers_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/maps/map_place_details__coordinates_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/maps/map_place_details_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/maps/map_place_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/normal_promo_code_users.dart';
import 'package:helpoo_insurance_dashboard/core/models/package_bulk_user_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/package_customization_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/package_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/package_users_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/packages_promo_codes_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/policies_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/profile_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/promo_code_users_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/promo_codes_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/roles/roles_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/add_service_request_car_dto.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/available_drivers_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/calculate_fees.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/create_service_dto.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/customer_search_model.dart' as customerSearch;
import 'package:helpoo_insurance_dashboard/core/models/service_request/get_all.dart';

import 'package:helpoo_insurance_dashboard/core/models/service_request/get_types.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/service_request_customer_data_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/service_request_list_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/service_request_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/existing_user_cars_model.dart' as existingUserCars;
import 'package:helpoo_insurance_dashboard/core/models/setting_types_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/stats/vehicles_stats_response_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/upload_pdf_response_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/users/create_new_user_dto.dart';
import 'package:helpoo_insurance_dashboard/core/models/users/users_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/vehicles/create_new_vehicle_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/vehicles/vehicles_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/vehicles/vehicles_statistics_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/vehicles/vehicles_types_model.dart';
import 'package:helpoo_insurance_dashboard/core/network/local/cache_helper.dart';
import 'package:helpoo_insurance_dashboard/core/network/remote/api_endpoints.dart';
import 'package:helpoo_insurance_dashboard/core/network/repository.dart';
import 'package:helpoo_insurance_dashboard/core/util/constants.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/state.dart';
import 'package:helpoo_insurance_dashboard/core/util/enums.dart';
import 'package:helpoo_insurance_dashboard/core/util/helpoo_in_app_notifications.dart';
import 'package:helpoo_insurance_dashboard/core/util/my_poly_lines/flutter_polyline_points.dart';
import 'package:helpoo_insurance_dashboard/core/util/my_poly_lines/src/PointLatLng.dart';
import 'package:helpoo_insurance_dashboard/core/util/my_poly_lines/src/utils/polyline_result.dart';
import 'package:helpoo_insurance_dashboard/core/util/my_poly_lines/src/utils/request_enums.dart';
import 'package:helpoo_insurance_dashboard/core/util/send_sms.dart';
import 'package:helpoo_insurance_dashboard/core/util/translation.dart';
import 'package:helpoo_insurance_dashboard/core/util/utils.dart';
import 'package:helpoo_insurance_dashboard/core/util/widgets/show_pop_up.dart';
import 'package:helpoo_insurance_dashboard/features/admin_cars/admin_cars_page.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/client_fnol_and_inspection_req_page.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/after_repair.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/billing.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/fnol_step.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/police_images.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/repair_before.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/resurvey_images.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/right_save.dart';
import 'package:helpoo_insurance_dashboard/features/client_fnol_and_inspection_req/steps/supplement_images.dart';
import 'package:helpoo_insurance_dashboard/features/config/config_screen.dart';
import 'package:helpoo_insurance_dashboard/features/corporate_users/corporate_users_screen.dart';
import 'package:helpoo_insurance_dashboard/features/corporates/corporates_screen.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/dashboard_page.dart';
import 'package:helpoo_insurance_dashboard/features/drivers_statistics/drivers_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/drivers_statistics/others/busy_drivers/busy_drivers_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/drivers_statistics/others/free_drivers/free_drivers_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/drivers_statistics/others/offline_drivers/offline_drivers_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/drivers_statistics/others/online_drivers/online_drivers_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/home/widgets/drivers_map_tab.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_status/finished_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_type/after_repair_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_type/before_repair_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_type/preInception_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_type/right_save_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_type/supplement_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/inspections_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspections/pages/by_status/pending_inspection_page.dart';
import 'package:helpoo_insurance_dashboard/features/inspectors/inspectors_screen.dart';
import 'package:helpoo_insurance_dashboard/features/inspectors/widgets/inspector_pdf.dart';
import 'package:helpoo_insurance_dashboard/features/insurance_policy/insurance_policy_page.dart';
import 'package:helpoo_insurance_dashboard/features/packages/package_screen_for_company.dart';
import 'package:helpoo_insurance_dashboard/features/packages/packages_screen.dart';
import 'package:helpoo_insurance_dashboard/features/packages_promo_codes/packages_promo_codes_screen.dart';
import 'package:helpoo_insurance_dashboard/features/promo_codes/promo_codes_screen.dart';
import 'package:helpoo_insurance_dashboard/features/reports/reports_screen.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/service_requests_screen.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/service_req_detailes.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/steps/confirm.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/steps/customer_data.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/steps/existing_customer_search.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/steps/location.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/steps/services.dart';
import 'package:helpoo_insurance_dashboard/features/settings/settings_screen.dart';
import 'package:helpoo_insurance_dashboard/features/users/subs/clients/clients_screen.dart';
import 'package:helpoo_insurance_dashboard/features/users/subs/drivers/drivers_screen.dart';
import 'package:helpoo_insurance_dashboard/features/users/subs/inspectors/inspectors_screen.dart';
import 'package:helpoo_insurance_dashboard/features/users/subs/insurance/insurance_screen.dart';
import 'package:helpoo_insurance_dashboard/features/users/users_screen.dart';
import 'package:helpoo_insurance_dashboard/features/vehicles/vehicles_screen.dart';
import 'package:helpoo_insurance_dashboard/features/vehicles_statistics/others/busy_drivers/busy_vehicles_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/vehicles_statistics/others/free_drivers/free_vehicles_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/vehicles_statistics/others/offline_drivers/offline_vehicles_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/vehicles_statistics/others/online_drivers/online_vehicles_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/features/vehicles_statistics/vehicles_statistics_screen.dart';
import 'package:helpoo_insurance_dashboard/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:google_maps/google_maps.dart' as gMap;
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/inspections/accident_model.dart';
import '../../models/inspections/part_model.dart';
import '../../models/service_request/getDistanceAndDurationResponse.dart';
import '../../models/service_request/getRequestDuratonAndDistance.dart';
import '../../models/stats/all_stats_response_model.dart';
import '../../models/stats/promo_stats_response_model.dart';
import '../../models/users/activate_car_dto.dart';
import '../../models/users/create_user_response_model.dart';

AppBloc get appBloc => AppBloc.get(navigatorKey.currentContext!);

class AppBloc extends Cubit<AppState> {
  final Repository _repository;

  AppBloc({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static AppBloc get(context) => BlocProvider.of(context);

  late TranslationModel translationModel;

  bool isRtl = false;

  late ThemeData lightTheme;

  late ThemeData darkTheme;

  late String family;

  void setThemes({
    required bool rtl,
  }) {
    isRtl = rtl;

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeTheme() { // 01067300073
    family = isRtl ? 'Somar' : 'Sofia';

    lightTheme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: whiteColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 21.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontSize: 17.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.4,
        ),
        displaySmall: TextStyle(
          fontSize: 12.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryGrey,
          height: 1.4,
        ),
        displayMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        displayLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 13.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: secondaryGrey,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 19.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
      ),
    );

    darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(45, 45, 45, 1.0),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: whiteColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 21.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontSize: 17.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 15.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.4,
        ),
        displaySmall: TextStyle(
          fontSize: 12.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryGrey,
          height: 1.4,
        ),
        displayMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondaryVariant,
          height: 1.4,
        ),
        displayLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: secondary,
          height: 1.4,
        ),
        bodySmall: TextStyle(
          fontSize: 13.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: secondaryGrey,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 19.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: secondary,
          height: 1.4,
        ),
      ),
    );
  }

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(
      json.decode(
        translation,
      ),
    );

    emit(LanguageLoaded());
  }

  void changeLanguage({
    required String code,
  }) async {
    debugPrint(code);

    if (code == 'ar') {
      isRtl = true;
    } else {
      isRtl = false;
    }

    sl<CacheHelper>().put('isRtl', isRtl);

    isEnglish = !isRtl;

    String translation = await rootBundle.loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    changeTheme();

    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguage());
  }

  SideMenu _sideMenu = SideMenu.dashboard;
  int _sideMenuIndex = 0;

  SideMenu get sideMenu => _sideMenu;

  int get currentSideMenuIndex => _sideMenuIndex;

  set sideMenu(SideMenu value) {
    _sideMenu = value;
    _sideMenuIndex = value.index;
    currentAccidentReport = null;

    if (myTimer != null) {
      myTimer!.cancel();
    }

    if (value != SideMenu.accidentReports && mySecondTimer != null) {
      debugPrint('cancel');
      mySecondTimer!.cancel();
    }

    emit(SideMenuChanged());
  }

  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    emit(PasswordVisibilityChanged());
  }

  List<List<Widget>> homeScreens = [
    [const DashBoardPage()],
    [const ServiceRequestsScreen()],
    [const ClientFNOLAndInspectionReqPage()],
    [const FNOLPage()],
    [const BeforeRepairPage()],
    [const AfterRepairPage()],
    [const CollectDataPage()],
    [const InsurancePolicyPage()],
    [const InspectionsPage()],
    [const PreInceptionInspectionsPage()],
    [const BeforeRepairInspectionsPage()],
    [const SupplementInspectionsPage()],
    [const AfterRepairInspectionsPage()],
    [const RightSaveInspectionsPage()],
    [const InspectionsPage()],
    [const PendingInspectionsPage()],
    [const DoneInspectionsPage()],
    [const InspectorsScreen()],
    [const ReportsScreen()],
    [const UsersScreen()],
    [const ClientsScreen()],
    [const DriversScreen()],
    [const InspectorsUsersScreen()],
    [const InsuranceUsersScreen()],
    [const VehiclesScreen()],
    [const DriversMapTab()],
    [const SettingsScreen()],
    [const AdminCarsPage()],
    [const CorporatesScreen()],
    [const ConfigScreen()],
    // [const CorporatePackageScreen()],
    [const PackageScreenForCompany()],
    [const PromoCodesScreen()],
    [const PackagesPromoCodesScreen()],
    [const CorporateUsersScreen()],
    [const PackagesScreen()],
    [const DriversStatisticsScreen()],
    [const BusyDriversStatisticsScreen()],
    [const FreeDriversStatisticsScreen()],
    [const OfflineDriversStatisticsScreen()],
    [const OnlineDriversStatisticsScreen()],
    [const VehiclesStatisticsScreen()],
    [const BusyVehiclesStatisticsScreen()],
    [const FreeVehiclesStatisticsScreen()],
    [const OnlineVehiclesStatisticsScreen()],
    [const OfflineVehiclesStatisticsScreen()],
  ];

  void changeStackNav({
    required int index,
    required bool isAdd,
    Widget? widget,
  }) {
    if (isAdd) {
      homeScreens[index].add(widget ?? Container());
      emit(SideMenuChanged());
    } else {
      homeScreens[index].removeLast();
      emit(SideMenuChanged());
    }
  }

  bool get isCreateInspectionButtonShown {
    if (accidentDetailsModel?.report?.statusList?.contains(Steps.billing.name) ?? false) {
      return false;
    } else {
      if (accidentDetailsModel?.report?.statusList?.contains(Steps.bRepair.name) ?? false) {
        return true;
      }
      if (accidentDetailsModel?.report?.statusList?.contains(Steps.supplement.name) ?? false) {
        return true;
      }
      if (accidentDetailsModel?.report?.statusList?.contains(Steps.resurvey.name) ?? false) {
        return true;
      }
      if (accidentDetailsModel?.report?.statusList?.contains(Steps.aRepair.name) ?? false) {
        return true;
      }
      if (accidentDetailsModel?.report?.statusList?.contains(Steps.rightSave.name) ?? false) {
        return true;
      }
      return false;
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AccidentReportModel? _currentAccidentReport;

  AccidentReportModel? get currentAccidentReport => _currentAccidentReport;

  set currentAccidentReport(AccidentReportModel? value) {
    _currentAccidentReport = value;
    emit(SetCurrentAccidentReport());
  }

  Map<String, Widget> stepsScreens = {
    Steps.created.name: const FNOLStep(),
    Steps.policeReport.name: const PoliceImages(),
    Steps.bRepair.name: const RepairBefore(),
    Steps.supplement.name: const SupplementImages(),
    Steps.resurvey.name: const ResurveyImages(),
    Steps.aRepair.name: const AfterRepair(),
    Steps.rightSave.name: const RightSave(),
    Steps.billing.name: const BillingStep(),
  };
  int fnolCurrentIndex = 0;

  set setFnolCurrentIndex(int value) {
    fnolCurrentIndex = value;
    emit(FnolCurrentIndexChanged());
  }

  void changeFnolCurrentIndex(int index) {
    fnolCurrentIndex = index;
    emit(FnolCurrentIndexChanged());
  }

  void goToNextStep() {
    fnolCurrentIndex++;
    emit(FnolCurrentIndexChanged());
  }

  void goToPreviousStep() {
    fnolCurrentIndex--;
    emit(FnolCurrentIndexChanged());
  }

  LoginModel? loginModel;

//******************************************************************************
  //audio player

  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  get getIsPlaying => isPlaying;

  set setIsPlaying(bool value) {
    isPlaying = value;
    emit(AudioPlayingChanged());
  }

  get getDuration => duration;

  set setDuration(Duration value) {
    duration = value;
    emit(AudioDurationChanged());
  }

  get getPosition => position;

  set setPosition(Duration value) {
    position = value;
    emit(AudioPositionChanged());
  }

  void seekIndicator(
    double value,
  ) {
    audioPlayer.seek(Duration(seconds: value.toInt()));

    emit(AudioSeeking());
  }
  Future<List<int>> getEncryptionKey()async{
  const FlutterSecureStorage secureStorage =  FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }
  final String? securedKey = await secureStorage.read(key: 'key');
  var encryptionKey = base64Url.decode(securedKey!);
  return encryptionKey;
  }
//******************************************************************************
  void logout() async {
    await sl<CacheHelper>().clear(Keys.token);
    await sl<CacheHelper>().clear(Keys.userRoleName);
    await sl<CacheHelper>().clear(Keys.userName);
    await sl<CacheHelper>().clear(Keys.currentCompanyId);
    await sl<CacheHelper>().clear(Keys.generalID);
    await sl<CacheHelper>().clear(Keys.currentUserId);
    await sl<CacheHelper>().clear(Keys.availablePaymentMethods);
    final hiveBox = await Hive.openBox('helpoo',encryptionCipher: HiveAesCipher(await getEncryptionKey()));
    hiveBox.delete(Keys.token);
    hiveBox.delete(Keys.userRoleName);
    hiveBox.delete(Keys.userName);
    hiveBox.delete(Keys.currentCompanyId);
    hiveBox.delete(Keys.generalID);
    hiveBox.delete(Keys.currentUserId);
    hiveBox.delete(Keys.availablePaymentMethods);
    hiveBox.clear();
    token = '';
    userRoleName = '';
    userName = '';
    availablePayments = {};
    currentCompanyId = -1;
    pendingTotalItems = 0;
    billingTotalUnread = 0;
    aRepairTotalUnread = 0;
    bRepairTotalUnread = 0;
    fnolTotalUnread = 0;
    sideMenu = SideMenu.dashboard;
    inspectors = [];

    emit(Logout());
  }

//******************************************************************************

  int currentImageIndex = 0;

  void changeCurrentImageIndex(int index) {
    currentImageIndex = index;
    emit(CurrentImageIndexChanged());
  }

  void companyLogin() async {
    emit(LoginLoading());

    final result = await _repository.login(
      identifier: usernameController.text,
      password: passwordController.text.replaceFirst('\\', ''),
      fcmToken: '', // TODO: handle fcm for web
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          LoginError(
            error: failure,
          ),
        );
      },
      (data) async {
        loginModel = data;

        generalID = loginModel!.user.id;
        Hive.openBox('helpoo',encryptionCipher: HiveAesCipher(await getEncryptionKey())).then((value) {

          value.put(
            Keys.token,
            // encryptData(plainText: loginModel!.token),
            loginModel!.token,
          );

          value.put(
            Keys.userRoleName,
            loginModel!.user.roleName,
          );

          value.put(
            Keys.currentCompanyId,
            loginModel!.user.insuranceCompany?.id.toString() ?? loginModel!.user.InspectionCompanyId?.toString() ?? '0',
          );

          value.put(
            Keys.currentInsuranceCompanyId,
            loginModel!.user.insuranceCompany?.enName ?? '',
          );

          value.put(
            Keys.currentUserId,
            loginModel!.user.userId.toString(),
          );

          value.put(
            Keys.generalID,
            loginModel!.user.id.toString(),
          );
        });

        sl<CacheHelper>().put(Keys.userName, loginModel!.user.name);

        sl<CacheHelper>().put(Keys.currentCompanyName, loginModel!.user.insuranceCompany?.enName ?? '');

        userRoleName = loginModel!.user.roleName;
        userName = loginModel!.user.name;
        currentCompanyName = loginModel!.user.insuranceCompany?.enName ?? '';
        currentCompanyId = loginModel!.user.insuranceCompany?.id ?? loginModel!.user.InspectionCompanyId ?? 0;
        debugPrint('dddddddddddd login com id $currentCompanyId');
        currentInsuranceCompanyName = loginModel!.user.insuranceCompany?.enName ?? '';
        currentUserId = loginModel!.user.userId;
        // if (userRoleName == Rules.Inspector.name) {
        //   Hive.openBox('helpoo').then((value) {
        //     value.put(Keys.inspectorId,
        //         encryptData(plainText: loginModel!.user.id.toString()));
        //   });
        //
        //   // sl<CacheHelper>().put(Keys.inspectorId, loginModel!.user.id);
        //   generalID = loginModel!.user.id;
        // }

        if (userRoleName == Rules.Corporate.name) {
          // safe available payment methods in cache
          currentCompanyId = loginModel!.user.corporateCompany!.id!;
          availablePayments = {
            'cash': loginModel!.user.corporateCompany!.cash!,
            'deferredPayment': loginModel!.user.corporateCompany!.deferredPayment!,
            'cardToDriver': loginModel!.user.corporateCompany!.cardToDriver!,
            'online': loginModel!.user.corporateCompany!.online!,
          };
          // availablePayments = {
          //   'cash': true,
          //   'deferredPayment': true,
          //   'cardToDriver': true,
          //   'online': false,
          //   'online-link': false,
          // };
          sl<CacheHelper>().put(Keys.availablePaymentMethods, availablePayments);

          Hive.openBox('helpoo').then((value) {
            value.put(
              Keys.currentCompanyId,
              loginModel!.user.corporateCompany!.id.toString(),
            );
          });

          // sl<CacheHelper>()
          //     .put(Keys.corporateId, loginModel!.user.corporateCompany!.id!);

          debugPrint('availablePayments ========= $availablePayments');
        }
        if (userRoleName == Rules.CallCenter.name || userRoleName == Rules.Super.name) {
          // safe available payment methods in cache
          availablePayments = {
            'cash': true,
            'deferredPayment': true,
            'cardToDriver': true,
            'online': false,
            'online-link': true,
          };

          sl<CacheHelper>().put(Keys.availablePaymentMethods, availablePayments);
        }

        // if(userRoleName == Rules.CallCenter.name){
        //   currentCompanyId = loginModel!.user.insuranceCompany!.id!;
        //   Hive.openBox('helpoo').then((value) {
        //     value.put(
        //       Keys.currentCompanyId,
        //       encryptData(
        //         plainText: loginModel!.user.insuranceCompany!.id.toString(),
        //       ),
        //     );
        //   });
        // }
        debugPrint('user id ========= ${loginModel!.user.id}');
        token = loginModel!.token;
        // token = await storage.read(key: Keys.token) ?? '';
        // token = await sl<CacheHelper>().get(Keys.token);

        if (userRoleName == Rules.client.name) {
          emit(LoginError(error: 'you are not allowed to login'));
          return;
        }

        getProfile();

        emit(
          LoginSuccess(),
        );

        usernameController.clear();
        passwordController.clear();
      },
    );
    // FirebaseMessaging.instance.getToken().then((value) async {
    //
    // });
  }

//******************************************************************************
  void setAvailablePaymentsForCorporates({
    required bool isCash,
    required bool isDeferredPayment,
    required bool isCardToDriver,
    required bool isOnline,
    required bool isOnlineLink,
  }) {
    availablePayments = {
      'cash': isCash,
      'deferredPayment': isDeferredPayment,
      'cardToDriver': isCardToDriver,
      'online': isOnline,
      'online-link': isOnlineLink,
    };
    // sl<CacheHelper>().put(Keys.availablePaymentMethods, availablePayments);
    emit(ChangeAvailablePaymentsSuccessState());
  }

//******************************************************************************
  ProfileModel? profileModel;

  void getProfile() async {
    emit(ProfileLoading());

    final result = await _repository.getProfile();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          ProfileError(
            error: failure,
          ),
        );
      },
      (data) {
        profileModel = data;

        emit(
          ProfileSuccess(),
        );
      },
    );
  }

  PoliciesModel? policiesModel;

  bool isPoliciesLoading = false;

  void getPolicies({
    required bool isRefresh,
    bool fromSuccess = false,
  }) async {
    if (!isRefresh && !fromSuccess) {
      isPoliciesLoading = true;
      emit(PoliciesLoading());
    }

    if (policiesModel != null && !isRefresh && fromSuccess) {
      emit(PoliciesSuccess());
      return;
    }

    final result = await _repository.getPolicies();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isPoliciesLoading = false;
        emit(
          PoliciesError(
            error: failure,
          ),
        );
      },
      (data) {
        policiesModel = data;
        policiesModel!.cars.sort((a, b) => b.id.compareTo(a.id));
        isPoliciesLoading = false;
        emit(PoliciesSuccess());
      },
    );
  }

  ManufacturersModel? manufacturersModel;

  void getManufacturers() async {
    emit(ManufacturersLoading());

    if (manufacturersModel != null) {
      emit(ManufacturersSuccess());
      return;
    }

    final result = await _repository.getManufacturers();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          ManufacturersError(
            error: failure,
          ),
        );
      },
      (data) {
        manufacturersModel = data;

        emit(
          ManufacturersSuccess(),
        );
      },
    );
  }

  CarsModel? carsModel;

  void getCarsModels() async {
    emit(CarsModelsLoading());

    if (carsModel != null) {
      emit(CarsModelsSuccess());
      return;
    }

    final result = await _repository.getCarsModels();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          CarsModelsError(
            error: failure,
          ),
        );
      },
      (data) {
        carsModel = data;

        emit(
          CarsModelsSuccess(),
        );
      },
    );
  }

  TextEditingController carModelController = TextEditingController();
  TextEditingController carManufacturerController = TextEditingController();

  ManufacturerModel? _selectedManufacturer;

  ManufacturerModel? get selectedManufacturer => _selectedManufacturer;

  set selectedManufacturer(ManufacturerModel? value) {
    _selectedManufacturer = value;

    policyCarTypeController.text = value?.enName ?? '';
    policyCarModelController.clear();
    emit(ManufacturerChanged());
  }

  carModel.CarModel? _selectedCarModel;

  carModel.CarModel? get selectedCarModel => _selectedCarModel;

  set selectedCarModel(carModel.CarModel? value) {
    _selectedCarModel = value;
    policyCarModelController.text = value?.enName ?? '';

    emit(CarModelChanged());
  }

  TextEditingController policyStartDateController = TextEditingController();
  TextEditingController policyEndDateController = TextEditingController();

  ///************************* Accident Reports *************************//
  GetAccidentReportModel? accidentReportModel;

  bool isAccidentReportsLoadingFirstTime = true;

  List<int> unReadList = [];

  int totalTableItems = 0;

  int currentAccidentReportsPage = 1;

  bool isFirstTime = true;

  Future<void> getAccidentReports({
    required int pageNumber,
    bool isFirstTimeLoading = false,
  }) async {
    appBloc.currentStep = null;
    if (isFirstTimeLoading) {
      emit(AccidentReportsLoading());
    } else {
      getAccidentReportsByStatusLoadingForPagination = true;
    }

    final result = await _repository.getAccidentReports(
      pageNumber: pageNumber,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          AccidentReportsError(
            error: failure,
          ),
        );
      },
      (data) {
        accidentReportModel = data;

        totalTableItems = data.totalItems;
        debugPrint('totalTableItems>>>>> ${data.unread}');
        if (isFirstTime) {
          isFirstTime = false;
          debugPrint('isFirstTime');
          // firstExistIds = data.accidentReports.map((e) => e.id!).toList();
        }
        unReadList = data.accidentReports.where((element) => element.read == false).map((e) => e.id!).toList();
        // accidentReportsMap[pageNumber] = data.accidentReports;

        if (isAccidentReportsLoadingFirstTime) {
          isAccidentReportsLoadingFirstTime = false;
        }

        currentAccidentReportsPage = pageNumber;

        if (requestCounter == 1) {
          emit(
            AccidentReportsSuccess(),
          );
          requestCounter = 0;
        } else {
          getAccidentReportsByStatusLoadingForPagination = false;
          emit(
            AccidentReportsSecondSuccess(),
          );
        }
      },
    );
  }

  GetAccidentReportModel? fnolAccidentReports;

  GetAccidentReportModel? bRepairAccidentReports;

  GetAccidentReportModel? aRepairAccidentReports;

  GetAccidentReportModel? billingReports;

  // bool getAccidentReportsByStatusLoadingFirstTime = true;
  bool getAccidentReportsByStatusLoading = false;
  bool getAccidentReportsByStatusLoadingForPagination = false;

  Steps? currentStep;

  int fnolTotalUnread = 0;
  int bRepairTotalUnread = 0;
  int aRepairTotalUnread = 0;
  int billingTotalUnread = 0;

  int requestCounter = 0;

  Future<void> getAccidentReportsByStatus({
    required int pageNumber,
    required String status,
    bool isFirstTime = false,
  }) async {
    if (isFirstTime) {
      getAccidentReportsByStatusLoading = true;
      emit(AccidentReportsByStatusLoading());
    } else {
      getAccidentReportsByStatusLoadingForPagination = true;
    }

    final result = await _repository.getAccidentReportsByStatus(
      pageNumber: pageNumber,
      status: getApiStringStatusBasedOnInputStatus(status: status),
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        getAccidentReportsByStatusLoading = false;
        emit(
          AccidentReportsError(
            error: failure,
          ),
        );
      },
      (data) {
        totalTableItems = data.totalItems;
        if (status == Steps.created.name) {
          currentStep = Steps.created;
          fnolAccidentReports = data;
          fnolTotalUnread = data.totalItems;
          debugPrint('fnolTotal>>>>> ${data.totalItems}');
        } else if (status == Steps.bRepair.name) {
          currentStep = Steps.bRepair;
          bRepairAccidentReports = data;
          bRepairTotalUnread = data.totalItems;
          debugPrint('bRepairTotal>>>>> ${data.totalItems}');
        } else if (status == Steps.aRepair.name) {
          currentStep = Steps.aRepair;
          aRepairAccidentReports = data;
          aRepairTotalUnread = data.totalItems;
          debugPrint('aRepairTotal>>>>> ${data.totalItems}');
        } else if (status == Steps.billing.name) {
          currentStep = Steps.billing;
          billingReports = data;
          billingTotalUnread = data.totalItems;
          debugPrint('billingTotal>>>>> ${data.totalItems}');
        } else {
          appBloc.currentStep = null;
        }
        if (isFirstTime) {
          isFirstTime = false;
          debugPrint('isFirstTime');
        }
        unReadList = data.accidentReports.where((element) => element.read == false).map((e) => e.id!).toList();

        currentAccidentReportsPage = pageNumber;
        getAccidentReportsByStatusLoading = false;

        if (requestCounter == 1) {
          emit(
            AccidentReportsByStatusSuccess(
              isFirstTime: isFirstTime,
            ),
          );
          requestCounter = 0;
        } else {
          getAccidentReportsByStatusLoadingForPagination = false;
          debugPrint('getAccidentReportsByStatusLoadingForPagination is $getAccidentReportsByStatusLoadingForPagination');
          emit(
            AccidentReportsByStatusSecondSuccess(),
          );
        }
        debugPrint('getAccidentReportsByStatusLoadingForPagination is $getAccidentReportsByStatusLoadingForPagination');
      },
    );
  }

  int _currentFnolRequestPage = 1;

  int get currentFnolRequestPage => _currentFnolRequestPage;

  set currentFnolRequestPage(int value) {
    _currentFnolRequestPage = value;

    emit(FnolRequestPageChanged());
  }

  int _currentServiceRequestPage = 1;

  int get currentServiceRequestPage => _currentServiceRequestPage;

  set currentServiceRequestPage(int value) {
    _currentServiceRequestPage = value;

    emit(ServiceRequestPageChanged());
  }

  String getApiStringStatusBasedOnInputStatus({
    required String status,
  }) {
    if (status == Steps.created.name) {
      return '${Steps.created.name},${Steps.policeReport.name}';
    } else if (status == Steps.bRepair.name) {
      return '${Steps.bRepair.name},${Steps.resurvey.name},${Steps.supplement.name}';
    } else if (status == Steps.aRepair.name) {
      return '${Steps.rightSave.name},${Steps.aRepair.name}';
    } else if (status == Steps.billing.name) {
      return Steps.billing.name;
    } else {
      return '';
    }
  }

  void handleOnCallFnolAnotherPage({required int page}) {
    if (currentStep == Steps.created) {
      getAccidentReportsByStatus(
        pageNumber: page,
        status: Steps.created.name,
        isFirstTime: false,
      );
    } else if (currentStep == Steps.bRepair) {
      getAccidentReportsByStatus(
        pageNumber: page,
        status: Steps.bRepair.name,
        isFirstTime: false,
      );
    } else if (currentStep == Steps.aRepair) {
      getAccidentReportsByStatus(
        pageNumber: page,
        status: Steps.aRepair.name,
        isFirstTime: false,
      );
    } else if (currentStep == Steps.billing) {
      getAccidentReportsByStatus(
        pageNumber: page,
        status: Steps.billing.name,
        isFirstTime: false,
      );
    } else {
      getAccidentReports(
        pageNumber: page,
      );
    }
  }

  int getFnolPagesCountBasedOnCurrentStep() {
    if (currentStep == Steps.created) {
      return fnolAccidentReports!.totalPages;
    } else if (currentStep == Steps.bRepair) {
      return bRepairAccidentReports!.totalPages;
    } else if (currentStep == Steps.aRepair) {
      return aRepairAccidentReports!.totalPages;
    } else if (currentStep == Steps.billing) {
      return billingReports!.totalPages;
    } else {
      return accidentReportModel!.totalPages;
    }
  }

//******************************************************************************
  ///************************* Accident Reports Details *************************//
  GetAccidentDetailsModel? accidentDetailsModel;

  bool isGetAccidentDetailsLoading = false;

  List<ImagesModel>? docsImages;

  List<ImagesModel>? accidentImages;

  int fnolDetailsLastIndex = 0;

  void getAccidentDetails({
    required accidentId,
    bool forceRefresh = true,
    bool isFirstTime = false,
  }) async {
    if (forceRefresh) {
      isGetAccidentDetailsLoading = true;
      fnolCurrentIndex = 0;
    }

    emit(AccidentDetailsLoading());

    final result = await _repository.getAccidentDetails(accidentId: accidentId);

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAccidentDetailsLoading = false;
        emit(
          AccidentDetailsError(
            error: failure,
          ),
        );
      },
      (data) {
        accidentDetailsModel = data;
        isGetAccidentDetailsLoading = false;
        if (accidentDetailsModel!.mainImages != null) {
          docsImages = accidentDetailsModel?.mainImages?.where((e) => (e.imageName?.contains('id_img') ?? false)).toList() ?? [];

          if (accidentDetailsModel!.mainImages!.any((element) => element.imageName! == 'img2')) {
            docsImages!.add(accidentDetailsModel!.mainImages!.firstWhere((e) => e.imageName! == 'img2'));
          }
          accidentImages = accidentDetailsModel!.mainImages!.where((e) => !(e.imageName!.contains('id_img')) && e.imageName != 'img2').toList();
        }
        debugPrint('docsImages ${docsImages!.length}');
        debugPrint('--->>>>>>>> ${appBloc.accidentDetailsModel?.report?.sentToInsurance}');
        emit(
          AccidentDetailsSuccess(
            isFirstTime: isFirstTime,
          ),
        );
      },
    );
  }

//******************************************************************************

  bool _isOldPlate = false;

  bool get isOldPlate => _isOldPlate;

  set isOldPlate(bool value) {
    _isOldPlate = value;
    emit(IsOldPlateChanged());
  }

  String _selectedCarColor = '';

  String get selectedCarColor => _selectedCarColor;

  set selectedCarColor(String value) {
    _selectedCarColor = value;
    policyCarColorController.text = value;
    emit(CarColorChanged());
  }

  String _selectedCarFirstChar = '';

  String get selectedCarFirstChar => _selectedCarFirstChar;

  set selectedCarFirstChar(String value) {
    _selectedCarFirstChar = value;
    policyCarFirstCharController.text = value;
    emit(CarFirstCharChanged());
  }

  String _selectedCarSecondChar = '';

  String get selectedCarSecondChar => _selectedCarSecondChar;

  set selectedCarSecondChar(String value) {
    _selectedCarSecondChar = value;
    if (policyCarFirstCharController.text.isEmpty) {
      policyCarFirstCharController.text = value;
    } else {
      policyCarSecondCharController.text = value;
    }

    emit(CarSecondCharChanged());
  }

  String _selectedCarThirdChar = '';

  String get selectedCarThirdChar => _selectedCarThirdChar;

  set selectedCarThirdChar(String value) {
    _selectedCarThirdChar = value;

    if (policyCarFirstCharController.text.isEmpty) {
      policyCarFirstCharController.text = value;
    } else if (policyCarSecondCharController.text.isEmpty) {
      policyCarSecondCharController.text = value;
    } else {
      policyCarThirdCharController.text = value;
    }
    emit(CarThirdCharChanged());
  }

  TextEditingController policyFullNameController = TextEditingController();
  TextEditingController policyPhoneController = TextEditingController();
  TextEditingController policyEmailController = TextEditingController();
  TextEditingController policyYearOfManufactureController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController policyAppendixNumberController = TextEditingController();
  TextEditingController policyVinNumberController = TextEditingController();
  TextEditingController policyCarTypeController = TextEditingController();
  TextEditingController policyCarModelController = TextEditingController();
  TextEditingController policyCarColorController = TextEditingController();

  TextEditingController policyCarPlateNumberController = TextEditingController();

  TextEditingController policyCarFirstCharController = TextEditingController();
  TextEditingController policyCarSecondCharController = TextEditingController();
  TextEditingController policyCarThirdCharController = TextEditingController();

  TextEditingController promoCodeController = TextEditingController();

  String handlePhoneNumber({required String phoneNum}) {
    String phone = phoneNum;
    if (phoneNum.isEmpty) return '';
    if (phone.startsWith('0')) {
      phone = phone.replaceFirst('0', '+20');
    } else if (phone.startsWith('2')) {
      phone = '+$phone';
    } else if (phone.startsWith('+')) {
      phone = phone;
    } else {
      phone = '+20$phone';
    }
    return phone;
  }

  String get plateNumber =>
      "${policyCarPlateNumberController.text}-${policyCarFirstCharController.text}-${policyCarSecondCharController.text}-${policyCarThirdCharController.text}";

  void createNewPolicy() async {
    emit(CreateNewPolicyLoadingState());

    CreatePolicyModel data = CreatePolicyModel(
      phoneNumber: handlePhoneNumber(phoneNum: policyPhoneController.text),
      name: policyFullNameController.text,
      email: policyEmailController.text,
      car: PolicyCarModel(
        plateNumber: isOldPlate
            ? policyCarPlateNumberController.text
            : plateNumber == "---"
                ? ''
                : '${policyCarPlateNumberController.text}-${policyCarFirstCharController.text}-${policyCarSecondCharController.text}-${policyCarThirdCharController.text}',
        year: policyYearOfManufactureController.text,
        policyNumber: policyNumberController.text,
        color: policyCarColorController.text,
        insuranceCompanyId: currentCompanyId,
        manufacturerId: selectedManufacturer!.id,
        vinNumber: policyVinNumberController.text,
        carModelId: selectedCarModel!.id,
        policyEnds: policyEndDateController.text,
        policyStarts: policyStartDateController.text,
        appendixNumber: policyAppendixNumberController.text,
      ),
    );
    final result = await _repository.createNewPolicy(createPolicyData: data);

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          CreateNewPolicyErrorState(
            error: failure,
          ),
        );
      },
      (success) {
        debugPrint('create policy success');
        clearCreatePolicyData();
        emit(CreateNewPolicySuccessState());
        // getPolicies(isRefresh: true);
      },
    );
  }

  void clearCreatePolicyData() {
    policyFullNameController.clear();
    policyPhoneController.clear();
    policyEmailController.clear();
    policyYearOfManufactureController.clear();
    policyNumberController.clear();
    policyAppendixNumberController.clear();
    policyVinNumberController.clear();
    policyCarTypeController.clear();
    policyCarModelController.clear();
    policyCarColorController.clear();
    policyCarPlateNumberController.clear();
    policyCarFirstCharController.clear();
    policyCarSecondCharController.clear();
    policyCarThirdCharController.clear();
    insuranceCompanyController.clear();
    promoCodeController.clear();
    policyStartDateController.clear();
    policyEndDateController.clear();
  }

  List<String> yearsOfManufacture = [for (var i = DateTime.now().year; i >= 1980; i--) '$i'];

  String? _selectedYearOfManufacture;

  String? get selectedYearOfManufacture => _selectedYearOfManufacture;

  set selectedYearOfManufacture(String? value) {
    _selectedYearOfManufacture = value;
    policyYearOfManufactureController.text = value!;
    emit(YearOfManufactureChanged());
  }

  Timer? _myTimer;

  Timer? get myTimer => _myTimer;

  set myTimer(Timer? value) {
    _myTimer = value;
    emit(MyTimer());
  }

  Timer? _mySecondTimer;

  Timer? get mySecondTimer => _mySecondTimer;

  set mySecondTimer(Timer? value) {
    _mySecondTimer = value;
    debugPrint('mySecondTimer');
    emit(MyTimer());
  }

  Timer? _locationTimer;

  Timer? get locationTimer => _locationTimer;

  set locationTimer(Timer? value) {
    _locationTimer = value;
    debugPrint('locationTimer');
    emit(MyTimer());
  }

  Timer? _serviceRequestTimer;

  Timer? get serviceRequestTimer => _serviceRequestTimer;

  set serviceRequestTimer(Timer? value) {
    _serviceRequestTimer = value;
    debugPrint('serviceRequestTimer');
    emit(MyTimer());
  }

  Timer? _driversMapTimer;

  Timer? get driversMapTimer => _driversMapTimer;

  set driversMapTimer(Timer? value) {
    _driversMapTimer = value;

    debugPrint('driversMapTimer');
    emit(MyTimer());
  }

  // handle pagination sublist

  List<dynamic> itemsSubList = [];

  void getSubList({required List<dynamic> list}) {
    itemsSubList = list;
    emit(GetSubList());
  }

  // get all insurance companies

  List<InsuranceCompany> insuranceCompanies = [];

  bool isGetAllInsuranceCompanies = false;

  void getAllInsuranceCompanies() async {
    isGetAllInsuranceCompanies = true;

    emit(GetAllInsuranceCompaniesLoadingState());
    final result = await _repository.getInsuranceCompanies();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllInsuranceCompanies = false;
        emit(
          GetAllInsuranceCompaniesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllInsuranceCompanies = false;
        insuranceCompanies = data.insuranceCompanies!;
        emit(GetAllInsuranceCompaniesSuccessState());
      },
    );
  }

  TextEditingController packageInsuranceController = TextEditingController();
  InsuranceCompany? _selectedPackageInsurance;

  InsuranceCompany? get selectedPackageInsurance => _selectedPackageInsurance;

  set selectedPackageInsurance(InsuranceCompany? value) {
    _selectedPackageInsurance = value;
    packageInsuranceController.text = value != null ? value.enName! : '';
    emit(SelectedPackageInsuranceChanged());
  }

  TextEditingController packageBrokerController = TextEditingController();
  Broker? _selectedPackageBroker;

  Broker? get selectedPackageBroker => _selectedPackageBroker;

  set selectedPackageBroker(Broker? value) {
    _selectedPackageBroker = value;
    packageBrokerController.text = value != null ? value.user!.name : '';
    emit(SelectedPackageInsuranceChanged());
  }

  // create new inspector

  TextEditingController inspectorNameController = TextEditingController();
  TextEditingController inspectorMainPhoneController = TextEditingController();
  TextEditingController inspectorPhone2Controller = TextEditingController();
  TextEditingController inspectorMainEmailController = TextEditingController();
  TextEditingController inspectorEmail2Controller = TextEditingController();
  TextEditingController inspectorTypeController = TextEditingController();

  InspectorTypes selectedInspectorType = InspectorTypes.individual;

  set setSelectedInspectorType(InspectorTypes value) {
    inspectorTypeController.text = value.name;
    selectedInspectorType = value;
    emit(GovernmentChanged());
  }

  bool inspectorPhone2Shown = false;
  bool inspectorEmail2Shown = false;

  void showInspectorPhone2() {
    inspectorPhone2Shown = !inspectorPhone2Shown;
    emit(InspectorPhone2Shown());
  }

  void showInspectorEmail2() {
    inspectorEmail2Shown = !inspectorEmail2Shown;
    emit(InspectorEmail2Shown());
  }

  void createNewInspector() async {
    emit(CreateNewInspectorLoadingState());
    debugPrint('currentCompanyId: $currentCompanyId');

    final result = await _repository.createNewInspector(
      createNewInspectorData: {
        'identifier': inspectorMainPhoneController.text,
        'name': inspectorNameController.text,
        'phoneNumbers': [inspectorMainPhoneController.text, if (inspectorPhone2Controller.text.isNotEmpty) inspectorPhone2Controller.text],
        'email': inspectorMainEmailController.text,
        'emails': [inspectorMainEmailController.text, if (inspectorEmail2Controller.text.isNotEmpty) inspectorEmail2Controller.text],
        if (userRoleName == Rules.Insurance.name) 'insuranceId': currentCompanyId,
        // 'insuranceId': currentCompanyId,
        if (userRoleName == Rules.InspectionManager.name) 'inspectionCompanyId': currentCompanyId,
        // 'inspectionCompanyId': 10,
      },
      isCompany: selectedInspectorType == InspectorTypes.company,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          CreateNewInspectorErrorState(
            error: failure,
          ),
        );
      },
      (success) {
        debugPrint('create inspector success');
        clearCreateInspectorData();
        emit(CreateNewInspectorSuccessState());
        // getPolicies(isRefresh: true);
      },
    );
  }

  void clearCreateInspectorData() {
    inspectorNameController.clear();
    inspectorMainPhoneController.clear();
    inspectorMainEmailController.clear();
  }

  ///*************** Get My Inspectors [Companies && Individual] ******///
  List<Inspector> inspectors = [];
  bool getAllInspectorsLoading = false;

  void getMyInspectors({
    bool isRefresh = false,
    bool isFromSuccess = false,
  }) async {
    getAllInspectorsLoading = true;
    emit(GetAllInspectorsLoadingState());

    if (inspectors.isNotEmpty && !isRefresh && !isFromSuccess) {
      getAllInspectorsLoading = false;
      emit(GetAllInspectorsSuccessState());
    }

    final result = await _repository.getMyInspectors(
      isInspectionCompany: userRoleName == Rules.InspectionManager.name,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        getAllInspectorsLoading = false;
        emit(
          GetAllInspectorsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        inspectors = data.inspectors!;
        debugPrint(':: get all inspectors success ***************');
        debugPrint('inspectors :: ${inspectors.length}');
        for (var element in inspectors) {
          insuranceCompanies.where((e) => e.id == element.insuranceCompanyId).forEach((company) {
            element.insuranceCompany = company;
          });
        }
        inspectors.sort((a, b) => a.id!.compareTo(b.id!));
        getAllInspectorsLoading = false;
        emit(GetAllInspectorsSuccessState());
      },
    );
  }

//******************************************************************************
  var searchController = TextEditingController();
  List<Inspector> searchedInspectors = [];
  List<InspectionCompany> searchedInspectionsCompanyList = [];

  void assignSearchList() {
    searchedInspectors = inspectors;
    searchedInspectionsCompanyList = myInspectionCompaniesList;
    emit(EmptyStateToRebuild());
  }

  void searchInspector() {
    if (searchController.text.isEmpty) {
      appBloc.selectedInspectorType == InspectorTypes.values[0]
          ? searchedInspectionsCompanyList = myInspectionCompaniesList
          : searchedInspectors = inspectors;
      emit(SearchState());
      return;
    } else {
      if (appBloc.selectedInspectorType == InspectorTypes.values[0]) {
        searchedInspectionsCompanyList =
            myInspectionCompaniesList.where((company) => company.name?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false).toList();
      } else {
        searchedInspectors =
            inspectors.where((inspector) => inspector.user?.name?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false).toList();
      }

      debugPrint('searchedInspectors ++++++++ ${searchedInspectors.length}');
      debugPrint('searchedInspectionsCompanyList ++++++++ ${searchedInspectionsCompanyList.length}');
      emit(SearchState());
    }
  }

//******************************************************************************
  List<InspectionCompany> myInspectionCompaniesList = [];

  bool getMyInspectionCompaniesAsInsuranceCompanyLoading = false;

  void getMyInspectionCompaniesAsInsuranceCompany({
    bool isRefresh = false,
    bool isFromSuccess = false,
  }) async {
    getMyInspectionCompaniesAsInsuranceCompanyLoading = true;
    emit(GetMyInspectionsCompanyAsInsuranceCompanyLoadingState());

    if (myInspectionCompaniesList.isNotEmpty && !isRefresh && !isFromSuccess) {
      getMyInspectionCompaniesAsInsuranceCompanyLoading = false;
      emit(GetMyInspectionsCompanyAsInsuranceCompanySuccessState());
    }

    final result = await _repository.getMyInspectionCompaniesAsInsuranceCompany();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        getMyInspectionCompaniesAsInsuranceCompanyLoading = false;
        emit(
          GetMyInspectionsCompanyAsInsuranceCompanyErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        myInspectionCompaniesList = data.inspectionCompanies ?? [];
        debugPrint(':: get all myInspectionsCompanyList success ***************');
        debugPrint('myInspectionsCompanyList :: ${myInspectionCompaniesList.length}');
        myInspectionCompaniesList.sort((a, b) => a.id!.compareTo(b.id!));
        getMyInspectionCompaniesAsInsuranceCompanyLoading = false;
        emit(GetMyInspectionsCompanyAsInsuranceCompanySuccessState());
      },
    );
  }

//******************************************************************************

  // handle service request steps

  int serviceRequestStep = 0;

  bool isServiceRequestFirstStepDone = false;

  bool isServiceRequestSecondStepDone = false;

  bool isServiceRequestThirdStepDone = false;

  bool isServiceRequestFourthStepDone = false;

  void resetServiceRequestSteps() {
    serviceRequestStep = 0;
    isServiceRequestFirstStepDone = false;
    isServiceRequestSecondStepDone = false;
    isServiceRequestThirdStepDone = false;
    isServiceRequestFourthStepDone = false;
    searchForExistingCustomerController.clear();
    customerSearchModel = null;
    selectedUserCar = null;
    isTowingService = false;
    clearCreatePolicyData();
    originController.clear();
    destinationController.clear();
    serviceRequestCustomerDataModel = null;
  }

  bool stepValidation({required int step}) {
    switch (step) {
      case 2:
        if (isTowingService) {
          return true;
        } else {
          HelpooInAppNotification.showMessage(
            message: 'Please select service',
            color: Colors.red,
          );
          return false;
        }

      case 3:
        if (
            // originController.text.isEmpty &&
            //   destinationController.text.isEmpty &&
            selectedVehicleServiceType == null) {
          HelpooInAppNotification.showMessage(
            message: 'Please select origin and destination and vehicle type',
            color: Colors.red,
          );
          return false;
        } else {
          return true;
        }
      //test
      case 4:
        if (paymentMethodController.text.isEmpty) {
          HelpooInAppNotification.showMessage(
            message: 'Please select payment method',
            color: Colors.red,
          );
          return false;
        } else if (corpBranchController.text.isEmpty && userRoleName == Rules.Corporate.name) {
          HelpooInAppNotification.showMessage(
            message: 'Please select the branch',
            color: Colors.red,
          );
          return false;
        } else {
          return true;
        }
      default:
        return true;
    }
  }

  void changeServiceRequestStep({required int step}) {
    switch (step) {
      case 1:
        if (stepValidation(step: step)) {
          isServiceRequestFirstStepDone = true;
          serviceRequestStep = 1;
        }

        break;
      case 2:
        if (stepValidation(step: step)) {
          isServiceRequestSecondStepDone = true;
          serviceRequestStep = 2;
        }

        break;
      case 3:
        if (stepValidation(step: step)) {
          isServiceRequestThirdStepDone = true;
          serviceRequestStep = 3;
        }
        // isServiceRequestThirdStepDone = true;
        // serviceRequestStep = 3;
        break;
    }
    emit(ChangeServiceRequestStep());
  }

  void backServiceRequestStep() {
    if (serviceRequestStep > 0) {
      if (serviceRequestStep == 1) {
        resetServiceRequestSteps();
      } else {
        serviceRequestStep--;
      }
      emit(ChangeServiceRequestStep());
    }
  }

  int currentSelectedServiceType = -1;

  void changeCurrentSelectedServiceType({required int index}) {
    currentSelectedServiceType = index;
    emit(ChangeCurrentSelectedServiceType());
  }

  List<Widget> serviceRequestSteps = [
    const CustomerData(),
    const Services(),
    const MapsWidget(),
    const ServiceRequestConfirm(),
  ];
  List<Widget> existCustomerServiceRequestSteps = [
    const ExistingCustomerSearch(),
    const Services(),
    const MapsWidget(),
    const ServiceRequestConfirm(),
  ];

  bool isTowingService = false;

  void changeTowingService({required bool value}) {
    isTowingService = value;
    emit(ChangeTowingService());
  }

  ///************************* ZIP File **************************
  bool downloadAdminImagesAsZipLoading = false;
  bool downloadInspectorImagesAsZipLoading = false;

  Future<void> downloadImages(List<String> imageUrls, String filename, bool isAdminAttachment) async {
    if (isAdminAttachment) {
      downloadAdminImagesAsZipLoading = true;
    } else {
      downloadInspectorImagesAsZipLoading = true;
    }
    emit(DownloadImagesAsZipLoading());
    List<List<int>> imageBytesList = [];
    for (String url in imageUrls) {
      http.Response response = await http.get(Uri.parse('$imagesBaseUrl$url'));
      imageBytesList.add(response.bodyBytes);
    }

    Archive archive = Archive();

    for (int i = 0; i < imageBytesList.length; i++) {
      // Add each image file to the archive
      ArchiveFile file = ArchiveFile('image$i - ${DateTime.now()}.jpg', imageBytesList[i].length, imageBytesList[i]);
      archive.addFile(file);
    }

    // Create the zip file
    final zipData = ZipEncoder().encode(archive);

    // Save the zip file
    final blob = html.Blob([zipData], 'application/zip');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url);
    anchor.download = filename;
    anchor.click();
    html.Url.revokeObjectUrl(url);
    if (isAdminAttachment) {
      downloadAdminImagesAsZipLoading = false;
    } else {
      downloadInspectorImagesAsZipLoading = false;
    }
    emit(DownloadImagesAsZipLoading());
  }

  ///************************* Files **************************
  FilePickerResult? filesResult;
  FilePickerResult? pickedFilesResult;

  void selectFiles() async {
    pickedFilesResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
        'heic',
      ],
    );
    debugPrint('filesResult ${pickedFilesResult?.files.length}');

    List<PlatformFile> copyList = List.from(pickedFilesResult!.files);
    if (pickedFilesResult != null) {
      if (filesResult == null) {
        filesResult = pickedFilesResult;
      } else {
        filesResult!.files.addAll(copyList);
      }
    }
    emit(FilesSelected());
  }

  void removeFile(PlatformFile e) {
    filesResult!.files.removeWhere((element) => element.name == e.name);

    emit(FileRemoved());
  }

//********************************** Upload Insurance Images **************************
  Future<void> uploadInsuranceImages({
    required List<PlatformFile> images,
    required int inspectionId,
  }) async {
    emit(UploadInsuranceImagesLoadingState());
    UploadImageModel? image;
    List<UploadImageModel> insuranceImagesBase64 = [];

    for (int i = 0; i < images.length; i++) {
      final bytes = images[i].bytes;
      final base64Image = base64.encode(bytes!);
      final String text = images[i].name;
      image = UploadImageModel(
        image: base64Image,
        text: text,
      );
      insuranceImagesBase64.add(image);
    }

    final result = await _repository.uploadImages(
      id: inspectionId,
      insuranceImages: insuranceImagesBase64,
      progressCallback: (x, y) {
        doneFileUploaded = (x * 100) ~/ y;
        totalFileUploaded = 100;
        emit(UploadInsuranceImagesLoadingState());
      },
    );

    result.fold(
      (l) => emit(UploadInsuranceImagesErrorState(error: l)),
      (r) => emit(UploadInsuranceImagesSuccessState()),
    );
  }

  ///************************* PDF **************************
  FilePickerResult? pdfFileResult;
  FilePickerResult? pickedPdfFilesResult;

  void selectPDF() async {
    pickedPdfFilesResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    debugPrint('pdfFileResult ${pickedPdfFilesResult?.files.length}');

    List<PlatformFile> copyList = List.from(pickedPdfFilesResult!.files);
    if (pickedPdfFilesResult != null) {
      if (pdfFileResult == null) {
        pdfFileResult = pickedPdfFilesResult;
      } else {
        pdfFileResult!.files.addAll(copyList);
      }
    }

    emit(FilesSelected());
  }

  void removePDF(PlatformFile e) {
    pdfFileResult!.files.removeWhere((element) => element.name == e.name);
    emit(FilesSelected());
  }

//******************************************************************************
  Future<void> uploadPdf({required PlatformFile pdf, required int inspectionId}) async {
    emit(UploadPdfLoadingState());
    final base64Pdf = base64.encode(pdf.bytes!);

    final result = await _repository.uploadPdf(
      id: inspectionId,
      pdfBase64: base64Pdf,
      mobileNumber: '',
      progressCallback: (x, y) {
        doneFileUploaded = (x * 100) ~/ y;
        totalFileUploaded = 100;
        emit(UploadInsuranceImagesLoadingState());
      },
    );

    result.fold(
      (l) {
        emit(UploadPdfErrorState(error: l));
      },
      (r) {
        emit(UploadPdfSuccessState());
        pdfFileResult = null;
      },
    );
  }

  ///************************* Attachment **************************
  FilePickerResult? attachmentFileResult;
  FilePickerResult? pickedAttachmentFilesResult;

  void selectAttachment() async {
    pickedAttachmentFilesResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'heic', 'pdf', 'doc', 'docx', 'mp3', 'wav', 'mp4', 'mov', 'mpg', 'mpeg', 'mkv'],
    );
    debugPrint('attachmentFileResult ${pickedAttachmentFilesResult?.files.length}');

    List<PlatformFile> copyList = List.from(pickedAttachmentFilesResult!.files);
    if (pickedAttachmentFilesResult != null) {
      if (attachmentFileResult == null) {
        attachmentFileResult = pickedAttachmentFilesResult;
      } else {
        attachmentFileResult!.files.addAll(copyList);
      }
    }

    emit(FilesSelected());
  }

  void removeAttachment(PlatformFile e) {
    attachmentFileResult!.files.removeWhere((element) => element.name == e.name);
    emit(FilesSelected());
  }

  Future<void> uploadAnyAttachmentFiles({
    List<PlatformFile>? files,
    required int inspectionId,
  }) async {
    emit(UploadPdfLoadingState());

    final result = await _repository.uploadAnyAttachmentFiles(
      platformFiles: attachmentFileResult!.files,
      inspectionId: inspectionId,
      progressCallback: (x, y) {
        doneFileUploaded = (x * 100) ~/ y;
        totalFileUploaded = 100;
        emit(UploadInsuranceImagesLoadingState());
      },
    );

    result.fold(
      (l) {
        emit(UploadPdfErrorState(error: l));
        debugPrint('error while uploading files =============> ${l.toString()}');
      },
      (r) {
        emit(UploadPdfSuccessState());
      },
    );
  }

  ///*************************** Inspections ********************************
  ///*************************** *************** *******************************
  Inspection? _selectedInspection;

  Inspection? get selectedInspection => _selectedInspection;

  bool isButton = true;

  set selectedInspection(Inspection? value) {
    _selectedInspection = value;

    // isButton = _selectedInspection!.inspectionStatus != InspectionStatus.done;

    inspectionType = InspectionType.values.firstWhereOrNull((element) => element.arName == _selectedInspection!.type) ?? InspectionType.preInception;
    inspectorModel = inspectors.firstWhereOrNull((element) => element.id == value?.inspector?.id) ?? Inspector();

    inspectionCompanyModel = value?.inspectionCompany;

    inspectorController.text = inspectorModel?.user?.name ?? '';

    if (inspectorController.text.isEmpty) {
      inspectorController.text = value?.inspectionCompany?.name ?? '--';
    }

    debugPrint('${value?.inspector?.id} +++++++++++++++');
    inspectionTypeController.text = InspectionType.values.firstWhereOrNull((element) => element.apiName == value?.type)?.arName ?? '';

    selectedManufacturer = value?.manufacturer;
    selectedCarModel = value?.carModel;

    clientNameController.text = value?.clientName ?? '';
    clientPhoneController.text = value?.clientPhone ?? '';
    engPhoneController.text = value?.engPhone ?? '';
    governmentController.text = value?.government ?? '';
    cityController.text = value?.city ?? '';
    insuranceCompanyController.text = value?.insuranceCompany?.enName ?? '';
    selectedInsuranceCompany = value?.insuranceCompany;
    areaController.text = value?.area ?? '';
    addressController.text = value?.addressInfo ?? '';
    policyCarTypeController.text = value?.manufacturer?.enName ?? '';
    carModelController.text = value?.carModel?.enName ?? '';
    vinNumberController.text = value?.vinNumber ?? '';
    engineNumberController.text = value?.engineNumber ?? '';
    plateNumberController.text = value?.plateNumber ?? '';

    policyCarColorController.text = value?.color ?? '';

    beforeWorkFeesController.text = value?.workerFeesBefore ?? '';
    afterWorkFeesController.text = value?.workerFeesAfter ?? '';
    damageDescController.text = value?.damageDescription ?? '';
    accidentDescriptionController.text = value?.accidentDescription ?? '';
    accidentExceptionsController.text = value?.exceptions ?? '';
    inspectionDateController.text = value?.date ?? '';
    arrivedAtController.text = value?.arrivedAt?.split('T').first ?? '';
    followDateController.text = value?.followDate?.split('T').first ?? '';
    assignDate = value?.assignDate ?? '';

    if (value?.commitmentStatus == 'committed') {
      commitmentStatus = CommitmentStatus.committed;
    } else if (value?.commitmentStatus == 'notCommitted') {
      commitmentStatus = CommitmentStatus.notCommitted;
    }
    commitmentStatusController.text = commitmentStatus?.arName ?? '';
    notCommittedReasonController.text = value?.notCommittedReason ?? '';

    emit(SelectedInspection());
  }

//****************************************************************************
  InspectionType _inspectionType = InspectionType.preInception;

  InspectionType get inspectionType => _inspectionType;

  set inspectionType(InspectionType value) {
    _inspectionType = value;

    inspectionTypeController.text = value.arName;
    debugPrint('inspectionType :::::: ${inspectionTypeController.text}');
    emit(InspectionTypeChanged());
  }

  //*************************************************************
  Inspector? _inspectorModel;

  Inspector? get inspectorModel => _inspectorModel;

  set inspectorModel(Inspector? value) {
    _inspectorModel = value;

    inspectorController.text = value?.user?.name ?? '';

    emit(InspectionTypeChanged());
  }

  //***************************************************************
  InspectionCompany? _inspectionCompanyModel;

  InspectionCompany? get inspectionCompanyModel => _inspectionCompanyModel;

  set inspectionCompanyModel(InspectionCompany? value) {
    _inspectionCompanyModel = value;

    inspectorController.text = value?.name ?? '';

    emit(InspectionTypeChanged());
  }

  //***************************************************************
  bool getAllInspectionsLoading = false;
  List<Inspection> inspections = [];
  List<Inspection> doneInspections = [];
  List<Inspection> pendingInspections = [];
  List<Inspection> preInceptionInspections = [];
  List<Inspection> beforeRepairInspections = [];
  List<Inspection> afterRepairInspections = [];
  List<Inspection> supplementInspections = [];
  List<Inspection> rightSaveInspections = [];

  int pendingTotalItems = 0;

  void getAllInspections({String? status, String? type}) async {
    if (userRoleName == Rules.Insurance.name) {
      getMyInspectionCompaniesAsInsuranceCompany();
    }
    getMyInspectors();

    getAllInspectionsLoading = true;
    emit(GetAllInspectionsLoadingState());

    debugPrint('dddddddddddddd $userRoleName');
    debugPrint('dddddddddddddd ${Rules.InspectionManager.name}');

    final result = await _repository.getAllInspections(
      pageNumber: 1,
      size: 1000,
      status: status == 'all' ? '' : status,
      type: type,
      isInspectionCompany: userRoleName == Rules.InspectionManager.name,
    );

    result.fold(
      (failure) {
        debugPrint('-----x failure------');
        debugPrint(failure.toString());
        getAllInspectionsLoading = false;
        emit(GetAllInspectionsErrorState(error: failure));
      },
      (data) {
        debugPrint(':: get all inspections success *****************');
        debugPrint('Inspections :: ${data.inspections!.length}');

        ///******************** status ********************
        if (status == InspectionsStatus.all.name) {
          inspections = data.inspections!;
        } else if (status == InspectionsStatus.finished.name) {
          doneInspections = data.inspections!;
        } else if (status == InspectionsStatus.pending.name) {
          pendingInspections = data.inspections!;
          pendingTotalItems = data.inspections?.length ?? 0;
        }

        ///******************** type ********************
        if (type == InspectionType.preInception.apiName) {
          preInceptionInspections = data.inspections!;
        } else if (type == InspectionType.beforeRepair.apiName) {
          beforeRepairInspections = data.inspections!;
        } else if (type == InspectionType.afterRepair.apiName) {
          afterRepairInspections = data.inspections!;
        } else if (type == InspectionType.supplement.apiName) {
          supplementInspections = data.inspections!;
        } else if (type == InspectionType.rightSave.apiName) {
          rightSaveInspections = data.inspections!;
        }

        ///*********************************************************************
        for (var element in inspections) {
          insuranceCompanies.where((e) => e.id == element.insuranceCompanyId).forEach((company) {
            element.insuranceCompany = company;
          });
        }

        getAllInspectionsLoading = false;
        emit(GetAllInspectionsSuccessState());
      },
    );
  }

  // get inspection as inspector

  void getInspectionsAsInspector({
    String? status,
    String? type,
  }) async {
    getAllInspectionsLoading = true;
    emit(GetAllInspectionsLoadingState());

    final result = await _repository.getInspectionsAsInspector(
      pageNumber: 1,
      size: 1000,
      inspectorId: generalID.toString(),
      status: status == 'all' ? null : status,
      type: type,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        getAllInspectionsLoading = false;
        emit(
          GetAllInspectionsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        debugPrint(':: get all inspections success *****************');
        debugPrint('Inspections :: ${data.inspections!.length}');

        if (status == InspectionsStatus.all.name) {
          inspections = data.inspections!;
          // inspections.sort((a, b) => a.id!.compareTo(b.id!));
        } else if (status == InspectionsStatus.finished.name) {
          doneInspections = data.inspections!;
          // doneInspections.sort((a, b) => a.id!.compareTo(b.id!));
        } else if (status == InspectionsStatus.pending.name) {
          pendingInspections = data.inspections!;
          pendingTotalItems = data.inspections?.length ?? 0;
          // pendingInspections.sort((a, b) => a.id!.compareTo(b.id!));
        }

        ///******************** type ********************
        if (type == InspectionType.preInception.apiName) {
          preInceptionInspections = data.inspections!;
          // preInceptionInspections.sort((a, b) => a.id!.compareTo(b.id!));
        } else if (type == InspectionType.beforeRepair.apiName) {
          beforeRepairInspections = data.inspections!;
          // beforeRepairInspections.sort((a, b) => a.id!.compareTo(b.id!));
        } else if (type == InspectionType.afterRepair.apiName) {
          afterRepairInspections = data.inspections!;
          // afterRepairInspections.sort((a, b) => a.id!.compareTo(b.id!));
        } else if (type == InspectionType.supplement.apiName) {
          supplementInspections = data.inspections!;
          // supplementInspections.sort((a, b) => a.id!.compareTo(b.id!));
        } else if (type == InspectionType.rightSave.apiName) {
          rightSaveInspections = data.inspections!;
          // rightSaveInspections.sort((a, b) => a.id!.compareTo(b.id!));
        }

        ///*********************************************************************
        for (var element in inspections) {
          insuranceCompanies.where((e) => e.id == element.insuranceCompanyId).forEach((company) {
            element.insuranceCompany = company;
          });
        }

        getAllInspectionsLoading = false;
        emit(GetAllInspectionsSuccessState());
      },
    );
  }

//******************************************************************************
  //************************ Create Inspection Controllers *********************
  TextEditingController accidentDescController = TextEditingController();
  TextEditingController accidentOpinionController = TextEditingController();
  TextEditingController extractedRecoTextController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientPhoneController = TextEditingController();
  TextEditingController engPhoneController = TextEditingController();
  TextEditingController governmentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carBrandController = TextEditingController();
  TextEditingController vinNumberController = TextEditingController();
  TextEditingController engineNumberController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController accidentDescriptionController = TextEditingController();
  TextEditingController damageDescController = TextEditingController();
  TextEditingController beforeWorkFeesController = TextEditingController();
  TextEditingController afterWorkFeesController = TextEditingController();
  TextEditingController accidentExceptionsController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController followDateController = TextEditingController();
  TextEditingController arrivedAtController = TextEditingController();
  String? assignDate;
  TextEditingController notesController = TextEditingController();
  TextEditingController inspectionTypeController = TextEditingController();
  TextEditingController inspectorController = TextEditingController();

  ///************************ stepper **********************
  int activeStepIndex = 0;

  void incrementActiveStepIndex() {
    if (activeStepIndex < 6) {
      if (activeStepIndex == 4 && selectedInspection == null && selectedInspection!.inspectionStatus == InspectionsStatus.pending) {
        return;
      }
      if (activeStepIndex == 4 && selectedInspection != null && selectedInspection!.inspectionStatus == InspectionsStatus.pending) {
        return;
      }
      if (userRoleName == Rules.Insurance.name &&
          activeStepIndex == 5 &&
          selectedInspection != null &&
          selectedInspection!.inspectionStatus != InspectionsStatus.pending) {
        return;
      }
      if (userRoleName == Rules.InspectionManager.name && activeStepIndex == 6) {
        return;
      }
      activeStepIndex++;
      emit(StepperUpdateStepState());
    }
  }

  void decrementActiveStepIndex() {
    if (activeStepIndex < 1) {
      return;
    }
    activeStepIndex--;
    emit(StepperUpdateStepState());
  }

  ///************************ reco extraction **********************
  bool isRecoExtractionLoading = false;
  SupplementImageModel? selectedSupplementImage;

  void saveSupplementExtractedRecoText() async {
    isRecoExtractionLoading = true;
    selectedSupplementImage?.audioText = extractedRecoTextController.text;

    for (int i = 0; i < selectedInspection!.supplementImages!.length; i++) {
      if (selectedInspection!.supplementImages![i].imagePath == selectedSupplementImage!.imagePath) {
        selectedInspection!.supplementImages![i] = selectedSupplementImage!;
      }
    }

    formData = dio.FormData.fromMap({
      'supplementImages': selectedInspection!.supplementImages!.map((e) => e.toJson()).toList(),
    });

    final result = await _repository.updateInspection(
      inspectionId: selectedInspection!.id!,
      updateInspectionData: formData!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        createInspectionLoading = false;
        emit(UpdateInspectionErrorState(error: failure));
      },
      (data) async {
        debugPrint('-----success------');
        extractedRecoTextController.clear();
        // selectedSupplementImage = null;
        isRecoExtractionLoading = false;
        // emit(UpdateInspectionSuccessState()); // don't emmit to stay on the details page as lestinig to this state makes a context.pop() in the ui
      },
    );
  }

  void saveNotesExtractedRecoText() async {
    isRecoExtractionLoading = true;
    selectedInspection!.audioRecords!.first.text = extractedRecoTextController.text;

    formData = dio.FormData.fromMap({
      'audioRecordsWithNotes': selectedInspection!.audioRecords!.map((e) => e.toJson()).toList(),
    });

    final result = await _repository.updateInspection(
      inspectionId: selectedInspection!.id!,
      updateInspectionData: formData!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        createInspectionLoading = false;
        emit(UpdateInspectionErrorState(error: failure));
      },
      (data) async {
        debugPrint('-----success------');
        extractedRecoTextController.clear();
        isRecoExtractionLoading = false;
        // emit(UpdateInspectionSuccessState()); // don't emmit to stay on the details page as lestinig to this state makes a context.pop() in the ui
      },
    );
  }

  //****************************************************************************
  void clearControllers() {
    _selectedInspection = null;
    pickedFilesResult = null;
    pickedPdfFilesResult = null;
    _selectedArea = null;
    _selectedGovernment = null;
    _selectedCarModel = null;
    _selectedInsuranceCompany = null;
    filesResult = null;
    pdfFileResult = null;
    attachmentFileResult = null;
    assignDate = null;
    inspectionType = InspectionType.preInception;
    _inspectorModel = null;
    inspectionTypeController.text = inspectionType.arName;
    inspectorController.clear();
    clientNameController.clear();
    clientPhoneController.clear();
    engPhoneController.clear();
    governmentController.clear();
    cityController.clear();
    areaController.clear();
    addressController.clear();
    carModelController.clear();
    vinNumberController.clear();
    engineNumberController.clear();
    plateNumberController.clear();
    accidentDescriptionController.clear();
    damageDescController.clear();
    beforeWorkFeesController.clear();
    afterWorkFeesController.clear();
    accidentOpinionController.clear();
    accidentDescController.clear();
    accidentExceptionsController.clear();
    inspectionDateController.clear();
    arrivedAtController.clear();
    followDateController.clear();
    insuranceCompanyController.clear();
    carModelController.clear();
    carManufacturerController.clear();
    carBrandController.clear();
    policyCarTypeController.clear();
    policyCarModelController.clear();
    selectedCarModel = null;
    selectedManufacturer = null;
    commitmentStatus = null;
    commitmentStatusController.clear();
    notCommittedReasonController.clear();
    emit(ClearControllers());
  }

  //****************************************************************************
  ///************************ Create Inspection From FNOL **********************
  void setInspectionControllers({required GetAccidentDetailsModel accidentDetailsModel}) {
    debugPrint('plate number :: ${accidentDetailsModel.report?.car?.plateNumber ?? ''}');
    Report? accidentReport = accidentDetailsModel.report;
    clientNameController.text = accidentReport?.client ?? '';
    clientPhoneController.text = accidentReport?.phoneNumber ?? '';
    plateNumberController.text = accidentReport?.car?.plateNumber ?? '';
    vinNumberController.text = accidentReport?.car?.vinNumber ?? '';
    policyCarTypeController.text = accidentReport?.car?.manufacturer?.enName ?? '';
    policyCarModelController.text = accidentReport?.car?.carModel?.enName ?? '';
    accidentDescriptionController.text = accidentReport?.comment ?? '';
    selectedManufacturer = accidentReport?.car?.manufacturer;
    selectedCarModel = accidentReport?.car?.carModel;
    addressController.text = accidentReport?.location?.address ?? '';
    inspectionType =
        accidentDetailsModel.report!.statusList!.any((e) => (e == Steps.rightSave.name || e == Steps.aRepair.name || e == Steps.billing.name))
            ? InspectionType.afterRepair
            : accidentDetailsModel.report!.statusList!.any((e) => (e == Steps.resurvey.name || e == Steps.supplement.name))
                ? InspectionType.supplement
                : accidentDetailsModel.report!.statusList!.any((e) => e == Steps.bRepair.name)
                    ? InspectionType.beforeRepair
                    : InspectionType.preInception;
    inspectionTypeController.text = inspectionType.arName;

    emit(SetInspectionControllers());
  }

  //****************************************************************************
  dio.FormData? formData;
  bool createInspectionLoading = false;

  Future<List<http.MultipartFile>> convertToMultipart(List<PlatformFile> platformFiles) async {
    List<http.MultipartFile> multipartFiles = [];

    for (PlatformFile platformFile in platformFiles) {
      Uint8List fileBytes = platformFile.bytes!;
      multipartFiles.add(
        http.MultipartFile.fromBytes(
          'files',
          fileBytes,
          filename: platformFile.name,
        ),
      );
    }
    return multipartFiles;
  }

  TextEditingController insuranceCompanyController = TextEditingController();

  InsuranceCompany? _selectedInsuranceCompany;

  InsuranceCompany? get selectedInsuranceCompany => _selectedInsuranceCompany;

  set selectedInsuranceCompany(InsuranceCompany? company) {
    _selectedInsuranceCompany = company;
    insuranceCompanyController.text = company?.arName ?? '';
    emit(InsuranceCompanyChanged());
  }

  int totalFileUploaded = 0;
  int doneFileUploaded = 0;

  void createInspection({
    bool isFromFNOL = false,
  }) async {
    createInspectionLoading = true;
    emit(CreateInspectionLoadingState());
    selectedInspectorType == InspectorTypes.company
        ? debugPrintFullText('inspectionCompanyModel ID: ${inspectionCompanyModel?.id ?? 0}')
        : debugPrintFullText('inspectorId: ${inspectorModel?.id ?? 0}');

    formData = dio.FormData.fromMap(
      {
        // 'createdAt': DateTime.now(),
        'inspectDate': inspectionDateController.text,
        'arrivedAt': arrivedAtController.text,
        'assignDate': assignDate != null && assignDate!.isNotEmpty ? assignDate.toString() : null,
        'followDate': followDateController.text,
        'color': selectedCarColor ?? '',
        'clientName': clientNameController.text,
        'clientPhone': clientPhoneController.text,
        'engPhone': engPhoneController.text,
        'government': governmentController.text,
        'city': cityController.text != '' ? cityController.text : governmentController.text,
        'area': areaController.text != '' ? areaController.text : governmentController.text,
        'addressInfo': addressController.text,
        'carBrand': selectedManufacturer?.id ?? '',
        'carModel': selectedCarModel?.id ?? '',
        'vinNumber': vinNumberController.text,
        'engineNumber': engineNumberController.text,
        'plateNumber': plateNumberController.text,
        'accidentDescription': accidentDescriptionController.text,
        'exceptions': accidentExceptionsController.text,
        'type': InspectionType.values.firstWhereOrNull((element) => element.arName == inspectionTypeController.text)?.apiName,
        'date': inspectionDateController.text,
        // 'insuranceImages': multipartImagesList,
        // 'inspectorImages': [],
        'notes': notesController.text,
        'damageDescription': damageDescController.text,
        'workerFeesBefore': beforeWorkFeesController.text,
        'workerFeesAfter': afterWorkFeesController.text,

        if (selectedInspectorType == InspectorTypes.individual) 'inspectorId': inspectorModel?.id ?? 0,
        if (selectedInspectorType == InspectorTypes.company && userRoleName == Rules.Insurance.name) 'inspectionCompanyId': inspectionCompanyModel?.id ?? 0,
        if (userRoleName == Rules.InspectionManager.name) 'inspectionCompanyId': currentCompanyId ?? 0,
        // if (userRoleName == Rules.InspectionManager.name) 'inspectionCompanyId': inspectionCompanyModel?.id ?? 0,
        if (userRoleName == Rules.InspectionManager.name) 'insuranceCompanyId': selectedInsuranceCompany?.id ?? 0,
        if (userRoleName == Rules.Insurance.name) 'insuranceCompanyId': currentCompanyId,
      },
    );

    final result = await _repository.createNewInspection(
      createNewInspectionData: formData!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        createInspectionLoading = false;
        emit(
          CreateInspectionErrorState(
            error: failure,
          ),
        );
      },
      (data) async {
        debugPrint('-----create inspection success------');

        await uploadInspectorPdf(
          inspectionId: data.inspection?.id ?? 0,
          isOpenFromFNOL: isFromFNOL,
        );

        debugPrint('-----upload inspector pdf success------');

        if (filesResult != null && filesResult!.files.isNotEmpty) {
          debugPrint('-----upload insurance images------');
          await uploadInsuranceImages(images: filesResult!.files, inspectionId: data.inspection?.id ?? 0);
        }
        if (pdfFileResult != null && pdfFileResult!.files.isNotEmpty) {
          debugPrint('-----upload insurance pdf------');
          await uploadPdf(pdf: pdfFileResult!.files[0], inspectionId: data.inspection?.id ?? 0);
        }
        if (attachmentFileResult != null && attachmentFileResult!.files.isNotEmpty) {
          debugPrint('-----upload insurance attachs------');
          await uploadAnyAttachmentFiles(files: attachmentFileResult!.files, inspectionId: data.inspection?.id ?? 0);
        }

        if (inspectorModel?.fcmtoken != null) {
          sendNotification(
            fcmtoken: inspectorModel?.fcmtoken ?? '',
            title: 'helpoo',
            body:
                'لقد كلفت بمعاينة جديدة ${InspectionType.values.firstWhereOrNull((element) => element.arName == inspectionTypeController.text)!.arName ?? ''}',
            isInspectionNotification: true,
          );
        }

        // send sms to inspector after upload pdf
        await SMS.sendSingleSMS(
          selectedInspectorType == InspectorTypes.company
              ? inspectionCompanyModel?.phoneNumbers?.first ?? ''
              : inspectorModel?.phoneNumbers?.first ?? '',
          'لقد كلفت بمعاينة اخري جديدة ${InspectionType.values.firstWhereOrNull((element) => element.arName == inspectionTypeController.text)!.arName ?? ''}',
        );

        getAllInspections(status: InspectionsStatus.all.name);
        createInspectionLoading = false;

        clearControllers();

        emit(CreateInspectionSuccessState());
      },
    );
  }

  Future<void> uploadInspectorPdf({
    required int inspectionId,
    bool isOpenFromFNOL = false,
  }) async {
    emit(UploadInspectorPdfLoadingState());
    debugPrint('-------- uploadInspectorPdf ----------');
    var pdfFile = await InspectorPdf.generateBodyBDF(
      context: navigatorKey.currentContext!,
      clientName: clientNameController.text,
      // clientPhone: clientPhoneController.text,
      clientAddress: addressController.text,
      clientGovernment: governmentController.text,
      clientCity: cityController.text,
      carType: selectedManufacturer?.enName ?? '',
      carModel: selectedCarModel?.enName ?? '',
      vinNumber: vinNumberController.text,
      plateNumber: plateNumberController.text,
      inspectionDate: inspectionDateController.text,
      images: filesResult != null ? filesResult!.files : null,
      isHasSupplementLocation: isOpenFromFNOL && accidentDetailsModel != null && accidentDetailsModel!.report!.supplementLocation != null,
      isHasBeforeLocation: isOpenFromFNOL && accidentDetailsModel != null && accidentDetailsModel!.report!.beforeRepairLocation != null,
      fnolLat: accidentDetailsModel?.report?.location?.lat ?? 0,
      fnolLng: accidentDetailsModel?.report?.location?.lng ?? 0,
      beforeLat: accidentDetailsModel?.report?.beforeRepairLocation?[0].lat ?? 0,
      beforeLng: accidentDetailsModel?.report?.beforeRepairLocation?[0].lng ?? 0,
      supplementLat: accidentDetailsModel?.report?.supplementLocation?[0].lat ?? 0,
      supplementLng: accidentDetailsModel?.report?.supplementLocation?[0].lng ?? 0,
      fnolImages:
          isOpenFromFNOL && accidentDetailsModel != null && accidentDetailsModel!.mainImages!.isNotEmpty ? accidentDetailsModel!.mainImages! : null,
      beforeImages: isOpenFromFNOL && accidentDetailsModel != null && accidentDetailsModel!.bRepairImages!.isNotEmpty
          ? accidentDetailsModel!.bRepairImages!
          : null,
      policyImages: isOpenFromFNOL && accidentDetailsModel != null && accidentDetailsModel!.policeImages!.isNotEmpty
          ? accidentDetailsModel!.policeImages!
          : null,
      supplementImages: isOpenFromFNOL && accidentDetailsModel != null && accidentDetailsModel!.supplementImages!.isNotEmpty
          ? accidentDetailsModel!.supplementImages!
          : null,
    );

    String inspectorMobile =
        selectedInspectorType == InspectorTypes.company ? inspectionCompanyModel!.phoneNumbers![0] : inspectorModel!.phoneNumbers![0];

    debugPrint('current inspector mobile : $inspectorMobile');

    final result = await _repository.uploadPdf(
      id: inspectionId,
      pdfBase64: pdfFile,
      mobileNumber: inspectorMobile,
      progressCallback: (x, y) {
        doneFileUploaded = (x * 100) ~/ y;
        totalFileUploaded = 100;
        emit(UploadInsuranceImagesLoadingState());
      },
    );

    result.fold(
      (l) {
        emit(UploadPdfErrorState(error: l));
      },
      (r) async {
        debugPrint('ssssssssss 1 ${selectedInspection?.insuranceCompany?.toJson()}');
        debugPrint('ssssssssss 2 ${selectedInspection?.inspectionCompany?.toJson()}');

        // send sms to inspector after upload pdf
        await SMS.sendSingleSMS(
            inspectorMobile,
            'لقد تم تكليفك للمعاينه من شركة $currentCompanyName التفاصيل من خلال الرابط : $imagesBaseUrl$r');

        emit(UploadPdfSuccessState());

        pdfFileResult = null;
      },
    );
  }

  // List<PartViewModel> partsListView = [];

  // parts list
  void addPartModelField() {
    // partsListView.add(PartViewModel());
    selectedInspection!.partsList!.add(PartViewModel());
    emit(NewPartAddedToListState());
  }

  // accidents list
  bool isAddingAccidentLoading = false;

  void addAccidentToAccsList() async {
    isAddingAccidentLoading = true;
    emit(UpdateInspectionLoadingState());

    selectedInspection!.accidentList!.add(AccidentModel(
      description: accidentDescController.text,
      opinion: accidentOpinionController.text,
    ));

    formData = dio.FormData.fromMap({
      'accidentList': selectedInspection!.accidentList!.map((e) => e.toJson()).toList(),
    });

    final result = await _repository.updateInspection(
      updateInspectionData: formData!,
      inspectionId: selectedInspection!.id!,
    );

    result.fold(
      (failure) {
        isAddingAccidentLoading = false;
        emit(NewAccidentAddedErrorState(error: failure));
      },
      (success) async {
        accidentDescController.clear();
        accidentOpinionController.clear();
        isAddingAccidentLoading = false;
        emit(NewAccidentAddedSuccessState());
      },
    );
  }

  // get images from url and convert it to base64

  Future<List<String>> getBase64ImageFromUrl(List<String> imagesUrl) async {
    List<String> base64Images = [];
    for (String imageUrl in imagesUrl) {
      final response = await dio.Dio().get(
        imageUrl,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );
      final bytes = response.data;
      debugPrint('image bytes: $bytes');

      PlatformFile file = PlatformFile(
        name: 'image',
        size: bytes.length,
        bytes: bytes,
        path: '',
      );
      final base64Image = base64Encode(file.bytes!);

      base64Images.add(base64Image);
    }
    return base64Images;
  }

  // commitmentStatus

  CommitmentStatus? commitmentStatus;
  TextEditingController commitmentStatusController = TextEditingController();
  TextEditingController notCommittedReasonController = TextEditingController();

  setCommitmentStatus({required CommitmentStatus status}) {
    commitmentStatus = status;
    emit(SetCommitmentState());
  }

  // update inspection

  bool updateInspectionLoading = false;

  void updateInspection({InspectionStatus? status}) async {
    updateInspectionLoading = true;
    emit(UpdateInspectionLoadingState());
    debugPrintFullText('insuranceCompanyId: $currentCompanyId');
    debugPrintFullText('inspectorId: ${inspectorModel?.id ?? 0}');

    debugPrintFullText('inspectionCompanyModel: ${inspectionCompanyModel?.id ?? 0}');
    debugPrintFullText('inspectionCompanyModel: ${inspectionCompanyModel?.toJson() ?? 0}');

    formData = dio.FormData.fromMap({
      if (selectedInspection!.partsList != null) 'partsList': selectedInspection!.partsList!.map((e) => e.toJson()).toList(),

      // 'updatedAt': DateTime.now(),
      'assignDate': assignDate != null && assignDate!.isNotEmpty ? assignDate.toString() : null,
      'inspectDate': inspectionDateController.text.isEmpty ? '' : inspectionDateController.text,
      'arrivedAt': arrivedAtController.text.isEmpty ? '' : arrivedAtController.text,
      'followDate': followDateController.text.isEmpty ? '' : followDateController.text,
      'notes': notesController.text.isEmpty ? '' : notesController.text,
      'damageDescription': damageDescController.text.isEmpty ? '' : damageDescController.text,
      'workerFeesBefore': beforeWorkFeesController.text.isEmpty ? '' : beforeWorkFeesController.text,
      'workerFeesAfter': afterWorkFeesController.text.isEmpty ? '' : afterWorkFeesController.text,

      'commitmentStatus': commitmentStatus?.val,
      'notCommittedReason': notCommittedReasonController.text,

      if (status != null) 'status': _getStatusName(status),

      if (selectedInspectorType == InspectorTypes.individual) 'inspectorId': inspectorModel?.id ?? 0,
      if (selectedInspectorType == InspectorTypes.company && userRoleName == Rules.Insurance.name)
        'inspectionCompanyId': inspectionCompanyModel?.id ?? 0,
      // if (userRoleName == Rules.InspectionManager.name) 'inspectionCompanyId': inspectionCompanyModel?.id ?? 0,
      if (userRoleName == Rules.InspectionManager.name) 'inspectionCompanyId': currentCompanyId,
      if (userRoleName == Rules.InspectionManager.name) 'insuranceCompanyId': selectedInsuranceCompany?.id ?? 0,
      if (userRoleName == Rules.Insurance.name) 'insuranceCompanyId': currentCompanyId,

      if (userRoleName == Rules.Insurance.name) 'insuranceCompanyId': currentCompanyId,

      // // TODO: u need to know what is the  inspectionCompanyModel
      // if (userRoleName == Rules.InspectionManager.name)
      //   // 'inspectionCompanyId': inspectionCompanyModel?.id ?? 0,
      //   'inspectionCompanyId': 10,
    });

    debugPrintFullText('formData: ${formData!.fields}');

    final result = await _repository.updateInspection(
      updateInspectionData: formData!,
      inspectionId: selectedInspection!.id!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        updateInspectionLoading = false;
        emit(
          UpdateInspectionErrorState(
            error: failure,
          ),
        );
      },
      (success) async {
        debugPrint('update inspection success');
        if (filesResult != null && filesResult!.files.isNotEmpty) {
          await uploadInsuranceImages(images: filesResult!.files, inspectionId: selectedInspection!.id!);
        }
        if (pdfFileResult != null && pdfFileResult!.files.isNotEmpty) {
          await uploadPdf(pdf: pdfFileResult!.files[0], inspectionId: selectedInspection!.id!);
        }
        if (attachmentFileResult != null && attachmentFileResult!.files.isNotEmpty) {
          await uploadAnyAttachmentFiles(files: filesResult?.files, inspectionId: selectedInspection!.id!);
        }
        if (userRoleName == Rules.Inspector.name) {
          getInspectionsAsInspector(status: InspectionsStatus.all.name);
        } else {
          getAllInspections(status: InspectionsStatus.all.name);
        }
        updateInspectionLoading = false;
        clearControllers();

        if (inspectorModel?.fcmtoken != null) {
          sendNotification(
            fcmtoken: inspectorModel?.fcmtoken ?? '',
            title: 'helpoo',
            body:
                'لديك تحديث علي المعاينة التي كلفت بها${InspectionType.values.firstWhereOrNull((element) => element.arName == inspectionTypeController.text)!.arName ?? ''}',
            isInspectionNotification: true,
            // type: 'service-request',
          );
        }

        emit(UpdateInspectionSuccessState());
      },
    );
  }

  String _getStatusName(InspectionStatus s) {
    switch (s) {
      case InspectionStatus.finished:
        return InspectionStatus.finished.name;
      case InspectionStatus.done:
        return InspectionStatus.done.name;
      case InspectionStatus.pending:
        return InspectionStatus.pending.name;
      case InspectionStatus.cancelled:
        return InspectionStatus.cancelled.name;
      default:
        return InspectionStatus.pending.name;
    }
  }

//******************************************************************************
  ///******************** Service Requests ******************************///
  //******************************************************************************
  bool getAllServiceRequestLoading = false;
  bool isFilterServiceRequest = false;
  GetAllServicesRequests? allServicesRequests;
  bool getServiceRequestsLoadingForPagination = false;

  void getAllServiceRequest({
    bool isFirstTime = false,
    bool isRefresh = false,
    required int pageNumber,
  }) async {
    if (isFirstTime) {
      getAllServiceRequestLoading = true;
      isFilterServiceRequest = false;
    } else {
      isFilterServiceRequest = true;
    }
    isSearchingServiceRequest = false;
    getServiceRequestsLoadingForPagination = true;
    emit(GetAllServiceRequestLoadingState(
      isRefreshServiceRequest: isRefresh,
    ));
    final result = await _repository.getAllServicesRequests(
      pageNumber: pageNumber,
      // size: 200,
      status: selectedServiceStatus != ServiceStatus.all ? selectedServiceStatus.value : null,
      serviceType: selectedServiceRequestType != null ? selectedServiceRequestType!.carType.toString() : null,
      clientType: selectedFilterClientType != Rules.none ? selectedFilterClientType.id.toString() : null,
      sortBy: selectedSortingBy,
      sortOrder: isDESCSotring ? 'DESC' : 'ASC',
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        getAllServiceRequestLoading = false;
        getServiceRequestsLoadingForPagination = false;

        emit(
          GetAllServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        debugPrint(':: get all ServiceRequest success *****************');
        debugPrint('ServiceRequest :: ${data.requests?.length ?? 0}');

        // debugPrint(
        //     'ServiceRequest Role Id:: ${data.requests![0].user?.roleId ?? 0}');
        allServicesRequests = data;
        getAllServiceRequestLoading = false;
        getServiceRequestsLoadingForPagination = false;

        currentAccidentReportsPage = pageNumber;

        if (requestCounter == 1 || isRefresh) {
          emit(
            GetAllServiceRequestSuccessState(
              isRefreshServiceRequest: isRefresh,
            ),
          );
          requestCounter = 0;
        } else {
          getServiceRequestsLoadingForPagination = false;
          emit(
            AccidentReportsSecondSuccess(),
          );
        }
      },
    );
  }

  //*********** getServiceRequestTypes
  bool getServiceRequestTypesLoading = false;
  List<ServiceRequestsType>? serviceRequestTypes = [];

  void getServiceRequestTypes() async {
    getServiceRequestTypesLoading = true;
    emit(GetServiceRequestTypesLoadingState());
    final result = await _repository.getServiceReqTypes();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        getServiceRequestTypesLoading = false;
        emit(
          GetServiceRequestTypesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        debugPrint(':: get all ServiceRequest Types success *****************');
        debugPrint('Service Request Types:: ${data.serviceRequestsTypes?.last.enName}');
        serviceRequestTypes = data.serviceRequestsTypes ?? [];
        getServiceRequestTypesLoading = false;
        emit(GetServiceRequestTypesSuccessState());
      },
    );
  }

  ////*********** add service request car

  ServiceRequestCustomerDataModel? serviceRequestCustomerDataModel;

  void addServiceRequestCar() async {
    emit(AddServiceRequestCarLoadingState());

    ServiceRequestCar car = ServiceRequestCar(
      plateNumber: isOldPlate
          ? policyCarPlateNumberController.text
          : '${policyCarPlateNumberController.text}-${policyCarFirstCharController.text}-${policyCarSecondCharController.text}-${policyCarThirdCharController.text}',
      year: policyYearOfManufactureController.text,
      // policyNumber: policyNumberController.text,
      // insuranceCompanyId: selectedInsuranceCompany.id,
      carModelId: selectedCarModel!.id,
      manufacturerId: selectedManufacturer!.id,
      color: selectedCarColor,
    );

    AddServiceRequestCarDto carData = AddServiceRequestCarDto(
      phoneNumber: handlePhoneNumber(phoneNum: policyPhoneController.text),
      name: policyFullNameController.text,
      email: policyEmailController.text,
      promoCode: promoCodeController.text,
      car: jsonEncode(car.toJson()),
    );

    final result = await _repository.addServiceRequestCar(car: carData);

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          AddServiceRequestCarErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        serviceRequestCustomerDataModel = data;
        debugPrint(':: add ServiceRequest Car success *****************');
        clearCreatePolicyData();
        emit(AddServiceRequestCarSuccessState());
      },
    );
  }

//******************************************************************************
  // handle selected government
  List<String> governments = [
    'القاهره الكبرى',
    'اكتوبر',
    'الشيخ زايد',
    'العاشر من رمضان',
    'بلبيس',
    'الشروق',
    'مدينتى',
    'بدر',
    'الروبيكي',
    'الحوامدية',
    'البدرشين',
    'اوسيم',
    'البراجيل',
    'منيل شيحة',
    'ابو النمرس',
    'برطس',
    'مايو15',
    'التبين',
    'حلوان',
    'القليوبيه',
    'بنى سويف',
    'المنيا',
    'أسيوط',
    'سوهاج',
    'قنا',
    'الاقصر',
    'أسوان',
    'شرم الشيخ',
    'الغردقه',
    'الاسكندريه',
    'الساحل الشمالى',
    'مرسى مطروح ',
    'الشرقيه - الزقازيق',
    'الدقهليه',
    'الغربيه',
    'كفر الشيخ - البحيره',
    'المنوفيه ',
    'بورسعيد - دمياط ',
    'الاسماعليه ',
    'السويس',
    'العين السخنه ',
    'الزعفرانه',
    'الفيوم',
  ];

  Map<String, List<String>> areas = {
    'القاهره الكبرى': [
      'القاهره',
      'الشيخ زايد',
      'الشروق',
      'مدينتى',
      'بدر',
      'مدينة نصر',
      'المعادى',
      'المقطم',
      'التجمع الخامس',
      'المهندسين',
      'الدقى',
      'العجوزة',
      'المرج',
      'المطرية',
      'الزيتون',
      'الساحل',
      'شبرا',
      'السلام',
    ],
    'القليوبيه': [
      'شبين القناطر',
      'نوه',
      'الجعافره',
      'طنان',
      'ميت نما',
      'قلما',
      'قها',
      'طوخ',
      'بنها',
    ],
    'الدقهليه': [
      'المنصوره',
      'ميت غمر',
      'السنبلاوين',
    ],
    'الغربيه': [
      'طنطا',
      'زفتى',
      'المحله',
      'كفر الدوار',
      'كفر الزيات',
    ],
  };

  String? _selectedGovernment;

  String? get selectedGovernment => _selectedGovernment;

  set selectedGovernment(String? value) {
    _selectedGovernment = value;
    governmentController.text = value!;
    areaController.clear();
    getareasByGovernment(value);
    emit(GovernmentChanged());
  }

  List<String> availableAreas = [];
  bool isSelectedGovernmentHasAreas = false;

  void getareasByGovernment(String government) {
    if (areas[government] != null) {
      availableAreas = areas[government]!;
      debugPrint('availableAreas: ${availableAreas.length}');
      isSelectedGovernmentHasAreas = true;
    } else {
      availableAreas = [];
      isSelectedGovernmentHasAreas = false;
    }

    emit(AreasByGovernmentChanged());
  }

  String? _selectedArea;

  String? get selectedArea => _selectedArea;

  set selectedArea(String? value) {
    _selectedArea = value;
    areaController.text = value!;
    emit(AreaChanged());
  }

//******************************************************************************
  int minHeightCompress = 3000;
  int minWidthCompress = 3000;
  int qualityCompress = 75;

  Future<File?> compressFiles({required File file}) async {
    debugPrint("original image size ::::: ${file.lengthSync()}");
    final originalBytes = await file.readAsBytes();
    var compressedBytes = await FlutterImageCompress.compressWithList(
      originalBytes,
      quality: qualityCompress,
      minHeight: minHeightCompress,
      minWidth: minWidthCompress,
    );
    if (!checkCompressedImageSize(compressed: compressedBytes)) {
      minHeightCompress -= 100;
      minWidthCompress -= 100;
      qualityCompress -= 5;

      var compressFile = await compressFiles(file: File(file.path)..writeAsBytesSync(compressedBytes));
      List<int> bytes = await compressFile!.readAsBytes();
      compressedBytes = Uint8List.fromList(bytes);
    }
    return File(file.path)..writeAsBytesSync(compressedBytes);
  }

  bool checkCompressedImageSize({
    required Uint8List compressed,
  }) {
    debugPrint("compressed image size ::::: ${compressed.lengthInBytes}");
    return compressed.lengthInBytes <= 1000000;
  }


  Map<String, String> imagesInstructions = {
    "img1": "رقم الشاسية",
    "img2": "عداد الكيلومتر",
    "img3": "الكبوت و الشبكة و الكشافات الأمامية",
    "img4": "الاكصدام الأمامي",
    "img5": "الزجاج الأمامي",
    "img6": "الزاوية الأمامية اليمنى",
    "img7": "الرفرف الأمامي الايمن و الجنط الأمامي الايمن",
    "img8": "الباب و الرفرف و الجنط الأمامي الايمن",
    "img9": "الباب و الرفرف و الجنط الخلفي الايمن",
    "img10": "الرفرف الخلفي الايمن و الجنط الخلفي الايمن",
    "img11": "الزاوية الخلفية اليمنى",
    "img12": "الشنطة و الكشافات الخلفية",
    "img13": "الاكصدام الخلفي",
    "img14": "الزجاج الخلفي",
    "img15": "الزاوية الخلفية اليسرى",
    "img16": "الرفرف الخلفي الايسر و الجنط الخلفي الايسر",
    "img17": "الباب و الرفرف و الجنط الخلفي الايسر",
    "img18": "الباب و الرفرف و الجنط الأمامي الايسر",
    "img19": "الرفرف الأمامي الايسر و الجنط الأمامي الايسر",
    "img20": "الزاوية الأمامية اليسرى",
    "img21": "سقف السيارة من الجانب الايسر",
    "img22": "سقف السيارة من الجانب الايمن",
    "img23": "حوض موتور السيارة",
    "img24": "شنطة السيارة من الداخل",
    "internal_img1": "الصالون الأمامي",
    "internal_img2": "الصالون الخلفي",
    "internal_img3": "عجلة القيادة",
    "internal_img4": "ناقل الحركة",
    "internal_img5": "حوض موتور السيارة",
    "internal_img6": "شنطة السيارة من الداخل",
    "id_img1": "صورة رخصة السائق الأمامية",
    "id_img2": "صورة رخصة السائق الخلفية",
    "id_img3": "صورة رخصة السيارة الأمامية",
    "id_img4": "صورة رخصة السيارة الخلفية",
    "id_img5": "صورة الرقم القومي الأمامية",
    "id_img6": "صورة الرقم القومي الخلفية",
    "glass_img1": "الزجاج الأمامي من الزاوية اليمنى",
    "glass_img2": "الزجاج الأمامي من الزاوية اليسرى",
    "glass_img3": "الزجاج الأمامي من زاوية مقعد السائق",
    "glass_img4": "الزجاج الأمامي من زاوية مقعد الراكب",
    'air_bag_images': 'صورة اكياس الهواء',
  };

//// choose vehicle

  ServiceRequestsType? _selectedVehicleServiceType;

  ServiceRequestsType? get selectedVehicleServiceType => _selectedVehicleServiceType;

  set setSelectedVehicleServiceType(ServiceRequestsType? value) {
    _selectedVehicleServiceType = value;
    emit(SetSelectedVehicleServiceTypeState());
  }

  bool? _isEuropeanVehicle;

  bool? get isEuropeanVehicle => _isEuropeanVehicle;

  set setIsEuropeanVehicle(bool? value) {
    _isEuropeanVehicle = value;
    if (isEuropeanVehicle != null && isEuropeanVehicle!) {
      setSelectedVehicleServiceType = serviceRequestTypes!.firstWhere((element) => element.id! == 5);
      // setSelectedVehicleServiceType = serviceRequestTypes!.where((element) => element.enName!.contains('Premium Car Towing')).first;
      // setSelectedVehicleServiceType = serviceRequestTypes!.where((element) => element.enName!.contains('Premium Car Towing')).first;
      debugPrint('setIsEuropeanVehicle: ${selectedVehicleServiceType!.id}');
    } else if (isEuropeanVehicle != null && !isEuropeanVehicle!) {
      setSelectedVehicleServiceType = serviceRequestTypes!.firstWhere((element) => element.id! == 4);
      // setSelectedVehicleServiceType = serviceRequestTypes!.where((element) => element.enName!.contains('Car Towing')).first;
      debugPrint('setIsEuropeanVehicle: ${selectedVehicleServiceType!.id}');
    }
    emit(SetIsEuropeanVehicleState());
  }

  // get driver based on selected service type

  ServiceRequestDriver? serviceRequestDriver;
  // ServiceRequestDriver? normalRequestDriver;
  // ServiceRequestDriver? euroRequestDriver;

  Future<void> getDriverBasedOnSelectedServiceType({int? id}) async {
    emit(GetDriverBasedOnSelectedServiceTypeLoadingState());
    DriverLocationModel location = DriverLocationModel(
      clientLatitude: originLatLng!.lat.toDouble(),
      clientLongitude: originLatLng!.lng.toDouble(),
    );

    debugPrint('location: ${jsonEncode(location.toJson())}');

    final result = await _repository.getServiceRequestDriver(
      carServiceId: "[${id ?? selectedVehicleServiceType!.id!}]",
      location: jsonEncode(location.toJson()),
    );

    result.fold(
      (failure) {
        printMeLog('getDriverBasedOnSelectedServiceType ERROR $failure');
        emit(GetDriverBasedOnSelectedServiceTypeErrorState(
          error: failure,
        ));
      },
      (data) {
        if (id != null) {
          // id == 4 ? normalRequestDriver = data : euroRequestDriver = data;
        } else {
          serviceRequestDriver = data;
          debugPrint('serviceRequestDriver: ${serviceRequestDriver!.driver!.id!}');
          getDriverPath(
            from: gMap.LatLng(serviceRequestDriver!.driver!.lat!, serviceRequestDriver!.driver!.lng),
            to: originLatLng!,
            isCreateNew: true,
          );
        }
        emit(GetDriverBasedOnSelectedServiceTypeSuccessState());
      },
    );
  }

  //******************************************************************************
  ///******************** Search Places ******************************///
  //******************************************************************************
  MapPlaceModel? mapPlaceModel;

  bool _isOrigin = true;

  bool get isOrigin => _isOrigin;

  set isOrigin(bool value) {
    _isOrigin = value;
    emit(ChangeIsOrigin());
  }

  // set origin address

  String _originAddress = '';

  String get originAddress => _originAddress;

  set originAddress(String value) {
    _originAddress = value;
    emit(ChangeOriginAddress());
  }

  // set destination address

  String _destinationAddress = '';

  String get destinationAddress => _destinationAddress;

  set destinationAddress(String value) {
    _destinationAddress = value;
    emit(ChangeDestinationAddress());
  }

  gMap.LatLng? _originLatLng;

  gMap.LatLng? get originLatLng => _originLatLng;

  set originLatLng(gMap.LatLng? value) {
    _originLatLng = value;
    emit(ChangeOriginLatLng());
  }

  gMap.LatLng? _destinationLatLng;

  gMap.LatLng? get destinationLatLng => _destinationLatLng;

  set destinationLatLng(gMap.LatLng? value) {
    _destinationLatLng = value;
    emit(ChangeDestinationLatLng());
  }

  gMap.LatLng? _driverLatLng;

  gMap.LatLng? get driverLatLng => _driverLatLng;

  set driverLatLng(gMap.LatLng? value) {
    _driverLatLng = value;
    emit(ChangeDriverLatLng());
  }

  gMap.LatLng? _cameraMovementPosition;

  gMap.LatLng? get cameraMovementPosition => _cameraMovementPosition;

  set cameraMovementPosition(gMap.LatLng? value) {
    _cameraMovementPosition = value;
    emit(CameraMovementPositionChanged());
  }

  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  void searchMapPlace({
    required String input,
  }) async {
    if (token.isNotEmpty) {
      emit(SearchMapPlaceLoading());

      final result = await _repository.searchPlace(
        input: input,
      );

      result.fold(
        (failure) {
          debugPrint(failure.toString());
          emit(
            SearchMapPlaceError(
              error: failure,
            ),
          );
        },
        (data) {
          mapPlaceModel = data;

          debugPrint("mapPlaceModel ::::: ${mapPlaceModel!.predictions.length}");

          emit(
            SearchMapPlaceSuccess(),
          );
        },
      );
    }
  }

  MapPlaceDetailsModel? mapPlaceDetailsModel;

  void getMapPlaceDetails({
    required MapPlaceDataModel value,
  }) async {
    if (token.isNotEmpty) {

      emit(GetMapPlaceDetailsLoading());

      final result = await _repository.getPlaceDetails(
        placeId: value.placeId,
      );

      result.fold(
        (failure) {
          debugPrint(failure.toString());
          emit(
            GetMapPlaceDetailsError(
              error: failure,
            ),
          );
        },
        (data) {
          mapPlaceDetailsModel = data;
          mapPlaceModel = null;
          if (isOrigin) {
            appBloc.originMarker = null;

            originController.clear();
            originController.text = mapPlaceDetailsModel!.result.address;
            originAddress = mapPlaceDetailsModel!.result.address;
            originLatLng = gMap.LatLng(
              mapPlaceDetailsModel!.result.latitude.toDouble(),
              mapPlaceDetailsModel!.result.longitude.toDouble(),
            );

            appBloc.originMarker = Marker(
              markerId: const MarkerId('origin'),
              position: LatLng(
                mapPlaceDetailsModel!.result.latitude.toDouble(),
                mapPlaceDetailsModel!.result.longitude.toDouble(),
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: mapPlaceDetailsModel!.result.address,
              ),
              draggable: true,
              onDragEnd: (LatLng position) {
               getPlaceByCoordinates(
                  lat: position.latitude,
                  lng: position.longitude,
                );
              },
            );
          } else {
            appBloc.destinationMarker = null;

            destinationController.clear();
            destinationController.text = mapPlaceDetailsModel!.result.address;

            destinationAddress = mapPlaceDetailsModel!.result.address;

            destinationLatLng = gMap.LatLng(
              mapPlaceDetailsModel!.result.latitude.toDouble(),
              mapPlaceDetailsModel!.result.longitude.toDouble(),
            );

            appBloc.destinationMarker = Marker(
              markerId: const MarkerId('destination'),
              position: LatLng(
                mapPlaceDetailsModel!.result.latitude.toDouble(),
                mapPlaceDetailsModel!.result.longitude.toDouble(),
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: mapPlaceDetailsModel!.result.address,
              ),
              draggable: true,
              onDragEnd: (LatLng position) {
                getPlaceByCoordinates(
                  lat: position.latitude,
                  lng: position.longitude,
                );
              },
            );
          }

          // zoom to the selected location
          originalMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  mapPlaceDetailsModel!.result.latitude.toDouble(),
                  mapPlaceDetailsModel!.result.longitude.toDouble(),
                ),
                zoom: 16.0,
              ),
            ),
          );
          emit(
            GetMapPlaceDetailsSuccess(),
          );
        },
      );
    }
  }

  MapPlaceDetailsCoordinatesModel? mapPlaceDetailsCoordinatesModel;

  void getPlaceByCoordinates({
    required double lat,
    required double lng,
  }) async {
    if (token.isNotEmpty) {

      emit(GetMapPlaceDetailsLoading());

      final result = await _repository.getPlaceDetailsByCoordinates(
        latLng: '$lat,$lng',
      );

      result.fold(
        (failure) {
          debugPrint(failure.toString());
          emit(
            GetMapPlaceDetailsError(
              error: failure,
            ),
          );
        },
        (data) {
          mapPlaceDetailsCoordinatesModel = data;

          mapPlaceModel = null;

          if (isOrigin) {
            appBloc.originMarker = null;

            originController.clear();
            originController.text = mapPlaceDetailsCoordinatesModel!.placeName;
            originAddress = mapPlaceDetailsCoordinatesModel!.placeName;
            originLatLng = gMap.LatLng(
              lat,
              lng,
            );

            appBloc.originMarker = Marker(
              markerId: const MarkerId('origin'),
              position: LatLng(
                lat,
                lng,
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: mapPlaceDetailsCoordinatesModel!.placeName,
              ),
              draggable: true,
              onDragEnd: (LatLng position) {
                getPlaceByCoordinates(
                  lat: position.latitude,
                  lng: position.longitude,
                );
              },
            );

            // zoom to the selected location
            originalMapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    lat,
                    lng,
                  ),
                  zoom: 16.0,
                ),
              ),
            );
          } else {
            appBloc.destinationMarker = null;

            destinationController.clear();
            destinationController.text = mapPlaceDetailsCoordinatesModel!.placeName;

            destinationAddress = mapPlaceDetailsCoordinatesModel!.placeName;

            destinationLatLng = gMap.LatLng(
              lat,
              lng,
            );

            appBloc.destinationMarker = Marker(
              markerId: const MarkerId('destination'),
              position: LatLng(
                lat,
                lng,
              ),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: mapPlaceDetailsCoordinatesModel!.placeName,
              ),
              draggable: true,
              onDragEnd: (LatLng position) {
                getPlaceByCoordinates(
                  lat: position.latitude,
                  lng: position.longitude,
                );
              },
            );

            // zoom to the selected location
            originalMapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    lat,
                    lng,
                  ),
                  zoom: 16.0,
                ),
              ),
            );
          }
          emit(
            GetMapPlaceDetailsSuccess(),
          );
        },
      );
    }
  }

  //******************************************************************************
  ///******************** drow path ******************************///
  ///******************************************************************************
  ///

  bool _isGettingPathLoading = false;

  bool get isGettingPathLoading => _isGettingPathLoading;

  set isGettingPathLoading(bool value) {
    _isGettingPathLoading = value;
    emit(IsGettingPathLoading());
  }

  List<LatLng> polylineCoordinates = [];
  List<LatLng> driverPolylineCoordinates = [];

  PolylineResult? mainTripPolylineResult;

  void getMainTripPath({
    bool isCalltoDrawPath = false,
  }) async {
    emit(GetMainTripPathLoadingState());

    GetRequestDurationAndDistanceDTO getRequestDurationAndDistanceDto = GetRequestDurationAndDistanceDTO(
      driverLatLng: LatLng(originLatLng!.lat.toDouble(), originLatLng!.lng.toDouble()),
      curClientLocation: LatLng(destinationLatLng!.lat.toDouble(), destinationLatLng!.lng.toDouble()),
    );
    final result = await _repository.getRequestTimeAndDistance(getRequestDurationAndDistanceDto: getRequestDurationAndDistanceDto);
    result.fold((failure) {
      debugPrint(failure);
      emit(GetRequestTimeAndDistanceByIdErrorState(error: failure));
      return null;
    }, (data) {
      getDistanceAndDurationResponse = data.distanceAndDuration!;
      drawCreateRequestRoute();

      emit(GetRequestTimeAndDistanceByIdSuccessState());
      return data;
    });
  }

  drawCreateRequestRoute() {
    addOriginIcon(
      id: 'car',
      latitude: getDistanceAndDurationResponse!.points![0].latitude,
      longitude: getDistanceAndDurationResponse!.points![0].longitude,
      status: serviceRequestListModel != null
          ? ServiceRequestStatus.values.firstWhereOrNull((element) => element.name == serviceRequestListModel?.serviceRequestDetails.status) ??
              ServiceRequestStatus.confirmed
          : ServiceRequestStatus.confirmed,
    );

    addDistinationIcon(
      id: 'winch',
      latitude: getDistanceAndDurationResponse!.points!.last.latitude,
      longitude: getDistanceAndDurationResponse!.points!.last.longitude,
      status: serviceRequestListModel != null
          ? ServiceRequestStatus.values.firstWhereOrNull((element) => element.name == serviceRequestListModel?.serviceRequestDetails.status) ??
              ServiceRequestStatus.confirmed
          : ServiceRequestStatus.confirmed,
    );
    emit(GetMainTripPathSuccessState());
  }

  void drawPath({
    required String encodedPoints,
    bool isForDriver = false,
  }) async {
    emit(DrawPathLoadingState());
    final result = await _repository.getDecodedPoints(encodedPoints: encodedPoints);

    result.fold(
      (failure) {
        debugPrint(failure.toString());
        emit(DrawPathErrorState(error: failure.toString()));
      },
      (data) {
        polylineCoordinates = [];

        for (var point in data.encodedString) {
          polylineCoordinates.add(LatLng(point[0], point[1]));
        }

        addOriginIcon(
          id: 'car',
          latitude: polylineCoordinates[0].latitude,
          longitude: polylineCoordinates[0].longitude,
          status: serviceRequestListModel != null
              ? ServiceRequestStatus.values.firstWhereOrNull((element) => element.name == serviceRequestListModel?.serviceRequestDetails.status) ??
                  ServiceRequestStatus.confirmed
              : ServiceRequestStatus.confirmed,
        );

        addDistinationIcon(
          id: 'winch',
          latitude: polylineCoordinates.last.latitude,
          longitude: polylineCoordinates.last.longitude,
          status: serviceRequestListModel != null
              ? ServiceRequestStatus.values.firstWhereOrNull((element) => element.name == serviceRequestListModel?.serviceRequestDetails.status) ??
                  ServiceRequestStatus.confirmed
              : ServiceRequestStatus.confirmed,
        );
        emit(DrawPathSuccessState());
      },
    );
  }

  CalculateFeesModel? calculateFeesModel;
  CalculateFeesModel? calculateSecondTimeModel;

  Future<void> calculateServiceFees({required bool isSecondTime}) async {
    emit(CalculateServiceFeesLoadingState());
    if (isNewCustomer) {
      debugPrint('new customer id : ${serviceRequestCustomerDataModel!.user!.id!.toString()}');
      debugPrint(serviceRequestCustomerDataModel!.car!.id!.toString());
    } else {
      debugPrint(customerSearchModel!.client!.id!.toString());
      debugPrint(selectedUserCar!.id!.toString());
    }

    // get distance without Km or M

    String distance = getDistanceAndDurationResponse!.driverDistanceMatrix!.distance!.value.toString();
    // String distance = mainTripPolylineResult!.distance.split(' ').first;

    debugPrint('distance ::::: $distance');
    final result = await _repository.calculateServiceFees(
      userId: isNewCustomer
          ? serviceRequestCustomerDataModel!.car!.clientId != 0
              ? serviceRequestCustomerDataModel!.car!.clientId!
              : serviceRequestCustomerDataModel!.user!.id!
          : customerSearchModel!.client!.id!,
      carId: isNewCustomer ? serviceRequestCustomerDataModel!.car!.id! : selectedUserCar!.id!,
      destinationDistance: json.encode({
        'distance': {
          'value': distance,
          // 'value': (num.parse(distance) * 1000).toString(),
        }
      }),
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        emit(
          CalculateServiceFeesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        if (isSecondTime) {
          calculateSecondTimeModel = data;
        } else {
          calculateFeesModel = data;
          isGettingPathLoading = false;
        }
        emit(CalculateServiceFeesSuccessState(isSecondTime: isSecondTime));
      },
    );
  }

  gMap.GMap? driversMap;

  gMap.GMap? map;

  gMap.LatLng? _origin;

  gMap.LatLng? get origin => _origin;

  set origin(gMap.LatLng? value) {
    _origin = value;
    emit(ChangeOrigin());
  }

  gMap.LatLng? _destination;

  gMap.LatLng? get destination => _destination;

  set destination(gMap.LatLng? value) {
    _destination = value;
    emit(ChangeDestination());
  }

  Marker? originMarker;

  Marker? destinationMarker;
  String returnStringAsHoursOrMinutes() {
    String s = '';

    if (driverPolylineResult != null) {
      if ((driverPolylineResult?.durationMinutesValue ?? 0) >= 60) {
        s = '${(driverPolylineResult?.durationMinutesValue ?? 0) ~/ 60} ${'hours'}';
      }
    } else {
      // if(firstPolylineResult != null && secondPolylineResult != null && thirdPolylineResult != null)
      if (true) {
        if (((firstPolylineResult?.durationMinutesValue ?? 0) +
                (secondPolylineResult?.durationMinutesValue ?? 0) +
                (thirdPolylineResult?.durationMinutesValue ?? 0) +
                (configModel?.carryingTime ?? 0) +
                (configModel?.finishTime ?? 0)) >=
            60) {
          s = '${((firstPolylineResult?.durationMinutesValue ?? 0) + (secondPolylineResult?.durationMinutesValue ?? 0) + (thirdPolylineResult?.durationMinutesValue ?? 0) + (configModel?.finishTime ?? 0) + (configModel?.finishTime ?? 0)) ~/ 60} ${'hours'}';
        }
      }
    }

    if (driverPolylineResult != null) {
      if ((driverPolylineResult?.durationMinutesValue ?? 0) % 60 > 0) {
        s += ' ${(driverPolylineResult?.durationMinutesValue ?? 0) % 60} ${'minute'}';
      }
    } else {
      // if(firstPolylineResult != null && secondPolylineResult != null && thirdPolylineResult != null)
      if (true) {
        if (((firstPolylineResult?.durationMinutesValue ?? 0) +
                    (secondPolylineResult?.durationMinutesValue ?? 0) +
                    (thirdPolylineResult?.durationMinutesValue ?? 0) +
                    (configModel?.finishTime ?? 0) +
                    (configModel?.carryingTime ?? 0)) %
                60 >
            0) {
          s +=
              ' ${((firstPolylineResult?.durationMinutesValue ?? 0) + (secondPolylineResult?.durationMinutesValue ?? 0) + (thirdPolylineResult?.durationMinutesValue ?? 0) + (configModel?.finishTime ?? 0) + (configModel?.carryingTime ?? 0)) % 60} ${'minute'}';
        }
      }
    }

    return s;
  }

  String returnStringAsKmOrMeters() {
    String s = '';

    if (driverPolylineResult != null) {
      s = '${((driverPolylineResult?.distanceMeterValue ?? 0) / 1000).toStringAsFixed(2)} ${'km'}';
    } else {
      // if(firstPolylineResult != null && secondPolylineResult!= null && thirdPolylineResult != null)
      if (true) {
        s = '${(((firstPolylineResult?.distanceMeterValue ?? 0) + (secondPolylineResult?.distanceMeterValue ?? 0) + (thirdPolylineResult?.distanceMeterValue ?? 0)) / 1000).toStringAsFixed(2)} ${'km'}';
      }
    }
    return s;
  }

  bool isGetAllAvailableDriversLoading = false;
  List<AvailableDrivers> availableDrivers = [];

  void getAllAvailableDrivers({
    required List<int> carServiceTypes,
  }) async {
    isGetAllAvailableDriversLoading = true;

    emit(GetAllAvailableDriversLoading());

    final result = await _repository.getAvailableDrivers(carServiceTypes: carServiceTypes);

    result.fold(
      (failure) {
        debugPrint(failure.toString());
        emit(
          GetAllAvailableDriversError(
            error: failure,
          ),
        );
      },
      (data) async {
        availableDrivers = [];
        availableDrivers = data.drivers!;
        for (var element in availableDrivers) {
        }
        debugPrint('availableDrivers');
        debugPrint(availableDrivers.length.toString());

        emit(
          GetAllAvailableDriversSuccess(),
        );
      },
    );
  }

  DriversModel? driversModel;

  void getAllDriversMap() async {
    if (token.isNotEmpty) {
      emit(GetAllDriversMapLoading());

      final result = await _repository.getAllDriversMap();

      result.fold(
        (failure) {
          debugPrint(failure.toString());
          emit(
            GetAllDriversMapError(
              error: failure,
            ),
          );
        },
        (data) async {
          driversModel = data;
          debugPrint('driversModel');
          debugPrint(driversModel!.drivers.length.toString());

          for (var element in driversModel!.drivers) {
            if (element.latitude != 0) {
              final icon = gMap.Icon()
                ..scaledSize = gMap.Size(100, 40)
                // ..url = "assets/images/tow_truck.png";
                ..url = "http://i.epvpimg.com/MMdFbab.png";

              gMap.Marker(
                gMap.MarkerOptions()
                  ..anchorPoint = gMap.Point(0.5, 0.5)
                  ..icon = icon
                  ..position = gMap.LatLng(element.latitude, element.latitude)
                  ..map = driversMap
                  ..draggable = false
                  ..title = element.id.toString(),
              );
            }
          }

          emit(
            GetAllDriversMapSuccess(),
          );
        },
      );
    }
  }

  Future<PolylineResult> getChangeDriverData({
    required gMap.LatLng from,
    required gMap.LatLng to,
  }) async {
    return await PolylinePoints().getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(from.lat.toDouble(), from.lng.toDouble()),
      PointLatLng(to.lat.toDouble(), to.lng.toDouble()),
      travelMode: TravelMode.driving,
    );
  }

  num currentDuration = 0.0;

  int intervalTimeInMinutes = 2;

  PolylineResult? driverPolylineResult;

  void getDriverPath({
    required gMap.LatLng from,
    required gMap.LatLng to,
    bool isForDriver = true,
    bool isCreateNew = false,
  }) async {
    debugPrint('getDriverPath');
    debugPrint('driverModel=> ${from.lat.toDouble()}');
    debugPrint('driverModel=> ${from.lng.toDouble()}');

    PolylinePoints polylinePoints = PolylinePoints();

    polylinePoints
        .getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(from.lat.toDouble(), from.lng.toDouble()),
      PointLatLng(to.lat.toDouble(), to.lng.toDouble()),
      travelMode: TravelMode.driving,
    )
        .then((value) {
      logGoogleMapsApi(
        requestId: serviceRequestListModel?.serviceRequestDetails.id ?? 0,
        endpoint: 'https://maps.googleapis.com/maps/api/directions/json',
        from: userRoleName == Rules.Corporate.name ? 'dashboard_corporate' : 'dashboard_call_center',
      );

      driverPolylineResult = value;

      currentDuration = driverPolylineResult!.durationMinutesValue;

      if (intervalDurationTimer != null) {
        if (intervalDurationTimer!.isActive) {
          intervalDurationTimer!.cancel();
        }
      }

      intervalDurationTimer = null;

      intervalDurationTimer = Timer.periodic(
        const Duration(minutes: 1),
        (timer) {
          if (driverPolylineResult != null) {
            int min = int.parse(driverPolylineResult!.duration.split(' ').first);
            String minutes = driverPolylineResult!.duration.split(' ').last;

            min--;

            driverPolylineResult!.duration = '$min $minutes';

            emit(EmptyStateToRebuild());
          }
        },
      );

      intervalTimeInMinutes = calculateIntervalTime(
        duration: currentDuration,
      );

      debugPrint('currentDuration=> $currentDuration');
      debugPrint('value.distance=> ${value.distance}');
      debugPrint('value.duration=> ${value.duration}');
      debugPrint('value.durationInTraffic=> ${value.duration_in_traffic}');

      drawPath(
        encodedPoints: driverPolylineResult!.pointsString,
        isForDriver: isForDriver,
      );

      emit(GetDriverPathToDrawSuccess(
        isCreateNew: isCreateNew,
      ));
    }).catchError((error) {
      debugPrint('============== error =============');
      debugPrint(error.toString());

      emit(GetDriverPathToDrawError(error: error.toString()));
    });
  }

  PolylineResult? firstPolylineResult;
  PolylineResult? secondPolylineResult;
  PolylineResult? thirdPolylineResult;

  void getSpecificPath({
    required gMap.LatLng from,
    required gMap.LatLng to,
    required String pathId,
  }) async {
    driverPolylineResult = null;
    firstPolylineResult = null;
    secondPolylineResult = null;
    thirdPolylineResult = null;

    PolylinePoints polylinePoints = PolylinePoints();

    polylinePoints
        .getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(from.lat.toDouble(), from.lng.toDouble()),
      PointLatLng(to.lat.toDouble(), to.lng.toDouble()),
      travelMode: TravelMode.driving,
    )
        .then((value) async {
      logGoogleMapsApi(
        requestId: serviceRequestListModel?.serviceRequestDetails.id ?? 0,
        endpoint: 'https://maps.googleapis.com/maps/api/directions/json',
        from: userRoleName == Rules.Corporate.name ? 'dashboard_corporate' : 'dashboard_call_center',
      );

      if (pathId == 'firstReq') {
        firstPolylineResult = value;
      } else if (pathId == 'secondReq') {
        secondPolylineResult = value;
      } else if (pathId == 'thirdReq') {
        thirdPolylineResult = value;
      }
      PolylineId id = PolylineId(pathId);

      final response = await _repository.getDecodedPoints(encodedPoints: value.pointsString);

      response.fold((l) {}, (data) {
        List<LatLng> polylineCoordinates = [];
      });

      if (pathId == 'secondReq') {
        addOriginIcon(
          id: 'winch',
          latitude: serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
          longitude: serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
          status: serviceRequestListModel != null
              ? ServiceRequestStatus.values.firstWhereOrNull((element) => element.name == serviceRequestListModel?.serviceRequestDetails.status) ??
                  ServiceRequestStatus.confirmed
              : ServiceRequestStatus.confirmed,
        );

        addDistinationIcon(
          id: 'car',
          latitude: serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
          longitude: serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
          status: serviceRequestListModel != null
              ? ServiceRequestStatus.values.firstWhereOrNull((element) => element.name == serviceRequestListModel?.serviceRequestDetails.status) ??
                  ServiceRequestStatus.confirmed
              : ServiceRequestStatus.confirmed,
        );

        // animateCameraToShowPath(
        //   from: LatLng(
        //     serviceRequestModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
        //     serviceRequestModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
        //   ),
        //   to: originLatLng!,
        //   isDriverPath: true,
        //   isLastTripPath: false,
        //   heading: double.parse(serviceRequestModel!.serviceRequestDetails.driverRequestDetailsModel!.heading),
        // );
      }

      emit(GetDriverPathToDrawSuccess(
        isCreateNew: false,
      ));
    }).catchError((error) {
      debugPrint('============== error =============');
      debugPrint(error.toString());

      emit(GetDriverPathToDrawError(error: error.toString()));
    });
  }

  int calculateIntervalTime({
    required num duration,
  }) {
    num intervalTime = duration / 10;

    if (intervalTime <= 2) {
      return 2;
    }

    return intervalTime.toInt();
  }

  ///************************** Create New Service Req ***************************
  ServiceRequestDataModel? serviceRequestModel;
  ServiceRequestDataListModel? serviceRequestListModel;

  bool isCreateNewRequestLoading = false;

  void createNewRequest({
    bool isForCorporate = false,
  }) async {
    // isCreateNewRequestLoading = true;

    emit(CreateNewRequestLoadingState());

    // select driver
    ServiceRequestDriver? selectedDriver;
    // printWarning('------ First One ==>> ${normalRequestDriver?.distance?.toJson()}');
    printWarning('------ Last One ==>> ${serviceRequestDriver?.distance?.toJson()}');
    printWarning('Selected Driver is First One [Normal]');

    printWarning('------ xxxxxxxx 0 ==>> ${selectedVehicleServiceType!.carType}');

    printWarning('------ Selected ==>> ${selectedDriver?.distance?.toJson()}');
    debugPrint('createdByUser : $currentUserId');
    debugPrint('generalID : $generalID');
    newFees = 0;

    CreateServiceDto createServiceDto = CreateServiceDto(
      carId: isNewCustomer ? serviceRequestCustomerDataModel!.car!.id!.toString() : selectedUserCar!.id!.toString(),
      clientId: isNewCustomer
          ? serviceRequestCustomerDataModel!.car!.clientId != 0
              ? serviceRequestCustomerDataModel!.car!.clientId!.toString()
              : serviceRequestCustomerDataModel!.user!.id!.toString()
          : customerSearchModel!.client!.id!.toString(),
      corporateId: isForCorporate
          ? ''
          : userRoleName == Rules.Corporate.name
              ? generalID.toString()
              : '',
      corporateCompany: isForCorporate ? selectedCorporateId.toString() : '',
      createdByUser: isForCorporate
          ? selectedCorporateId.toString()
          : currentUserId != 0
              ? currentUserId.toString()
              : generalID.toString(),
      // driverId: selectedDriver!.driver!.id!.toString(),
      driverId: serviceRequestDriver!.driver!.id!.toString(),
      carServiceTypeId: json.encode([selectedVehicleServiceType!.carType.toString()]),
      distance: json.encode(serviceRequestDriver!.distance),
      destinationDistance: json.encode({
        "distance": {
          "value": getDistanceAndDurationResponse!.driverDistanceMatrix!.distance!.value,
          // "value": double.parse(mainTripPolylineResult!.distance.split(' ').first) * 1000,
        },
        "duration": {"value": getDistanceAndDurationResponse!.driverDistanceMatrix!.duration!.value},
        "points": getDistanceAndDurationResponse!.points,
      }),
      destinationAddress: destinationAddress,
      clientAddress: originAddress,
      clientLatitude: originLatLng!.lat.toString(),
      clientLongitude: originLatLng!.lng.toString(),
      destinationLat: destinationLatLng!.lat.toString(),
      destinationLng: destinationLatLng!.lng.toString(),
      paymentMethod: handlePaymentMethodAPINames(name: selectedPaymentMethod!),
      paymentStatus: selectedPaymentMethod == ServicePaymentMethods.onlineCard.name ? 'not-paid' : 'pending',
      branchId: selectedCorpBranch?.id?.toString(),
    );

    debugPrint('createServiceDto : ${createServiceDto.toString()}');

    final result = await _repository.createNewServiceRequest(createServiceDto: createServiceDto);

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCreateNewRequestLoading = false;

        // isTowingSelectingLoading = false;

        emit(
          CreateNewRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        serviceRequestListModel = data;

        isCreateNewRequestLoading = false;

        assignDriverToServiceRequest(
          serviceRequestId: serviceRequestListModel!.serviceRequestDetails.id.toString(),
        );
        if (calculateFeesModel != null) {
          if (serviceRequestListModel?.serviceRequestDetails.CarServiceTypes?.first.car_type == 4) {
            if (isSecondNumIfGreaterThan25FromFirstOne(calculateFeesModel!.normalFees, serviceRequestListModel!.serviceRequestDetails.fees)) {
              newFees = serviceRequestListModel!.serviceRequestDetails.fees;
            }
          } else if (serviceRequestListModel?.serviceRequestDetails.CarServiceTypes?.first.car_type == 5) {
            if (isSecondNumIfGreaterThan25FromFirstOne(calculateFeesModel!.euroFees, serviceRequestListModel!.serviceRequestDetails.fees)) {
              newFees = serviceRequestListModel!.serviceRequestDetails.fees;
            }
          }
        }
        printWarning('NEW FEES LOCAL : $newFees');
        emit(CreateNewRequestSuccessState());

        getPaymentMethodsList();
      },
    );
  }

  num _newFees = 0;

  num get newFees => _newFees;

  set newFees(num value) {
    _newFees = value;
    emit(NewFeesChangedState());
  }

  bool isSecondNumIfGreaterThan25FromFirstOne(num first, num second) {
    printWarning('First Fees ----------: $first');
    printWarning('Second Fees ---------: $second');
    if ((second - first) > (first * 0.25)) {
      return true;
    } else {
      return false;
    }
  }

  ///*****************************************************************************
// search in map

  ///************************************* view service request ****************************************///

  int? _selectedServiceRequestId;

  int? get selectedServiceRequestId => _selectedServiceRequestId;

  void setSelectedServiceRequestId({
    int? id,
    required bool isForActiveService,
  }) {
    _selectedServiceRequestId = id;
    debugPrint('-----selectedServiceRequestId------ $_selectedServiceRequestId');
    if (isForActiveService) {
      getCurrentActiveServiceRequest();
    }
    emit(SelectedServiceRequestChangedState());
  }

  ServiceRequestModel? _selectedServiceRequestModel;

  ServiceRequestModel? get selectedServiceRequestModel => _selectedServiceRequestModel;

  void setSelectedServiceRequestModel({
    ServiceRequestModel? model,
    bool isForActiveService = false,
  }) {
    _selectedServiceRequestModel = model;
    if (isForActiveService) {
      emit(SelectedServiceRequestModelForActiveChangedState());
    }
    emit(SelectedServiceRequestModelChangedState());
  }

  bool isGetOneServiceReqLoading = false;

  bool isGetReqByIdLoading = false;
  // ServiceRequestModel? clickedReq;
  GetOneServiceRequestModel? clickedReqModel;

  Future<void> getRequestById({
    required int reqId,
  }) async {
    isGetReqByIdLoading = true;
    emit(GetRequestByIdLoadingState());

    final result = await _repository.getRequestById(
      serviceRequestId: selectedServiceRequestId!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetReqByIdLoading = false;
        emit(GetRequestByIdErrorState(failure));
      },
      (data) async {
        debugPrint('-----data------');
        clickedReqModel = data;
        isGetReqByIdLoading = false;
        emit(GetRequestByIdSuccessState());
      },
    );
  }

  void getCurrentActiveServiceRequest({
    bool isRefresh = false,
  }) async {
    isGetOneServiceReqLoading = true;
    emit(GetCurrentActiveServiceRequestLoadingState(
      isRefresh: isRefresh,
    ));

    final result = await _repository.getOneServiceRequest(
      serviceRequestId: selectedServiceRequestId!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetOneServiceReqLoading = false;
        emit(
          GetCurrentActiveServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) async {
        debugPrint('-----data------');
        serviceRequestListModel = data;

        debugPrint('%%%%%%%%%% ${serviceRequestListModel!.serviceRequestDetails.status}');

        // selectedServiceRequestId =
        //     serviceRequestListModel!.serviceRequestDetails.id;
        debugPrint('-----serviceRequestListModel------');
        debugPrint(serviceRequestListModel!.serviceRequestDetails.status);

        originController.text = serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientAddress;

        destinationController.text = serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationAddress;

        if (serviceRequestListModel!.serviceRequestDetails.status == ServiceRequestStatus.confirmed.name ||
            serviceRequestListModel!.serviceRequestDetails.status == ServiceRequestStatus.accepted.name ||
            serviceRequestListModel!.serviceRequestDetails.status == ServiceRequestStatus.arrived.name) {
          debugPrint('-----serviceRequestListModel------');

          if (serviceRequestListModel!.serviceRequestDetails.status != ServiceRequestStatus.arrived.name) {
            // todo draw new path
            if (serviceRequestListModel!.locationPrevRequestModel != null) {
              if (serviceRequestListModel!.oldRequestStatus != null) {
                if (serviceRequestListModel!.oldRequestStatus == ServiceRequestStatus.accepted.name ||
                    serviceRequestListModel!.oldRequestStatus == ServiceRequestStatus.arrived.name ||
                    serviceRequestListModel!.oldRequestStatus == ServiceRequestStatus.started.name) {
                  // from driver to first req origin
                  if (serviceRequestListModel!.oldRequestStatus == ServiceRequestStatus.started.name) {
                    configModel?.carryingTime = 0;
                  }

                  if (serviceRequestListModel!.firstClientLocation != null) {
                    getSpecificPath(
                      from: gMap.LatLng(
                        serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
                        serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
                      ),
                      to: gMap.LatLng(
                        serviceRequestListModel!.firstClientLocation?.latitude.toDouble() ?? 0.0,
                        serviceRequestListModel!.firstClientLocation?.longitude.toDouble() ?? 0.0,
                      ),
                      pathId: 'thirdReq',
                    );
                  } else {
                    thirdPolylineResult = null;
                  }

                  // from driver to first req destination
                  getSpecificPath(
                    from: gMap.LatLng(
                      serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
                      serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
                    ),
                    to: gMap.LatLng(
                      serviceRequestListModel!.locationPrevRequestModel?.latitude.toDouble() ?? 0.0,
                      serviceRequestListModel!.locationPrevRequestModel?.longitude.toDouble() ?? 0.0,
                    ),
                    pathId: 'firstReq',
                  );

                  // from first req destination to second req destination
                  getSpecificPath(
                    from: gMap.LatLng(
                      serviceRequestListModel!.locationPrevRequestModel?.latitude.toDouble() ?? 0.0,
                      serviceRequestListModel!.locationPrevRequestModel?.longitude.toDouble() ?? 0.0,
                    ),
                    to: gMap.LatLng(
                      serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
                      serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
                    ),
                    pathId: 'secondReq',
                  );
                } else {
                  getDriverPath(
                    from: gMap.LatLng(
                      serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
                      serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
                    ),
                    to: gMap.LatLng(
                      serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
                      serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
                    ),
                  );
                }
              } else {
                getDriverPath(
                  from: gMap.LatLng(
                    serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
                    serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
                  ),
                  to: gMap.LatLng(
                    serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
                    serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
                  ),
                );
              }
            } else {
              getDriverPath(
                from: gMap.LatLng(
                  serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
                  serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
                ),
                to: gMap.LatLng(
                  serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
                  serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
                ),
              );
            }
          } else {
            getDriverPath(
              from: gMap.LatLng(
                serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
                serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
              ),
              to: gMap.LatLng(
                serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
                serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
              ),
            );
          }
        } else if (serviceRequestListModel!.serviceRequestDetails.status == ServiceRequestStatus.started.name) {
          getDriverPath(
            from: gMap.LatLng(
              serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.latitude.toDouble(),
              serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel!.longitude.toDouble(),
            ),
            to: gMap.LatLng(
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationLatitude.toDouble(),
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationLongitude.toDouble(),
            ),
          );
        } else if (serviceRequestListModel!.serviceRequestDetails.status == ServiceRequestStatus.canceled.name ||
            serviceRequestListModel!.serviceRequestDetails.status == ServiceRequestStatus.cancelWithPayment.name) {
          debugPrint('----- Draw canceled trip path ------');
          getDriverPath(
            isForDriver: false,
            from: gMap.LatLng(
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
            ),
            to: gMap.LatLng(
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationLatitude.toDouble(),
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationLongitude.toDouble(),
            ),
          );
        } else {
          getDriverPath(
            from: gMap.LatLng(
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLatitude.toDouble(),
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.clientLongitude.toDouble(),
            ),
            to: gMap.LatLng(
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationLatitude.toDouble(),
              serviceRequestListModel!.serviceRequestDetails.locationRequestDetailsModel!.destinationLongitude.toDouble(),
            ),
          );
        }

        heading = double.parse(serviceRequestListModel!.serviceRequestDetails.driverRequestDetailsModel?.heading ?? '0');

        isGetOneServiceReqLoading = false;
        emit(GetCurrentActiveServiceRequestSuccessState(
          isThereActiveServiceRequest: true,
          isRefresh: isRefresh,
        ));
      },
    );
  }

  Timer? intervalDurationTimer;

  void getCurrentServiceRequestStatus() {
    emit(
      GetCurrentServiceRequestStatusState(
        serviceRequestStatus: ServiceRequestStatus.values.firstWhere((element) => element.name == serviceRequestModel!.serviceRequestDetails.status),
      ),
    );
  }

  void drawPolyline(List<gMap.LatLng> points) {
    final polyline = gMap.Polyline(
      gMap.PolylineOptions()
        ..path = points
        ..strokeColor = "#085E25"
        ..strokeOpacity = 1.0
        ..strokeWeight = 6
        ..geodesic = true,
    );

    polyline.map = map;

    gMap.LatLngBounds bounds = gMap.LatLngBounds();

    for (var point in points) {
      bounds.extend(point);
    }

    if (map != null) {
      map!.fitBounds(bounds);

      map!.panToBounds(bounds);
    } else {
      debugPrint('map is null');
    }

  }

  ///************************************ handle payment list *****************************/
  ///
  ///

  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController corpBranchController = TextEditingController();

  String? _selectedPaymentMethod;

  String? get selectedPaymentMethod => _selectedPaymentMethod;

  set selectedPaymentMethod(String? value) {
    _selectedPaymentMethod = value;
    paymentMethodController.text = handlePaymentMethodNames(name: value!);
    // updateServiceRequest(
    //   isUpdatePayment: true,
    // );
    emit(SelectedPaymentMethodSuccess());
  }

  set selectedPaymentMethodFrompopup(String? value) {
    _selectedPaymentMethod = value;
    paymentMethodController.text = handlePaymentMethodNames(name: value!);
    emit(SelectedPaymentMethodSuccess());
  }

  List<String> paymentMethodsList = [];

  void getPaymentMethodsList() {
    paymentMethodsList.clear();
    for (int i = 0; i < availablePayments.keys.length; i++) {
      if (availablePayments.values.elementAt(i) == true) {
        paymentMethodsList.add(availablePayments.keys.elementAt(i));
      }
    }
    debugPrint('paymentMethodsList=> $paymentMethodsList');
    emit(GetPaymentMethodsListSuccess());
  }

  String handlePaymentMethodNames({required String name}) {
    switch (name) {
      case 'cash':
        return 'Cash';
      case 'cardToDriver':
        return 'Card to Driver';
      case 'online':
        return 'Online';
      case 'deferredPayment':
        return 'Deferred Payment';
      case 'online-link':
        return 'Online Link';
      default:
        return '';
    }
  }

  String handlePaymentMethodAPINames({required String name}) {
    switch (name) {
      case 'cash':
        return 'cash';
      case 'cardToDriver':
        return 'card-to-driver';
      case 'online':
        return 'Online';
      case 'deferredPayment':
        return 'deferred';
      case 'online-link':
        return 'online-link';
      default:
        return '';
    }
  }

  bool isUpdateServiceRequestLoading = false;

  void updateServiceRequest({
    bool isUpdatePayment = true,
  }) async {
    isUpdateServiceRequestLoading = true;

    emit(UpdateServiceRequestLoadingState());

    final result = await _repository.updateOneServiceRequest(
      serviceRequestId: isUpdatePayment ? serviceRequestListModel!.serviceRequestDetails.id : selectedServiceRequestId!,
      status: isUpdatePayment ? 'confirmed' : selectedServiceRequestStatus?.name ?? 'confirmed',
      paymentMethod: isUpdatePayment ? handlePaymentMethodAPINames(name: selectedPaymentMethod!) : null,
      paymentStatus: isUpdatePayment
          ? selectedPaymentMethod == ServicePaymentMethods.onlineCard.name
              ? 'not-paid'
              : 'pending'
          : null,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        isUpdateServiceRequestLoading = false;

        emit(
          UpdateServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        serviceRequestModel = data;
        if (!isUpdatePayment) {
          if (serviceRequestModel?.serviceRequestDetails.driverRequestDetailsModel != null) {
            if (selectedServiceRequestStatus!.name != 'canceled') {
              sendNotification(
                fcmtoken: serviceRequestModel!.serviceRequestDetails.driverRequestDetailsModel!.fcmtoken,
                title: 'helpoo',
                body: 'تم تغيير حالة الطلب الخاص بك الى ${selectedServiceRequestStatus!.arName}',
                id: serviceRequestModel!.serviceRequestDetails.id.toString(),
                type: 'service-request',
              );
            } else {
              sendNotification(
                fcmtoken: serviceRequestModel!.serviceRequestDetails.driverRequestDetailsModel!.fcmtoken,
                title: 'helpoo',
                body: 'تم الغاء الطلب الخاص بك',
                id: serviceRequestModel!.serviceRequestDetails.id.toString(),
                type: 'service-request',
              );
            }
          }
        }

        isUpdateServiceRequestLoading = false;
        debugPrint('-----serviceRequestModel------');
        // debugPrint(serviceRequestModel!.serviceRequestDetails.status);
        emit(UpdateServiceRequestSuccessState());
      },
    );
  }

  /// assign driver to service request

  bool isAssignDriverToServiceRequestLoading = false;

  int? _driverAlreadyInReq;

  int? get driverAlreadyInReq => _driverAlreadyInReq;

  set driverAlreadyInReq(int? value) {
    _driverAlreadyInReq = value;
    emit(DriverAlreadyInReqChangedState());
  }

  void autoAssignDriverToServiceRequest({
    String? driverId,
    String? serviceRequestId,
    String? token,
    bool isReAssignDriver = false,
  }) async {
    emit(AssignDriverToServiceRequestLoadingState());

    isAssignDriverToServiceRequestLoading = true;

    final result = await _repository.autoAssignDriver(
      serviceRequestId: serviceRequestId ?? serviceRequestListModel!.serviceRequestDetails.id.toString(),
      driverId: driverId ?? serviceRequestDriver!.driver!.id.toString(),
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        isAssignDriverToServiceRequestLoading = false;

        emit(
          AssignDriverToServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isAssignDriverToServiceRequestLoading = false;

        sendNotification(
          fcmtoken: data.fcmToken,
          title: 'helpoo',
          body: 'تم استقبال طلب جديد',
          id: serviceRequestId ?? '',
          type: 'service-request',
        );

        if (isReAssignDriver) {
          sendNotification(
            fcmtoken: token ?? '',
            title: 'helpoo',
            body: 'تم الغاء الطلب الخاص بك',
            id: serviceRequestId ?? '',
            type: 'service-request',
          );
        }

        getAllServiceRequest(pageNumber: 1);

        emit(AutoAssignDriverToServiceRequestSuccessState(message: 'Driver changed automatically successfully'));
      },
    );
  }

  void logGoogleMapsApi({
    required String endpoint,
    required int requestId,
    required String from,
  }) async {
    emit(LogGoogleMapsApiLoadingState());

    final result = await _repository.logGoogleMapsApi(
      endpoint: endpoint,
      requestId: requestId,
      from: from,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        emit(
          LogGoogleMapsApiErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        emit(LogGoogleMapsApiSuccessState());
      },
    );
  }

  void assignDriverToServiceRequest({
    String? driverId,
    String? serviceRequestId,
    bool isReAssignDriver = false,
  }) async {
    emit(AssignDriverToServiceRequestLoadingState());

    isAssignDriverToServiceRequestLoading = true;

    final result = await _repository.assignDriver(
      serviceRequestId: serviceRequestId ?? serviceRequestListModel!.serviceRequestDetails.id.toString(),
      driverId: driverId ?? serviceRequestDriver!.driver!.id.toString(),
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        isAssignDriverToServiceRequestLoading = false;
        emit(
          AssignDriverToServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {

        ///* If there is Req over req [ What is the current req Id ?? ] So => Call Center can call Client
        if (data.requestId != null) {
          driverAlreadyInReq = data.requestId;
          printMeLog('Driver In Req ------------------');
          printMeLog('Driver In Req =>> $driverAlreadyInReq');
        } else {
          printMeLog('Driver In Req ------------------ 22');
          driverAlreadyInReq = serviceRequestDriver!.requestId;
          printMeLog('Driver In Req 22 =>> $driverAlreadyInReq');
        }
        isAssignDriverToServiceRequestLoading = false;
        sendNotification(
          fcmtoken: isReAssignDriver ? appBloc.selectedDriver!.driver!.fcmtoken! : serviceRequestDriver!.driver!.fcmtoken ?? '',
          title: 'helpoo',
          body: 'تم استقبال طلب جديد',
          id: isReAssignDriver ? selectedServiceRequestId.toString() : serviceRequestListModel!.serviceRequestDetails.id.toString(),
          type: 'service-request',
        );
        if (isReAssignDriver) {
          sendNotification(
            fcmtoken: selectedServiceRequestModel!.driver!.fcmtoken ?? '',
            title: 'helpoo',
            body: 'تم الغاء الطلب الخاص بك',
            id: selectedServiceRequestId.toString(),
            type: 'service-request',
          );
        }
        emit(AssignDriverToServiceRequestSuccessState(assignDriverResponse: data));
      },
    );
  }

  ///************************************ handle Create New Service Request *****************************/

  bool isNewCustomer = true;

  void setIsNewCustomer(bool value) {
    isNewCustomer = value;
    emit(SetIsNewCustomerSuccessState());
  }

  TextEditingController searchForExistingCustomerController = TextEditingController();

  customerSearch.CustomerSearchModel? customerSearchModel;

  void searchForExistingCustomer() async {
    emit(SearchForExistingCustomerLoadingState());

    final result = await _repository.searchForExistingCustomer(
      input: handlePhoneNumber(phoneNum: searchForExistingCustomerController.text),
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        emit(
          SearchForExistingCustomerErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        customerSearchModel = data;

        emit(SearchForExistingCustomerSuccessState());
      },
    );
  }

  existingUserCars.ExistingUserCarsModel? userCarsModel;

  existingUserCars.CustomerCar? _selectedUserCar;

  existingUserCars.CustomerCar? get selectedUserCar => _selectedUserCar;

  set selectedUserCar(existingUserCars.CustomerCar? value) {
    _selectedUserCar = value;
    emit(SelectedUserCarSuccessState());
  }

  bool isGetExistingCustomerCarsByPhoneLoading = false;

  void getExistingCustomerCarsByPhone({required String phone}) async {
    isGetExistingCustomerCarsByPhoneLoading = true;
    emit(GetExistingCustomerCarsLoadingState());

    final result = await _repository.getExistingCustomerCars(
      input: handlePhoneNumber(phoneNum: phone),
    );

    result.fold(
      (failure) {
        isGetExistingCustomerCarsByPhoneLoading = false;
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(GetExistingCustomerCarsErrorState(error: failure));
      },
      (data) {
        debugPrint('-----success------');
        userCarsModel = data;
        isGetExistingCustomerCarsByPhoneLoading = false;
        emit(GetExistingCustomerCarsSuccessState());
      },
    );
  }

  bool isAddCarToPackageLoading = false;

  void addCarToPackage({
    required String packageId,
    required String clientId,
    required clientPackageId,
    required String carId,
  }) async {
    isAddCarToPackageLoading = true;
    emit(AddCarToPackageLoadingState());

    final result = await _repository.addCarToPackage(
      carId: carId,
      clientId: clientId,
      clientPackageId: clientPackageId,
      packageId: packageId,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        isAddCarToPackageLoading = false;
        HelpooInAppNotification.showErrorMessage(message: failure.toString());
        emit(AddCarToPackageErrorState(error: failure));
      },
      (data) {
        debugPrint('-----success------');
        HelpooInAppNotification.showSuccessMessage(message: 'Car was added to package successfully.');
        isAddCarToPackageLoading = false;
        emit(AddCarToPackageSuccessState());
      },
    );
  }

  void emptyStateToRebuild() {
    emit(EmptyStateToRebuild());
  }

  Packages? selectedClientPackageToSubscribe;

  void setSelectedClientPackageToSubscribe(Packages pack) {
    selectedClientPackageToSubscribe = pack;
    emit(SelectedClientPackageChanged());
  }


  ///************************************ Discount area *****************************/

  TextEditingController discountValueController = TextEditingController();

  TextEditingController discountReasonController = TextEditingController();

  TextEditingController discountApproverController = TextEditingController();

  TextEditingController discountOtherReasonController = TextEditingController();

  List<String> approvedByList = [
    'Amr Ali',
    'Tarek Samy',
    'Farouk Mohamed',
  ];
  List<String> discountReasons = [
    'Dissatisfied customer',
    'Price is too much',
    'Long time waiting the driver',
    'VIP customer',
    'Other',
  ];

  bool isOtherReason = false;

  String? _selectedDiscountReason;

  String? get selectedDiscountReason => _selectedDiscountReason;

  set selectedDiscountReason(String? value) {
    _selectedDiscountReason = value;
    discountReasonController.text = value!;
    if (value == 'Other') {
      isOtherReason = true;
    } else {
      isOtherReason = false;
    }
    emit(SelectedDiscountReasonSuccessState());
  }

  String? _selectedApprovedBy;

  String? get selectedApprovedBy => _selectedApprovedBy;

  set selectedApprovedBy(String? value) {
    _selectedApprovedBy = value;
    discountApproverController.text = value!;
    emit(SelectedApprovedBySuccessState());
  }

  bool isDiscountLoading = false;

  bool _openDiscountForms = true;

  bool get openDiscountForms => _openDiscountForms;

  set openDiscountForms(bool value) {
    _openDiscountForms = value;
    emit(OpenDiscountFormsSuccessState());
  }

  void addDiscount() async {
    emit(AddDiscountLoadingState());
    isDiscountLoading = true;

    final result = await _repository.addDiscount(
      serviceRequestId: selectedServiceRequestId!,
      discount: int.parse(discountValueController.text),
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isDiscountLoading = false;
        emit(
          AddDiscountErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isDiscountLoading = false;
        emit(AddDiscountSuccessState());
      },
    );
  }

  void applyDiscount() async {
    emit(ApplyDiscountLoadingState());
    isDiscountLoading = true;

    final result = await _repository.applyDiscount(
      serviceRequestId: selectedServiceRequestId!,
      reason: selectedDiscountReason == 'Other' ? discountOtherReasonController.text : discountReasonController.text,
      approvedBy: selectedApprovedBy!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isDiscountLoading = false;
        emit(
          ApplyDiscountErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isDiscountLoading = false;
        isOtherReason = false;
        if (selectedServiceRequestModel!.driver != null) {
          sendNotification(
            fcmtoken: selectedServiceRequestModel!.driver!.fcmtoken!,
            title: 'helpoo',
            body: 'تم اضافة خصم على الرحلة',
            id: selectedServiceRequestId!.toString(),
            type: 'service-request',
          );
        }

        emit(ApplyDiscountSuccessState());
      },
    );
  }

  void removeDiscount() async {
    emit(RemoveDiscountLoadingState());
    isDiscountLoading = true;

    final result = await _repository.removeDiscount(
      serviceRequestId: selectedServiceRequestId!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isDiscountLoading = false;
        emit(
          RemoveDiscountErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isDiscountLoading = false;
        openDiscountForms = true;
        if (selectedServiceRequestModel!.driver != null) {
          sendNotification(
            fcmtoken: selectedServiceRequestModel!.driver!.fcmtoken!,
            title: 'helpoo',
            body: 'تم الغاء الخصم الموجود على الرحلة',
            id: selectedServiceRequestId!.toString(),
            type: 'service-request',
          );
        }

        emit(RemoveDiscountSuccessState());
      },
    );
  }

  ///************************************  Waiting time fees area *****************************/

  TextEditingController waitingTimeController = TextEditingController();
  TextEditingController waitingFeesController = TextEditingController();

  bool _openWaitingTimeForms = true;

  bool get openWaitingTimeForms => _openWaitingTimeForms;

  set openWaitingTimeForms(bool value) {
    _openWaitingTimeForms = value;
    emit(OpenWaitingTimeFormsSuccessState());
  }

  bool isWaitingTimeLoading = false;

// add waiting time
  void addWaitingTime() async {
    emit(AddWaitingTimeLoadingState());
    isWaitingTimeLoading = true;

    final result = await _repository.addWaitingTime(
      serviceRequestId: selectedServiceRequestId!,
      waitingTime: int.parse(waitingTimeController.text),
      waitingFees: int.parse(waitingFeesController.text),
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isWaitingTimeLoading = false;
        emit(
          AddWaitingTimeErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isWaitingTimeLoading = false;
        emit(AddWaitingTimeSuccessState());
      },
    );
  }

// apply waiting time

  void applyWaitingTime() async {
    emit(ApplyWaitingTimeLoadingState());
    isWaitingTimeLoading = true;
    final result = await _repository.applyWaitingTime(
      serviceRequestId: selectedServiceRequestId!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isWaitingTimeLoading = false;
        emit(
          ApplyWaitingTimeErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isWaitingTimeLoading = false;
        emit(ApplyWaitingTimeSuccessState());
      },
    );
  }

  // remove waiting time

  void removeWaitingTime() async {
    emit(RemoveWaitingTimeLoadingState());
    isWaitingTimeLoading = true;
    final result = await _repository.removeWaitingTime(
      serviceRequestId: selectedServiceRequestId!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isWaitingTimeLoading = false;
        emit(
          RemoveWaitingTimeErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isWaitingTimeLoading = false;
        emit(RemoveWaitingTimeSuccessState());
      },
    );
  }

  ///************************************  comment on request area *****************************/

  TextEditingController commentOnRequestController = TextEditingController();

  bool isCommentOnRequestLoading = false;

  void commentOnRequest() async {
    emit(CommentOnRequestLoadingState());
    isCommentOnRequestLoading = true;

    final result = await _repository.addCommentOnServiceRequest(
      serviceRequestId: selectedServiceRequestId!,
      comment: commentOnRequestController.text,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCommentOnRequestLoading = false;
        emit(
          CommentOnRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCommentOnRequestLoading = false;
        commentOnRequestController.clear();
        emit(CommentOnRequestSuccessState());
      },
    );
  }

  ///************************************ getAllDrivers *****************************/

  AvailableDrivers? _selectedDriver;

  AvailableDrivers? get selectedDriver => _selectedDriver;

  set selectedDriver(AvailableDrivers? value) {
    _selectedDriver = value;
    emit(SelectedDriverSuccessState());
  }

  // get role name based on role id

  String getRoleNameBasedOnRoleId(int roleId) {
    String roleName = '';
    for (var role in Rules.values) {
      if (role.id == roleId) {
        roleName = role.name;
      }
    }

    return roleName;
  }

  ///************************************  Cancel service request *****************************/

  bool isCancelServiceRequestLoading = false;

  void cancelServiceRequest({
    ServiceRequestModel? serviceRequestModel,
  }) async {
    emit(CancelServiceRequestLoadingState());
    isCancelServiceRequestLoading = true;

    final result = await _repository.cancelServiceRequest(
      serviceRequestId: serviceRequestModel!.id!,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCancelServiceRequestLoading = false;
        emit(
          CancelServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        if (serviceRequestModel.driver != null) {
          debugPrint('-----fcmtoken ${serviceRequestModel.driver!.fcmtoken!} ------');
          sendNotification(
            fcmtoken: serviceRequestModel.driver!.fcmtoken!,
            title: 'helpoo',
            body: "لقد تم الغاء الطلب",
            id: serviceRequestModel.id!.toString(),
            type: 'service-request',
          );
        }
        isCancelServiceRequestLoading = false;
        emit(CancelServiceRequestSuccessState());
      },
    );
  }

  bool getRunningStatus(String status) {
    if (status == 'done' || status == 'canceled' || status == 'cancelWithPayment') {
      return false;
    } else {
      return true;
    }
  }

  ///************************************  get service request reports *****************************/

  String _startDate = '';
  String _endDate = '';

  String get startDate => _startDate;

  String get endDate => _endDate;

  set startDate(String value) {
    _startDate = value;
    emit(StartDateChanged());
  }

  set endDate(String value) {
    _endDate = value;
    emit(EndDateChanged());
  }

  List<String> reportExistingColumns = [
    'ID',
    'Created At',
    'Client Name',
    'Mobile',
    'Driver Name',
    'Status',
    'Type',
    'Payment Status',
    'Payment Method',
    'Client Type',
    'Original Fees',
    'Fees',
    'Discount Cost',
    'Discount Rate',
    'From',
    'To',
    'Discount Reason',
    'Discount Approver',
    'Waiting Time',
    'Waiting Cost',
    'Car Brand',
    'Car Model',
    'Car Color',
    'Car Plate',
    'Car Year',
    'Corporate Company',
    'Winch number',
    'comment',
    'Created By',
    'Created By Role',
    'Package Name',
    'Vin Number',
  ];

  List<String> excelColumnsNames = [
    'ID',
    'Created At',
    'Client Name',
    'Mobile',
    'Driver Name',
    'Status',
    'Type',
    'Payment Status',
    'Payment Method',
    'Client Type',
    'Original Fees',
    'Fees',
    'Discount Cost',
    'Discount Rate',
    'From',
    'To',
    'Discount Reason',
    'Discount Approver',
    'Waiting Time',
    'Waiting Cost',
    'Car Plate',
  ];

  List<String> savedColumnsNames = [];

  String getCarBrand(int carId) {
    if (manufacturersModel!.manufacturers.map((e) => e.id).toList().contains(carId)) {
      return manufacturersModel?.manufacturers.where((e) => e.id == carId).first.enName ?? '';
    } else {
      return '';
    }
  }

  void getSavedFixedColumns() async {
    await sl<CacheHelper>().get(Keys.fixedColumns).then((value) async {
      if (value != null) {
        debugPrint('values : $value');
        List<dynamic> list = value;
        savedColumnsNames.clear();
        savedColumnsNames = list.cast<String>();
      } else {
        await sl<CacheHelper>().put(Keys.fixedColumns, excelColumnsNames);
        savedColumnsNames = excelColumnsNames;
      }
    });

    emit(GetSavedFixedColumnsSuccessState());
  }
  String getCarModel(int carModelId) {
    if (carsModel!.models.map((e) => e.id).toList().contains(carModelId)) {
      return carsModel?.models.where((e) => e.id == carModelId).first.enName ?? '';
    } else {
      return '';
    }
  }

  List<dynamic> excelData = [];

  void addNewExcelColumn(String columnName) {
    if (!savedColumnsNames.contains(columnName)) {
      savedColumnsNames.add(columnName);

      savedColumnsNames.sort((a, b) {
        return reportExistingColumns.indexOf(a).compareTo(reportExistingColumns.indexOf(b));
      });
    } else {
      savedColumnsNames.remove(columnName);
    }
    emit(AddNewExcelColumnSuccessState());
  }

  void addNewFixedColumn(String columnName) {
    if (!savedColumnsNames.contains(columnName)) {
      savedColumnsNames.add(columnName);

      savedColumnsNames.sort((a, b) {
        return reportExistingColumns.indexOf(a).compareTo(reportExistingColumns.indexOf(b));
      });
    } else {
      savedColumnsNames.remove(columnName);
    }
    emit(AddNewFixedColumnSuccessState());
  }

  void saveNewFixedColumnsToLocal() async {
    await sl<CacheHelper>().put(Keys.fixedColumns, savedColumnsNames);
    emit(SaveNewFixedColumnsSuccessState());
  }

  void addNewExcelData(List<dynamic> data) {
    excelData.add(data);
    emit(AddNewExcelDataSuccessState());
  }

  bool isColumnExist(String columnName) {
    if (savedColumnsNames.contains(columnName)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createExcel() async {
    debugPrint('createExcel');
    debugPrint(startDate);
    debugPrint(endDate);

    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    final data = [
      savedColumnsNames,
      ...excelData,
    ];

    for (final List<String> row in data) {      // supplement images when upload the app craches
      List<CellValue> rowOfCells = row.map((e) => TextCellValue(e)).toList();
      // sheet.appendRow(row);
      sheet.appendRow(rowOfCells);
    }

    final blob = html.Blob([excel.encode()], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = 'Report.xlsx'
      ..click();
    html.Url.revokeObjectUrl(url);
    excelData.clear();
    allReportsModel = null;
    corporateSearchModel = null;
    customerSearchModel = null;
  }

  final DateRangePickerController reportsSelectDateController = DateRangePickerController();

  bool isGetServiceRequestReportsLoading = false;

  GetAllServicesRequests? allReportsModel;

  bool _isDoneReportsOnly = false;

  bool get isDoneReportsOnly => _isDoneReportsOnly;

  set isDoneReportsOnly(bool value) {
    _isDoneReportsOnly = value;
    emit(ChangeDoneReportsOnlyState());
  }

  List<ServiceRequestModel> getAllDoneReportsModel() {
    if (allReportsModel != null) {
      if (allReportsModel!.requests != null) {
        // sort all requests by id
        allReportsModel!.requests!.sort((a, b) => b.id!.compareTo(a.id!));
        return allReportsModel!.requests!.where((element) => element.status == ServiceRequestStatus.done.name).toList();
      }
    }
    return [];
  }

  void getServiceRequestReports() async {
    emit(GetServiceRequestReportsLoadingState());
    isGetServiceRequestReportsLoading = true;

    final result = await _repository.getServiceRequestsReports(
      startDate: startDate,
      endDate: endDate,
      filterType: filterType,
      filterValue: filterValue,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        isGetServiceRequestReportsLoading = false;
        emit(
          GetServiceRequestReportsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        allReportsModel = data;
        isGetServiceRequestReportsLoading = false;
        emit(GetServiceRequestReportsSuccessState());
      },
    );
  }

  String? filterType;
  dynamic filterValue;

  void getFilterTypeAndValue() {
    if (selectedReportsFilterOption != 'All') {
      switch (selectedReportsFilterOption) {
        case 'All Clients':
          filterType = 'filterBy';
          filterValue = 'Clients';
          break;
        case 'All Corporates':
          filterType = 'filterBy';
          filterValue = 'Corporates';
          break;
        case 'Specific Client':
          filterType = 'ClientId';
          filterValue = customerSearchModel!.client!.id;
          break;
        case 'Specific Corporate':
          filterType = 'CorporateId';
          filterValue = userRoleName == Rules.Corporate.name ? currentCompanyId : selectedCorporate?.id;
          break;
        default:
      }
    } else {
      filterType = null;
      filterValue = null;
    }
  }

  List<String> reportsFilterOptions = [
    'All',
    'All Clients',
    'All Corporates',
    'Specific Client',
    'Specific Corporate',
  ];

  bool isFilterOff = true;

  bool isFilterByAllClients = false;

  bool isFilterByAllCorporates = false;

  bool isFilterBySpecificClient = false;

  bool isFilterBySpecificCorporate = false;

  String _selectedReportsFilterOption = 'All';

  String get selectedReportsFilterOption => _selectedReportsFilterOption;

  set selectedReportsFilterOption(String value) {
    _selectedReportsFilterOption = value;
    switch (value) {
      case 'All':
        isFilterOff = true;
        isFilterByAllClients = false;
        isFilterByAllCorporates = false;
        isFilterBySpecificClient = false;
        isFilterBySpecificCorporate = false;
        break;
      case 'All Clients':
        isFilterOff = false;
        isFilterByAllClients = true;
        isFilterByAllCorporates = false;
        isFilterBySpecificClient = false;
        isFilterBySpecificCorporate = false;
        break;
      case 'All Corporates':
        isFilterOff = false;
        isFilterByAllCorporates = true;
        isFilterByAllClients = false;
        isFilterBySpecificClient = false;
        isFilterBySpecificCorporate = false;

        break;
      case 'Specific Client':
        isFilterOff = false;
        isFilterBySpecificClient = true;
        isFilterByAllCorporates = false;
        isFilterByAllClients = false;
        isFilterBySpecificCorporate = false;

        break;
      case 'Specific Corporate':
        isFilterOff = false;
        isFilterBySpecificCorporate = true;
        isFilterByAllCorporates = false;
        isFilterByAllClients = false;
        isFilterBySpecificClient = false;

        break;
    }
    emit(SelectedReportsFilterOptionChanged());
  }

  // corporate search

  TextEditingController corporateSearchController = TextEditingController();

  CorporateSearchModel? corporateSearchModel;

  bool isCorporateSearchLoading = false;

  void searchCorporate() async {
    emit(SearchCorporateLoadingState());
    isCorporateSearchLoading = true;

    final result = await _repository.corporateSearch(input: corporateSearchController.text);

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        isCorporateSearchLoading = false;
        emit(
          SearchCorporateErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        corporateSearchModel = data;
        for (var element in corporateSearchModel!.corporates!) {
          debugPrint(element.arName);
        }
        isCorporateSearchLoading = false;
        emit(SearchCorporateSuccessState());
      },
    );
  }

  Corporates? _selectedCorporate;

  Corporates? get selectedCorporate => _selectedCorporate;

  set selectedCorporate(Corporates? value) {
    _selectedCorporate = value;
    emit(SelectedCorporateChanged());
  }

  /// ----------------- get corporate service requests -----------------

  bool isGetCorporateServiceRequestsLoading = false;
  GetAllServicesRequests? corporateSr;

  void getCorporateServiceRequests({
    bool isFirstTime = false,
    bool isRefreshServiceRequest = false,
    required int pageNumber
      }) async {
    emit(GetCorporateServiceRequestsLoadingState(
      isRefreshServiceRequest: isRefreshServiceRequest,
    ));
    if (isFirstTime) {
      isGetCorporateServiceRequestsLoading = true;
    }
    final result = await _repository.getCorporateServiceRequests(
      corporateId: userRoleName == Rules.Corporate.name ? currentCompanyId : selectedCorporateId,pageNumber: pageNumber
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        isGetCorporateServiceRequestsLoading = false;
        emit(
          GetCorporateServiceRequestsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        allServicesRequests = data;
        corporateSr = data;
        isGetCorporateServiceRequestsLoading = false;
        emit(GetCorporateServiceRequestsSuccessState(
          isRefreshServiceRequest: isRefreshServiceRequest,
        ));
      },
    );
  }

  /// ----------------- handle Change service request status -----------------

  TextEditingController serviceRequestStatusController = TextEditingController();

  ServiceRequestStatus? _selectedServiceRequestStatus;

  ServiceRequestStatus? get selectedServiceRequestStatus => _selectedServiceRequestStatus;

  set selectedServiceRequestStatus(ServiceRequestStatus? value) {
    _selectedServiceRequestStatus = value;
    serviceRequestStatusController.text = value!.enName;
    emit(SelectedServiceRequestStatusChanged());
  }

  /// ----------------- handle drivers map -----------------

  GetAllServicesRequests? allOpenServiceRequests;

  Map<int, String> duplicatedDriversIds = {};

  bool isDuplicate(List<int> dataList, int targetId) {
    return dataList.where((item) => item == targetId).length > 1;
  }

  void getAllOpenServiceRequests({
    bool isFirstTime = false,
  }) async {
    if (isFirstTime) {
      emit(GetAllOpenServiceRequestsLoadingState());
    }

    final result = await _repository.getAllOpenServiceRequests();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        emit(
          GetAllOpenServiceRequestsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        allOpenServiceRequests = data;

        // all drivers id inside allOpenServiceRequests
        List<int> driversIds = allOpenServiceRequests!.requests!.map((e) => e.driverId ?? 0).toList();

        allOpenServiceRequests?.requests?.forEach((element) {
          if (isDuplicate(driversIds, (element.driverId ?? 0))) {
            // check if id exist in duplicatedDriversIds
            if (duplicatedDriversIds[(element.driverId ?? 0)] == null) {
              debugPrint("The ID ==> ${(element.driverId ?? 0)} appears more than once in the list.");
              duplicatedDriversIds.addAll({
                (element.driverId ?? 0): element.status!,
              });
            } else {
              if ((element.reject ?? false) && element.isRequestActive) {
                duplicatedDriversIds.update((element.driverId ?? 0), (value) => 'requestToCancel');
              } else {
                duplicatedDriversIds.update((element.driverId ?? 0), (value) => (element.status ?? ''));
              }
              debugPrint("The ID ==> ${element.status} appears more than once in the list.");
            }
          } else {
            debugPrint("The ID ==> ${(element.driverId ?? 0)} appears only once in the list.");
          }
        });

        getDriversMap(
          isFirstTime: isFirstTime,
        );

        boundsList.addAll(
          allOpenServiceRequests!.requests!.map(
            (e) => LatLng(
              double.parse(e.location!.clientLatitude!) ?? 0.0,
              double.parse(e.location!.clientLongitude!) ?? 0.0,
            ),
          ),
        );

        // markers.clear();
        // markers = {};

        changeBounds();

        addAllClientsMarkers();

        emit(GetAllOpenServiceRequestsSuccessState());
      },
    );
  }

  List<LatLng> boundsList = [];

  addCarsClientIcons({
    required String id,
    required String infoMainText,
    required String infoSubText,
    required double latitude,
    required double longitude,
  }) async {
    debugPrint('-----addCarsClientIcons------ $id');

    Marker? marker = carsMarkers.firstWhereOrNull((element) => element.markerId.value == id);

    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car_48_red.png",
    );

    if (marker != null) {
      debugPrint('-----car exist------');

      carsMarkers.remove(marker);

      carsMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----cars Markers Tap ** ------');
          },
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: isTripStarted == true ? false : hideClients,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----cars Markers Tap 1 ------');
            },
          ),
        ),
      );

      emit(UpdateDriversMapSuccessState());
    } else {
      debugPrint('-----car not exist------');

      carsMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----cars Markers Tap ** 2 ------');
          },
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: isTripStarted == true ? false : hideClients,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----cars Markers Tap 2 ------');
            },
          ),
        ),
      );

      emit(DrawDriversMapSuccessState());
    }
  }

  void getRelatedWinchToCar({
    required int requestId,
  }) {
    int driverId = allOpenServiceRequests?.requests?.firstWhere((element) => element.id == requestId).driverId ?? 0;
  }

  bool checkBusyDriversVisibility() {
    if (isWinchVehicle) {
      if (busyDrivers) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkfreeDriversVisibility() {
    if (isWinchVehicle) {
      if (freeDrivers) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  addAvailablePassengerCarIcons({
    required String id,
    required String infoMainText,
    required String infoSubText,
    required double latitude,
    required double longitude,
  }) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/n300_free.png',
    );

    Marker? marker = passengersCarsMarkers.firstWhereOrNull((element) => element.markerId.value == id);

    debugPrint('-----passenger car exist out------');

     if (marker != null) {
      debugPrint('-----passenger car exist------');

      passengersCarsMarkers.remove(marker);

      passengersCarsMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----available Winch Markers ** ------');
          },
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkfreeDriversVisibility(),
          visible: true,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----available Winch Markers Tap ------');
            },
          ),
        ),
      );

      emit(UpdateDriversMapSuccessState());
    } else {
      passengersCarsMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----available Winch Markers ** 2 ------');
          },
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkfreeDriversVisibility(),
          visible: true,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----available Winch Markers Tap 2 ------');
            },
          ),
        ),
      );

      emit(DrawDriversMapSuccessState());
    }
  }

  addAvailableWinchDriverIcons({
    required String id,
    required String infoMainText,
    required String infoSubText,
    required double latitude,
    required double longitude,
    required bool isEuro,
  }) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/${isEuro ? 'towP_green' : 'tow_green'}.png',
    );

    Marker? marker = availableWinchMarkers.firstWhereOrNull((element) => element.markerId.value == id);

    if (marker != null) {
      debugPrint('-----winch exist------');

      availableWinchMarkers.remove(marker);

      availableWinchMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----available Winch Markers ** ------');
          },
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkfreeDriversVisibility(),
          visible: true,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----available Winch Markers Tap ------');
            },
          ),
        ),
      );

      emit(UpdateDriversMapSuccessState());
    } else {
      availableWinchMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----available Winch Markers ** 2 ------');
          },
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkfreeDriversVisibility(),
          visible: true,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----available Winch Markers Tap 2 ------');
            },
          ),
        ),
      );

      emit(DrawDriversMapSuccessState());
    }
  }

  addBusyWinchDriverIcons({
    required String id,
    required String infoMainText,
    required String infoSubText,
    required double latitude,
    required double longitude,
    required bool isEuro,
  }) async {
    ServiceRequestModel SRModel =
        allOpenServiceRequests?.requests?.firstWhereOrNull((element) => element.driverId == int.parse(id)) ?? ServiceRequestModel();

    debugPrint('-----addBusyWinchDriverIcons------');
    debugPrint(getDriverServiceRequestStatus(
      driverId: int.parse(id),
    ).name);

    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/${markerColorAndIcon(
        isDouble: duplicatedDriversIds[(int.parse(id))] != null,
        secondStatus: duplicatedDriversIds[(int.parse(id))] ?? '',
        isEuro: isEuro,
        status: getDriverServiceRequestStatus(
          driverId: int.parse(id),
        ),
      )}.png',
    );

    Marker? marker = busyWinchMarkers.firstWhereOrNull((element) => element.markerId.value == id);

    if (marker != null) {
      debugPrint('-----winch exist------');

      busyWinchMarkers.remove(marker);

      busyWinchMarkers.add(
        Marker(
          onTap: () {},
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkBusyDriversVisibility(),
          visible: true,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----busy Winch Markers Tap ------');
            },
          ),
        ),
      );

      emit(UpdateDriversMapSuccessState());
    } else {
      busyWinchMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----Busy Winch Markers Tap ** 2 ------');

            showPrimaryPopUp(
              context: navigatorKey.currentContext!,
              isDismissible: false,
              title: 'test',
              horizontalPadding: 20,
              popUpBody: ServiceRequestDetails(
                serviceRequestModel: SRModel,
                isFromDriversMap: true,
              ),
            );
          },
          markerId: MarkerId(id),

          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkBusyDriversVisibility(),
          visible: true,
        ),
      );

      emit(DrawDriversMapSuccessState());
    }
  }

  addBusyWinchPassengersBusyCar({
    required String id,
    required String infoMainText,
    required String infoSubText,
    required double latitude,
    required double longitude,
    required bool isEuro,
  }) async {
    ServiceRequestModel SRModel =
        allOpenServiceRequests?.requests?.firstWhereOrNull((element) => element.driverId == int.parse(id)) ?? ServiceRequestModel();

    debugPrint('-----addBusyWinchDriverIcons------');
    debugPrint(getDriverServiceRequestStatus(
      driverId: int.parse(id),
    ).name);

    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/n300_busy.png',
    );

    Marker? marker = busyPassengersCarMarkers.firstWhereOrNull((element) => element.markerId.value == id);

    if (marker != null) {
      debugPrint('-----winch exist------');

      busyPassengersCarMarkers.remove(marker);

      busyPassengersCarMarkers.add(
        Marker(
          onTap: () {},
          markerId: MarkerId(id),
          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkBusyDriversVisibility(),
          visible: true,
          infoWindow: InfoWindow(
            title: infoMainText,
            snippet: infoSubText,
            onTap: () {
              debugPrint('-----busy Winch Markers Tap ------');
            },
          ),
        ),
      );

      emit(UpdateDriversMapSuccessState());
    } else {
      busyPassengersCarMarkers.add(
        Marker(
          onTap: () {
            debugPrint('-----Busy Winch Markers Tap ** 2 ------');

            showPrimaryPopUp(
              context: navigatorKey.currentContext!,
              isDismissible: false,
              title: 'test',
              horizontalPadding: 20,
              popUpBody: ServiceRequestDetails(
                serviceRequestModel: SRModel,
                isFromDriversMap: true,
              ),
            );
          },
          markerId: MarkerId(id),

          position: LatLng(
            latitude,
            longitude,
          ),
          icon: markerIcon,
          draggable: false,
          // visible: checkBusyDriversVisibility(),
          visible: true,
        ),
      );

      emit(DrawDriversMapSuccessState());
    }
  }

  String markerColorAndIcon({
    required ServiceRequestStatus status,
    required bool isEuro,
    bool isDouble = false,
    String secondStatus = '',
  }) {
    String icon = isEuro ? 'towP_red' : 'tow_red';

    switch (status) {
      case ServiceRequestStatus.canceled:
        break;
      case ServiceRequestStatus.cancelWithPayment:
        break;
      case ServiceRequestStatus.open:
        // TODO: Handle this case.
        break;
      case ServiceRequestStatus.confirmed:
        icon = 'tow-truck_2';
        break;
      case ServiceRequestStatus.accepted:
        icon = isEuro ? 'towP_orange' : 'tow_orange';
        break;
      case ServiceRequestStatus.arrived:
        icon = isEuro ? 'towP_orange' : 'tow_orange';
        break;
      case ServiceRequestStatus.started:
        icon = isEuro
            ? (isDouble
                ? getReqOverReqRightVehicleByStatusEuro(
                    status: secondStatus,
                  )
                : 'towing-vehicle')
            : (isDouble ? 'tow-double-check-normal' : 'towing_64');
        break;
      case ServiceRequestStatus.done:
        // TODO: Handle this case.
        break;
      case ServiceRequestStatus.pending:
        icon = 'tow_50_black';
        break;
      case ServiceRequestStatus.destArrived:
        icon = isEuro
            ? (isDouble
                ? getReqOverReqRightVehicleByStatusEuro(
                    status: secondStatus,
                  )
                : 'towing-vehicle')
            : (isDouble ? 'tow-double-check-normal' : 'towing_64');
        break;
    }

    return icon;
  }

  String getReqOverReqRightVehicleByStatusEuro({
    required String status,
  }) {
    String a = '';

    debugPrint('-----getReqOverReqRightVehicleByStatusEuro------');
    debugPrint(status);

    if (status == 'requestToCancel') {
      a = 'cancel-request-euro';
    } else {
      if (status.isEmpty) {
        a = 'tow_double-check';
      }

      if (status == ServiceRequestStatus.confirmed.name) {
        a = 'accept-request-euro';
      }

      if (status == ServiceRequestStatus.accepted.name) {
        a = 'tow_double-check';
      }
    }

    return a;
  }

  String getReqOverReqRightVehicleByStatusNormal({
    required String status,
  }) {
    String a = '';

    debugPrint('-----getReqOverReqRightVehicleByStatusEuro------');
    debugPrint(status);

    if (status == 'requestToCancel') {
      a = 'cancel-request-normal';
    } else {
      if (status.isEmpty) {
        a = 'tow-double-check-normal';
      }

      if (status == ServiceRequestStatus.confirmed.name) {
        a = 'accept-request-normal';
      }

      if (status == ServiceRequestStatus.accepted.name) {
        a = 'tow-double-check-normal';
      }
    }

    return a;
  }

  ServiceRequestStatus getDriverServiceRequestStatus({
    required int driverId,
  }) {
    String status = allOpenServiceRequests?.requests
            ?.firstWhereOrNull(
              (element) => element.driverId == driverId,
            )
            ?.status ??
        ServiceRequestStatus.canceled.name;

    return ServiceRequestStatus.values.firstWhere(
      (element) => element.name == status,
    );
  }

  double heading = 0.0;

  void addOriginIcon({
    required String id,
    required double latitude,
    required double longitude,
    required ServiceRequestStatus status,
  }) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/${originMarkerColorAndIcon(status: status)}.png",
    );

    originMarker = Marker(
      onTap: () {},
      markerId: MarkerId(id),
      position: LatLng(
        latitude,
        longitude,
      ),
      // icon: BitmapDescriptor.defaultMarker,
      icon: markerIcon,
      draggable: false,
      infoWindow: InfoWindow(
        title: '',
        snippet: '',
        onTap: () {},
      ),
    );
    emit(DrawMainTripIconsSuccessState());
  }

  void addDistinationIcon({
    required String id,
    required double latitude,
    required double longitude,
    required ServiceRequestStatus status,
  }) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/${destinationMarkerColorAndIcon(status: status)}.png",
    );

    destinationMarker = Marker(
      onTap: () {},
      markerId: MarkerId(id),
      position: LatLng(
        latitude,
        longitude,
      ),
      icon: markerIcon,
      draggable: false,
      rotation: heading,
      infoWindow: InfoWindow(
        title: '',
        snippet: '',
        onTap: () {},
      ),
    );

    emit(DrawMainTripIconsSuccessState());
  }

  addOriginAndDistinationIcons({
    required String id,
    required double latitude,
    required double longitude,
    required bool isOrigin,
  }) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/${isOrigin ? 'car' : 'tow_truck2'}.png",
    );

    if (isOrigin) {
      originMarker = Marker(
        onTap: () {},
        markerId: MarkerId(id),
        position: LatLng(
          latitude,
          longitude,
        ),
        icon: BitmapDescriptor.defaultMarker,
        draggable: false,
        infoWindow: InfoWindow(
          title: '',
          snippet: '',
          onTap: () {},
        ),
      );
    } else {
      destinationMarker = Marker(
        onTap: () {},
        markerId: MarkerId(id),
        position: LatLng(
          latitude,
          longitude,
        ),
        icon: markerIcon,
        draggable: false,
        rotation: heading,
        infoWindow: InfoWindow(
          title: '',
          snippet: '',
          onTap: () {},
        ),
      );
    }
    emit(DrawMainTripIconsSuccessState());
  }

  String originMarkerColorAndIcon({
    required ServiceRequestStatus status,
  }) {
    String icon = 'car';

    switch (status) {
      case ServiceRequestStatus.canceled:
        break;
      case ServiceRequestStatus.cancelWithPayment:
        break;
      case ServiceRequestStatus.open:
        icon = 'car';
        break;
      case ServiceRequestStatus.confirmed:
        icon = 'tow_truck2';
        break;
      case ServiceRequestStatus.accepted:
        icon = 'tow_truck2';
        break;
      case ServiceRequestStatus.arrived:
        icon = 'tow_truck2';
        break;
      case ServiceRequestStatus.started:
        icon = 'towing2';
        break;
      case ServiceRequestStatus.done:
        icon = 'car';
        break;
      case ServiceRequestStatus.pending:
        icon = 'car';
        break;
      case ServiceRequestStatus.destArrived:
        icon = 'towing2';
        break;
    }

    return icon;
  }

  String destinationMarkerColorAndIcon({
    required ServiceRequestStatus status,
  }) {
    String icon = 'tow_truck2';

    switch (status) {
      case ServiceRequestStatus.canceled:
        icon = 'garage';
        break;
      case ServiceRequestStatus.cancelWithPayment:
        icon = 'garage';
        break;
      case ServiceRequestStatus.open:
        icon = 'car';
        break;
      case ServiceRequestStatus.confirmed:
        icon = 'car';
        break;
      case ServiceRequestStatus.accepted:
        icon = 'car';
        break;
      case ServiceRequestStatus.arrived:
        icon = 'car';
        break;
      case ServiceRequestStatus.started:
        icon = 'garage';
        break;
      case ServiceRequestStatus.done:
        icon = 'garage';
        break;
      case ServiceRequestStatus.pending:
        icon = 'tow_truck2';
        break;
      case ServiceRequestStatus.destArrived:
        icon = 'garage';
        break;
    }

    return icon;
  }

  LatLngBounds? bounds;
  bool autoZoom = true;

  void changeBounds() {
    calcBounds();
  }

  double lat = 0.0;
  double lng = 0.0;

  calcBounds() {
    bounds = boundsFromLatLngList(boundsList);

    lat = (bounds!.northeast.latitude + bounds!.southwest.latitude) / 2;
    lng = (bounds!.northeast.longitude + bounds!.southwest.longitude) / 2;

    emit(CalcBoundsSuccessState());
  }

  LatLngBounds? boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }

    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (x1 == null || latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (y1 == null || latLng.longitude > y1) y1 = latLng.longitude;
        if (y0 == null || latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  DriversMapModel? driversMapModel;

  GoogleMapController? mapController;
  GoogleMapController? originalMapController;

  Set<Marker> tripMarkers = {};

  Set<Marker> availableWinchMarkers = {};

  Set<Marker> passengersCarsMarkers = {};

  Set<Marker> busyWinchMarkers = {};

  Set<Marker> busyPassengersCarMarkers = {};

  Set<Marker> carsMarkers = {};

  void getDriversMap({
    bool isFirstTime = false,
  }) async {
    if (isFirstTime) {
      emit(GetDriversMapLoadingState());
    }

    final result = await _repository.getAllDriversPlacesMap();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        emit(
          GetDriversMapErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        driversMapModel = data;
        debugPrint('----- trucks data : ${data.drivers!.length}');

        // markers.clear();
        // markers = {};

        addAllWinchMarkers();

        boundsList.addAll(
          driversMapModel!.drivers!.map(
            (e) => LatLng(
              e.driver?.location?.latitude ?? 0.0,
              e.driver?.location?.longitude ?? 0.0,
            ),
          ),
        );
        emit(GetDriversMapSuccessState());
      },
    );
  }

  String checkDriversMapIconStatus({
    bool isEuropeanVehicle = false,
    required Drivers driver,
  }) {
    String carName = '';
    for (var request in allOpenServiceRequests!.requests!) {
      if (request.driver!.id == driver.driver!.id! && !driver.driver!.available!) {
        if (request.status == ServiceRequestStatus.confirmed.name) {
          carName = isEuropeanVehicle ? 'towP_orange' : 'tow_orange';
        } else if (request.status == ServiceRequestStatus.accepted.name || request.status == ServiceRequestStatus.arrived.name) {
          carName = 'tow-truck_2';
        } else {
          carName = isEuropeanVehicle ? 'towP_red' : 'tow_red';
        }
      }
    }
    debugPrint('current car Name >>>>> $carName');
    return carName;
  }

  void addAllWinchMarkers() {
    availableWinchMarkers.clear();
    passengersCarsMarkers.clear();
    busyWinchMarkers.clear();
    busyPassengersCarMarkers.clear();

    if (!isWinchVehicle) {
      return;
    }

    for (Drivers element in driversMapModel!.drivers!) {
      debugPrint('-----driver------ ${element.driver!.id}');

      if (element.driver!.location!.latitude != 0) {

        if (element.vehicle?.vecTypeName == 'carrier') {
          addAvailablePassengerCarIcons(
            id: element.driver?.id.toString() ?? '',
            infoMainText: element.driver?.user?.name ?? '',
            infoSubText: element.driver?.user?.phoneNumber ?? '',
            latitude: element.driver?.location?.latitude ?? 0,
            longitude: element.driver?.location?.longitude ?? 0,
          );
        } else if (element.driver?.available ?? true && freeDrivers) {
            addAvailableWinchDriverIcons(
              id: element.driver?.id.toString() ?? '',
              infoMainText: element.driver?.user?.name ?? '',
              infoSubText: element.driver?.user?.phoneNumber ?? '',
              latitude: element.driver?.location?.latitude ?? 0,
              longitude: element.driver?.location?.longitude ?? 0,
              isEuro: element.vehicle?.vecTypeName == 'europeanTowTruck' ? true : false,
            );
        } else if (busyDrivers) {
          addBusyWinchDriverIcons(
            id: element.driver?.id.toString() ?? '',
            infoMainText: element.driver?.user?.name ?? '',
            infoSubText: element.driver?.user?.phoneNumber ?? '',
            latitude: element.driver?.location?.latitude ?? 0,
            longitude: element.driver?.location?.longitude ?? 0,
            isEuro: element.vehicle?.vecTypeName == 'europeanTowTruck' ? true : false,
          );
        }
      }
    }
  }

  bool checkIfTripStarted({
    required ServiceRequestModel model,
  }) {
    if (model.status == ServiceRequestStatus.started.name) {
      return true;
    } else {
      return false;
    }
  }

  void addAllClientsMarkers() {
    carsMarkers.clear();

    debugPrint('-----all clients markers cleared------ ${allOpenServiceRequests!.requests!.length.toString()}');

    for (var element in allOpenServiceRequests!.requests!) {
      if (element.location!.clientLatitude != '') {
        if (element.status == ServiceRequestStatus.started.name || element.status == ServiceRequestStatus.done.name) {
          continue;
        } else {
          debugPrint('-----client location not null------ ${element.status}');

          addCarsClientIcons(
            id: element.id.toString(),
            infoMainText: element.client?.user?.name ?? '',
            infoSubText: element.client?.user?.phoneNumber ?? '',
            latitude: double.parse(element.location!.clientLatitude!),
            longitude: double.parse(element.location!.clientLongitude!),
          );
        }
      }

      debugPrint('-----car added------ ${carsMarkers.length.toString()}');
    }
  }

  Timer? _clientCarTimer;

  Timer? get clientCarTimer => _clientCarTimer;

  set clientCarTimer(Timer? value) {
    _clientCarTimer = value;
    emit(ChangeClientCarTimerState());
  }

  bool _isInfoWindowShown = false;

  bool get isInfoWindowShown => _isInfoWindowShown;

  set isInfoWindowShown(bool value) {
    _isInfoWindowShown = value;
    emit(ChangeInfoWindowState());
  }

  double southWestLatitude = 0;
  double southWestLongitude = 0;

  double northEastLatitude = 0;
  double northEastLongitude = 0;

  void animateCameraToShowPath({
    required gMap.LatLng from,
    required gMap.LatLng to,
    // required gMap.GMap map,
  }) {
    northEastLatitude = 0;
    northEastLongitude = 0;

    southWestLatitude = 0;
    southWestLongitude = 0;

    double miny = ((from.lat <= to.lat) ? from.lat : to.lat).toDouble();
    double minx = ((from.lng <= to.lng) ? from.lng : to.lng).toDouble();
    double maxy = ((from.lat <= to.lat) ? to.lat : from.lat).toDouble();
    double maxx = ((from.lng <= to.lng) ? to.lng : from.lng).toDouble();

    southWestLatitude = miny;
    southWestLongitude = minx;

    northEastLatitude = maxy;
    northEastLongitude = maxx;

    debugPrint('-----southWestLatitude : $southWestLatitude');

    gMap.LatLngBounds bounds = gMap.LatLngBounds(
      gMap.LatLng(southWestLatitude - 0.0015, southWestLongitude),
      gMap.LatLng(northEastLatitude - 0.0015, northEastLongitude),
    );

    map!.fitBounds(bounds);

    map!.panToBounds(bounds);

    map!.zoom = 14;
  }

  bool _hideClients = true;

  bool get hideClients => _hideClients;

  set hideClients(bool value) {
    _hideClients = value;
    // getAllOpenServiceRequests();

    if (value == true) {
      addAllClientsMarkers();
    } else {
      carsMarkers.clear();
      carsMarkers = {};
    }

    emit(HideClientsChanged());
  }

  bool _busyDrivers = true;

  bool get busyDrivers => _busyDrivers;

  set busyDrivers(bool value) {
    _busyDrivers = value;

    if (value == true) {
      addAllWinchMarkers();
    } else {
      busyWinchMarkers.clear();
      busyWinchMarkers = {};
      busyPassengersCarMarkers.clear();
      busyPassengersCarMarkers = {};
    }

    emit(BusyDriversChanged());
  }

  bool _freeDrivers = true;

  bool get freeDrivers => _freeDrivers;

  set freeDrivers(bool value) {
    _freeDrivers = value;

    if (value == true) {
      addAllWinchMarkers();
    } else {
      availableWinchMarkers.clear();
      passengersCarsMarkers.clear();
      availableWinchMarkers = {};
    }

    emit(FreeDriversChanged());
  }

  bool _isWinchVehicle = true;

  bool get isWinchVehicle => _isWinchVehicle;

  set isWinchVehicle(bool value) {
    _isWinchVehicle = value;

    if (value == true) {
      debugPrint('-----isWinchVehicle------');

      addAllWinchMarkers();
    } else {
      availableWinchMarkers.clear();
      passengersCarsMarkers.clear();
      busyWinchMarkers.clear();
      busyPassengersCarMarkers.clear();
    }

    emit(IsWinchVehicleChanged());
  }

  bool _isN300Vehicle = false;

  bool get isN300Vehicle => _isN300Vehicle;

  set isN300Vehicle(bool value) {
    _isN300Vehicle = value;
    emit(IsN300VehicleChanged());
  }

  /// ----------------- Settings -----------------

  SettingTypesModel? settingTypesModel;

  bool isGettingSettingTypesLoading = false;

  void getSettingTypes() async {
    isGettingSettingTypesLoading = true;
    emit(GetSettingTypesLoadingState());

    final result = await _repository.getSettingsTypes();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());

        emit(
          GetSettingTypesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        settingTypesModel = data;
        debugPrint('setting length: ${settingTypesModel!.types!.length}');
        emit(GetSettingTypesSuccessState());
      },
    );
    isGettingSettingTypesLoading = false;
  }

  SettingTypes? _selectedSettingType;

  SettingTypes? get selectedSettingType => _selectedSettingType;

  set selectedSettingType(SettingTypes? value) {
    _selectedSettingType = value;
  }

  TextEditingController baseCostController = TextEditingController();
  TextEditingController costPerKmController = TextEditingController();

  bool isEditingSettingTypeLoading = false;

  void editSettingType() async {
    emit(EditSettingTypeLoadingState());
    isEditingSettingTypeLoading = true;
    final result = await _repository.editSettingsTypes(
      settingId: selectedSettingType!.id!,
      baseCost: int.parse(baseCostController.text),
      costPerKm: double.parse(costPerKmController.text),
      carType: selectedSettingType!.carType!,
    );

    result.fold(
      (l) {
        debugPrint(l.toString());
        isEditingSettingTypeLoading = false;
        emit(EditSettingTypeErrorState(error: l));
      },
      (r) {
        isEditingSettingTypeLoading = false;
        emit(EditSettingTypeSuccessState());
      },
    );
  }

  /// ----------------- service request search -----------------

  bool isSearchingServiceRequestLoading = false;

  bool _isSearchingServiceRequest = false;

  bool get isSearchingServiceRequest => _isSearchingServiceRequest;

  set isSearchingServiceRequest(bool value) {
    _isSearchingServiceRequest = value;
    emit(IsSearchingServiceRequestChanged());
  }

  TextEditingController searchByNameController = TextEditingController();
  TextEditingController searchByIDController = TextEditingController();
  TextEditingController searchByPhoneNumberController = TextEditingController();

  GetAllServicesRequests? serviceRequestsSearchResult;

  void searchServiceRequest() async {
    isSearchingServiceRequestLoading = true;
    isSearchingServiceRequest = true;
    emit(SearchServiceRequestLoadingState());

    final result = await _repository.serviceRequestSearch(
      serviceRequestId: searchByIDController.text.isNotEmpty ? searchByIDController.text : null,
      clientName: searchByNameController.text.isNotEmpty ? searchByNameController.text : null,
      clientPhoneNumber: searchByPhoneNumberController.text.isNotEmpty ? searchByPhoneNumberController.text : null,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isSearchingServiceRequestLoading = false;
        emit(
          SearchServiceRequestErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        serviceRequestsSearchResult = data;
        isSearchingServiceRequestLoading = false;
        emit(SearchServiceRequestSuccessState());
      },
    );
    isSearchingServiceRequestLoading = false;
  }

  /// ----------------- service request filter -----------------

  FilterTypes _selectedFilterType = FilterTypes.all;

  FilterTypes get selectedFilterType => _selectedFilterType;

  set selectedFilterType(FilterTypes value) {
    _selectedFilterType = value;
    if (value == FilterTypes.serviceType) {
      getServiceRequestTypes();
    }
    emit(SelectedFilterTypeChanged());
  }

  TextEditingController statusFilterController = TextEditingController();

  ServiceStatus _selectedServiceStatus = ServiceStatus.all;

  ServiceStatus get selectedServiceStatus => _selectedServiceStatus;

  set selectedServiceStatus(ServiceStatus value) {
    _selectedServiceStatus = value;
    statusFilterController.text = value.name;
    emit(SelectedServiceStatusChanged());
  }

  TextEditingController serviceTypeFilterController = TextEditingController();

  ServiceRequestsType? _selectedServiceRequestType;

  ServiceRequestsType? get selectedServiceRequestType => _selectedServiceRequestType;

  set selectedServiceRequestType(ServiceRequestsType? value) {
    _selectedServiceRequestType = value;
    serviceTypeFilterController.text = value?.enName ?? '';
    emit(SelectedServiceRequestTypeChanged());
  }

  List<Rules> clientTypesList = [
    Rules.client,
    Rules.Super,
    Rules.CallCenter,
    Rules.Corporate,
  ];

  TextEditingController clientTypeFilterController = TextEditingController();

  Rules _selectedFilterClientType = Rules.none;

  Rules get selectedFilterClientType => _selectedFilterClientType;

  void setSelectedFilterClientType(Rules value) {
    _selectedFilterClientType = value;
    clientTypeFilterController.text = value.name;
    emit(SelectedClientTypeState());
  }

  void clearFilters() {
    selectedFilterType = FilterTypes.all;
    selectedServiceStatus = ServiceStatus.all;
    selectedServiceRequestType = null;
    setSelectedFilterClientType(Rules.none);
    searchByNameController.clear();
    searchByIDController.clear();
    searchByPhoneNumberController.clear();
    statusFilterController.clear();
    serviceTypeFilterController.clear();
    clientTypeFilterController.clear();
    isDESCSotring = true;
    selectedSortingBy = null;
  }

  bool isDESCSotring = true;

  Map<String, String> sortingByMap = {
    'id': 'ID',
    'createdAt': 'Created At',
    'fees': 'Fees',
  };

  bool isSortById = false;

  bool isSortByDate = false;

  bool isSortByFees = false;

  void changeSortingType({
    bool isSortById = false,
    bool isSortByDate = false,
    bool isSortByFees = false,
  }) {
    if (isSortById) {
      this.isSortById = true;
      this.isSortByDate = false;
      this.isSortByFees = false;
    } else if (isSortByDate) {
      this.isSortById = false;
      this.isSortByDate = true;
      this.isSortByFees = false;
    } else if (isSortByFees) {
      this.isSortById = false;
      this.isSortByDate = false;
      this.isSortByFees = true;
    }
  }

  void sortServiceRequests() {
    isDESCSotring = !isDESCSotring;
    emit(SortServiceRequestsState());
  }

  String? _selectedSortingBy;

  String? get selectedSortingBy => _selectedSortingBy;

  set selectedSortingBy(String? value) {
    _selectedSortingBy = value;
    emit(SelectedSortingByChanged());
  }

  String getServiceRequestStatusName(String status) {
    String name = '';
    for (var element in ServiceRequestStatus.values) {
      debugPrint('-----${element.name}------');
      if (element.name == status) {
        name = element.value;
        break;
      } else {
        name = '';
      }
    }
    return name;
  }

  /// ----------------- get highest discount -----------------

  String getHighestDiscount(List<int> discounts) {
    String highestDiscount = '';
    if (discounts.isNotEmpty) {
      discounts.sort((a, b) => a.compareTo(b));
      debugPrint('-----highest discount>>>>>> ${discounts.last}------');
      highestDiscount = discounts.last.toString();
    }
    return highestDiscount;
  }

  /// ----------------- get config -----------------

  quill.QuillController englishTermsController = quill.QuillController.basic();
  quill.QuillController arabicTermsController = quill.QuillController.basic();

  List<String> underMaintainingOptions = [
    'True',
    'False',
  ];

  Config? configModel;

  bool isGetAllConfigLoading = false;

  TextEditingController iosVersionController = TextEditingController();
  TextEditingController androidVersionController = TextEditingController();
  TextEditingController limitDurationController = TextEditingController();
  TextEditingController limitDistanceController = TextEditingController();
  TextEditingController underMaintainingController = TextEditingController();
  bool isApplicationUnderMaintaining = false;

  String? _selectedUnderMaintainingOption;
  String? get selectedUnderMaintainingOption => _selectedUnderMaintainingOption;
  set selectedUnderMaintainingOption(String? value) {
    _selectedUnderMaintainingOption = value;
    if (value == 'True') {
      underMaintainingController.text = 'True';
      isApplicationUnderMaintaining = true;
    } else {
      underMaintainingController.text = 'False';
      isApplicationUnderMaintaining = false;
    }
    emit(SelectedUnderMaintainingOptionChanged());
  }


  TextEditingController inspectorIosVersionController = TextEditingController();
  TextEditingController inspectorAndroidVersionController = TextEditingController();
  TextEditingController inspectorUnderMaintainingController = TextEditingController();
  bool inspectorIsApplicationUnderMaintaining = false;

  String? _inspectorSelectedUnderMaintainingOption;
  String? get inspectorSelectedUnderMaintainingOption => _selectedUnderMaintainingOption;
  set inspectorSelectedUnderMaintainingOption(String? value) {
    _inspectorSelectedUnderMaintainingOption = value;
    if (value == 'True') {
      inspectorUnderMaintainingController.text = 'True';
      inspectorIsApplicationUnderMaintaining = true;
    } else {
      inspectorUnderMaintainingController.text = 'False';
      inspectorIsApplicationUnderMaintaining = false;
    }
    emit(InspectorSelectedUnderMaintainingOptionChanged());
  }



  void getConfig() async {
    isGetAllConfigLoading = true;
    emit(GetAllConfigLoadingState());

    final result = await _repository.getAllConfig();

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllConfigLoading = false;
        emit(
          GetAllConfigErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        configModel = data.config![0];
        iosVersionController.text = configModel!.minimumIOSVersion ?? '';
        androidVersionController.text = configModel!.minimumAndroidVersion ?? '';
        limitDurationController.text = configModel!.durationLimit.toString();
        limitDistanceController.text = configModel!.distanceLimit.toString();
        underMaintainingController.text = configModel!.underMaintaining ?? false ? 'True' : 'False';

        inspectorIosVersionController.text = configModel!.minimumIOSVersionInspector ?? '';
        inspectorAndroidVersionController.text = configModel!.minimumAndroidVersionInspector ?? '';
        inspectorUnderMaintainingController.text = configModel!.underMaintainingInspector ?? false ? 'True' : 'False';

        englishTermsController = quill.QuillController(
          document: quill.Document.fromDelta(
            quill.Delta.fromJson(
              [
                {"insert": configModel!.termsAndConditionsEn ?? ''}
              ],
            ),
          ),
          selection: const TextSelection.collapsed(offset: 0),
        );
        arabicTermsController = quill.QuillController(
          document: quill.Document.fromDelta(
            quill.Delta.fromJson(
              [
                {"insert": configModel!.termsAndConditionsAr ?? ''}
              ],
            ),
          ),
          selection: const TextSelection.collapsed(offset: 0),
        );
        isGetAllConfigLoading = false;
        emit(GetAllConfigSuccessState());
      },
    );
  }

  void updateConfig() async {
    emit(UpdateConfigLoadingState());
    final result = await _repository.updateConfig(
      minimumIOSVersion: iosVersionController.text,
      minimumAndroidVersion: androidVersionController.text,
      durationLimit: limitDurationController.text,
      distanceLimit: limitDistanceController.text,
      underMaintaining: isApplicationUnderMaintaining,
      termsAr: arabicTermsController.document.toPlainText(),
      termsEn: englishTermsController.document.toPlainText(),

      minimumIOSVersionInspector: inspectorIosVersionController.text,
      minimumAndroidVersionInspector: inspectorAndroidVersionController.text,
      underMaintainingInspector: inspectorIsApplicationUnderMaintaining,
    );
    result.fold(
          (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        emit(
          UpdateConfigErrorState(
            error: failure,
          ),
        );
      },
          (data) {
        emit(UpdateConfigSuccessState());
      },
    );
  }



  /// ----------------- get all admin Cars -----------------

  AllAdminCarsModel? allAdminCarsModel;

  bool isGetAllAdminCarsLoading = false;
  bool isGetAllAdminCarsLoadingForPagination = false;

  void getAllAdminCars({
    String? page,
    bool isFirstCall = true,
  }) async {
    if (isFirstCall) {
      isGetAllAdminCarsLoading = true;
      emit(GetAllAdminCarsLoadingState());
    } else {
      isGetAllAdminCarsLoadingForPagination = true;
    }

    final result = await _repository.getAllAdminCars(
      page: page ?? '1',
      size: '10',
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllAdminCarsLoading = false;
        emit(
          GetAllAdminCarsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        debugPrint('all admin cars length is ${data.cars!.length}');
        allAdminCarsModel = data;
        totalTableItems = data.totalCount!;
        isGetAllAdminCarsLoading = false;

        if (requestCounter == 1) {
          emit(GetAllAdminCarsSuccessState());
          requestCounter = 0;
        } else {
          isGetAllAdminCarsLoadingForPagination = false;
          emit(
            GetAllAdminCarsSuccessSecondState(),
          );
        }
        debugPrint('isGetAllAdminCarsLoadingForPagination is $isGetAllAdminCarsLoadingForPagination');
      },
    );
  }

// ----------------- handle date selection -----------------

// end date must be after  one year from start date and not be before today

  DateTime? _policyStartDate;

  DateTime? get policyStartDate => _policyStartDate;

  set policyStartDate(DateTime? value) {
    _policyStartDate = value;
    emit(PolicyStartDateChanged());
    policyEndDate = null;
    policyEndDateController.clear();
    policyEndDate = policyStartDate!.add(
      const Duration(
        days: 375,
      ),
    );
    debugPrint('policy end date is $policyEndDate');
  }

  DateTime? _policyEndDate;

  DateTime? get policyEndDate => _policyEndDate;

  set policyEndDate(DateTime? value) {
    if (value != null && value.isBefore(DateTime.now())) {
      _policyEndDate = null;
      // _policyEndDate = value;

      HelpooInAppNotification.showMessage(message: 'End date must be after today', color: Colors.red);
      emit(PolicyEndDateChanged());
      return;
    }
    _policyEndDate = value;

    emit(PolicyEndDateChanged());
  }

  /// ----------------- text form field checker -----------------

  bool checkIfControllerEmpty({required TextEditingController controller}) {
    if (controller.text.isEmpty) {
      return true;
    }
    return false;
  }

  /// ----------------- send notification -----------------

  void sendNotification({
    required String fcmtoken,
    required String title,
    required String body,
    String? id,
    String? type,
    bool? isInspectionNotification,
  }) async {
    emit(SendNotificationLoadingState());
    final result = await _repository.sendNotification(
      fcmToken: fcmtoken,
      title: title,
      body: body,
      id: id,
      type: type,
      isInspectionNotification: isInspectionNotification,
    );

    result.fold(
      (failure) async {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        HelpooInAppNotification.showErrorMessage(message: failure.toString());
        emit(SendNotificationErrorState(error: failure));
      },
      (data) async {
        debugPrint('-----success------');
        emit(SendNotificationSuccessState());
      },
    );
  }

// ----------- open new tab

  void openNewTab(String path) {
    html.window.open(path, '_blank');
    emit(NewPageOpenedState());
  }

  void openGoogleMapsTab() {
    if (selectedServiceRequestModel!.status != ServiceRequestStatus.confirmed.name &&
        selectedServiceRequestModel!.status != ServiceRequestStatus.accepted.name) {
      _openGoogleMapsByCoordsByAdress(
          origin: selectedServiceRequestModel!.location!.clientAddress!, destination: selectedServiceRequestModel!.location!.destinationAddress!);
    } else {
      _openGoogleMapsByCoords(
        origin: LatLng(
          selectedServiceRequestModel!.driver!.location!.latitude!,
          selectedServiceRequestModel!.driver!.location!.longitude!,
        ),
        destination: LatLng(
          double.parse(selectedServiceRequestModel!.location!.clientLatitude!),
          double.parse(selectedServiceRequestModel!.location!.clientLatitude!),
        ),
      );
    }
  }

  void _openGoogleMapsByCoordsByAdress({required String origin, required String destination}) {
    const baseURL = 'https://www.google.com/maps/dir/';
    final encodedURL = '$baseURL$origin/$destination';

    html.window.open(encodedURL, 'google_maps');
  }

  void _openGoogleMapsByCoords({required LatLng origin, required LatLng destination}) {
    const baseURL = 'https://www.google.com/maps/dir/';
    final encodedURL = '$baseURL${origin.latitude},${origin.longitude}/${destination.latitude},${destination.longitude}';

    html.window.open(encodedURL, 'google_maps');
  }

  DistanceAndDuration? getDistanceAndDurationResponse;
  String localDistance = "";
  String localDuration = "";

  Future<GetDistanceAndDurationResponse?> getRequestTimeAndDistance({
    required ServiceRequestModel req,
  }) async {
    emit(GetRequestTimeAndDistanceByIdLoadingState());

    getDistanceAndDurationResponse = null;
    localDistance = "";
    localDuration = "";

    await appBloc.getRequestById(reqId: req.id!).then((value) async {
      if (clickedReqModel!.req!.location!.lastUpdatedDistanceAndDuration == null ||
          clickedReqModel!.req!.location!.lastUpdatedDistanceAndDuration!.lastUpdatedStatus != clickedReqModel!.req!.status) {
        GetRequestDurationAndDistanceDTO getRequestDurationAndDistanceDto = GetRequestDurationAndDistanceDTO(
          serviceRequestId: clickedReqModel!.req!.id!,
          oldStatus: clickedReqModel!.oldRequestStatus?.enName,
          prevClientLocation: clickedReqModel!.firstClientLocation != null
              ? LatLng(clickedReqModel!.firstClientLocation!.latitude.toDouble(), clickedReqModel!.firstClientLocation!.longitude)
              : null,
          oldDest: clickedReqModel!.firstClientDestination != null
              ? LatLng(clickedReqModel!.firstClientDestination!.latitude.toDouble(), clickedReqModel!.firstClientDestination!.longitude)
              : null,
          driverLatLng: LatLng(clickedReqModel!.req!.driver!.location!.latitude!, clickedReqModel!.req!.driver!.location!.longitude!),
          curClientLocation:
              LatLng(double.parse(clickedReqModel!.req!.location!.clientLatitude!), double.parse(clickedReqModel!.req!.location!.clientLongitude!)),
        );

        final result = await _repository.getRequestTimeAndDistance(getRequestDurationAndDistanceDto: getRequestDurationAndDistanceDto);

        result.fold(
          (failure) {
            debugPrint(failure);
            emit(GetRequestTimeAndDistanceByIdErrorState(error: failure));
            return null;
          },
          (data) {
            // debugPrint("getRequestDurationAndDistanceDto  ${data.distanceAndDuration?.toJson().toString()}");

            getDistanceAndDurationResponse = data.distanceAndDuration!;
            localDistance = getDistanceAndDurationResponse!.driverDistanceMatrix!.distance!.text!;
            localDuration = getDistanceAndDurationResponse!.driverDistanceMatrix!.duration!.text!;
            emit(GetRequestTimeAndDistanceByIdSuccessState());
            return data;
          },
        );
      } else {

        DateTime lastHitDate = DateTime.parse(clickedReqModel!.req!.location!.lastUpdatedDistanceAndDuration!.createdAt);
        double lastHitDateSecs = lastHitDate.millisecondsSinceEpoch / 1000;
        double nowSecs = DateTime.now().millisecondsSinceEpoch / 1000;
        double totalRemainingMetres = clickedReqModel!.req!.location!.lastUpdatedDistanceAndDuration!.driverDistanceValue;
        double durationSecs = clickedReqModel!.req!.location!.lastUpdatedDistanceAndDuration!.driverDurationValue;
        double mPerSecRatio = totalRemainingMetres / durationSecs;
        double etaSecs = lastHitDateSecs + durationSecs;

        double restSecs = etaSecs - nowSecs;
        localDuration = '${restSecs ~/ 60} minutes';

        debugPrint(
            '---------asd \n now: ${nowSecs / 60} \n lastHit: ${lastHitDateSecs / 60} \n duration: ${durationSecs / 60} \n eta: ${etaSecs / 60} \n rest: ${restSecs / 60} \n ---------');

        double restMetres = (restSecs * mPerSecRatio);
        localDistance = '${restMetres / 1000} km';
      }
    });
    return null;
  }

// cancel service request with payment

  TextEditingController cancelWithPaymentReasonController = TextEditingController();

  TextEditingController cancelWithPaymentFeesController = TextEditingController();

  bool isCancelWithPaymentLoading = false;

  void cancelServiceRequestWithPayment() async {
    emit(CancelServiceRequestWithPaymentLoadingState());
    isCancelWithPaymentLoading = true;
    final result = await _repository.cancelServiceRequestWithPayment(
      id: selectedServiceRequestId.toString(),
      reason: cancelWithPaymentReasonController.text,
      fees: cancelWithPaymentFeesController.text,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCancelWithPaymentLoading = false;
        emit(
          CancelServiceRequestWithPaymentErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCancelWithPaymentLoading = false;
        emit(CancelServiceRequestWithPaymentSuccessState());
      },
    );
  }

// get all vehicles

  VehiclesModel? vehiclesModel;

  bool isGetAllVehiclesLoading = false;

  void getAllVehicles() async {
    emit(GetAllVehiclesLoadingState());
    isGetAllVehiclesLoading = true;
    final result = await _repository.getAllVehicles();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllVehiclesLoading = false;
        emit(
          GetAllVehiclesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllVehiclesLoading = false;
        vehiclesModel = data;
        emit(GetAllVehiclesSuccessState());
      },
    );
  }

// create new vehicle

  TextEditingController vehicleNameController = TextEditingController();

  TextEditingController vehiclePhoneController = TextEditingController();

  TextEditingController vehicleNumberController = TextEditingController();

  TextEditingController vehicleIMEIController = TextEditingController();

  TextEditingController vehicleTypeController = TextEditingController();

  bool isCreateNewVehicleLoading = false;

  void createNewVehicle() async {
    emit(CreateNewVehicleLoadingState());
    isCreateNewVehicleLoading = true;
    CreateNewVehicleModel data = CreateNewVehicleModel(
      vehicleName: vehicleNameController.text,
      phoneNumber: handlePhoneNumber(phoneNum: vehiclePhoneController.text),
      vehicleNumber: vehicleNumberController.text,
      imei: vehicleIMEIController.text,
      vehicleType: selectedVehicleType?.id.toString() ?? '',
      url: '',
      carServiceType: selectedVehicleTypesList.map((e) => e.id!).toList(),
      vehiclePlate:
          '${policyCarPlateNumberController.text}-${policyCarFirstCharController.text}-${policyCarSecondCharController.text}-${policyCarThirdCharController.text}',
    );
    final result = await _repository.createNewVehicle(data: data);
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCreateNewVehicleLoading = false;
        emit(
          CreateNewVehicleErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCreateNewVehicleLoading = false;
        clearCreateNewVehicleData();
        emit(CreateNewVehicleSuccessState());
      },
    );
  }

  void clearCreateNewVehicleData() {
    vehicleNameController.clear();
    vehiclePhoneController.clear();
    vehicleNumberController.clear();
    vehicleIMEIController.clear();
    vehicleTypeController.clear();
    policyCarPlateNumberController.clear();
    policyCarFirstCharController.clear();
    policyCarSecondCharController.clear();
    policyCarThirdCharController.clear();
    selectedVehicleTypesList.clear();
  }

  VehicleTypeModel? _selectedVehicleType;

  VehicleTypeModel? get selectedVehicleType => _selectedVehicleType;

  set selectedVehicleType(VehicleTypeModel? value) {
    _selectedVehicleType = value;
    vehicleTypeController.text = value!.typeName ?? '';
    emit(VehicleTypeSelectedState());
  }

  List<ServiceRequestsType> selectedVehicleTypesList = [];

  void addVehicleServiceTypeToList(ServiceRequestsType vehicleServiceType) {
    if (selectedVehicleTypesList.contains(vehicleServiceType)) {
      return;
    } else {
      selectedVehicleTypesList.add(vehicleServiceType);
    }
    emit(AddVehicleTypeToListState());
  }

  void removeVehicleServiceTypeFromList(ServiceRequestsType vehicleServiceType) {
    selectedVehicleTypesList.remove(vehicleServiceType);
    emit(RemoveVehicleTypeFromListState());
  }

  void clearSelectedVehicleServiceTypesList() {
    selectedVehicleTypesList.clear();
    emit(ClearSelectedVehicleTypesListState());
  }

// get vehicle types

  VehiclesTypesModel? vehiclesTypesModel;

  bool isGetAllVehiclesTypesLoading = false;

  void getAllVehiclesTypes() async {
    emit(GetAllVehiclesTypesLoadingState());
    isGetAllVehiclesTypesLoading = true;
    final result = await _repository.getAllVehiclesTypes();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllVehiclesTypesLoading = false;
        emit(
          GetAllVehiclesTypesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllVehiclesTypesLoading = false;
        vehiclesTypesModel = data;
        emit(GetAllVehiclesTypesSuccessState());
      },
    );
  }

  ///* get all brokers
  List<Broker> brokersList = [];

  void getAllBrokers() async {
    emit(GetAllBrokersLoadingState());
    final result = await _repository.getAllBrokers();

    result.fold((failure) {
      debugPrint('-----failure------');
      debugPrint(failure.toString());
      emit(GetAllBrokersErrorState(error: failure));
    }, (data) {
      brokersList = data.brokers ?? [];
      emit(GetAllBrokersSuccessState());
    });
  }

// get all users

  UsersModel? usersModel;

  List<Users> clientsUsersList = [];

  List<Users> driversUsersList = [];

  List<Users> inspectorsUsersList = [];

  List<Users> insuranceUsersList = [];

  bool isGetAllUsersLoading = false;

  void getAllUsers() async {
    isSearchingUserByPhone = false;
    isGetAllUsersLoading = true;
    emit(GetAllUsersLoadingState());

    final result = await _repository.getAllUsers();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllUsersLoading = false;
        emit(
          GetAllUsersErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllUsersLoading = false;
        usersModel = data;

// clear lists
        clientsUsersList = [];
        driversUsersList = [];
        inspectorsUsersList = [];
        insuranceUsersList = [];

// add data to lists
        for (var element in usersModel!.users!) {
          if (element.role!.name == 'Client') {
            clientsUsersList.add(element);
          } else if (element.role!.name == 'Driver') {
            driversUsersList.add(element);
          } else if (element.role!.name == 'Inspector') {
            inspectorsUsersList.add(element);
          } else if (element.role!.name == 'Insurance') {
            insuranceUsersList.add(element);
          }
        }
        emit(GetAllUsersSuccessState());
      },
    );
  }

  // search user by phone number

  SearchedUserByPhoneResponseModel? searchUsersByPhoneResponseModel;
  TextEditingController searchUserByPhoneController = TextEditingController();
  bool isSearchingUserByPhoneLoading = false;

  bool _isSearchingUserByPhone = false;
  bool get isSearchingUserByPhone => _isSearchingUserByPhone;
  set isSearchingUserByPhone(bool value) {
    _isSearchingUserByPhone = value;
    if (!value) {
      appBloc.searchUserByPhoneController.clear();
    }
    emit(IsSearchingServiceRequestChanged());
  }

  bool _isSearchingUserByVinNumber = false;
  bool get isSearchingUserByVinNumber => _isSearchingUserByVinNumber;
  set isSearchingUserByVinNumber(bool value) {
    _isSearchingUserByVinNumber = value;
    emit(IsSearchingServiceRequestChanged());
  }

  void searchUserByPhone() async {
    isSearchingUserByPhoneLoading = true;
    isSearchingUserByPhone = true;
    emit(SearchServiceRequestLoadingState());

    final result = await _repository.searchUserByPhone(
      clientPhoneNumber: searchUserByPhoneController.text.isNotEmpty ? searchUserByPhoneController.text : null,
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isSearchingUserByPhoneLoading = false;
        emit(SearchServiceRequestErrorState(error: failure));
      },
      (data) {
        searchUsersByPhoneResponseModel = data;
        isSearchingUserByPhoneLoading = false;
        emit(SearchServiceRequestSuccessState());
      },
    );
    isSearchingUserByPhoneLoading = false;
  }

  // search user by vin number

  existingUserCars.ExistingUserCarsModel? searchCarByVinNumberResponseModel;
  InsuranceCompany? selectedInsuranceComp;
  TextEditingController searchCarVinNumberController = TextEditingController();
  TextEditingController selectedInsuranceCompController = TextEditingController();
  bool isSearchCarByVinNumberLoading = false;

  void searchCarByVinNumber() async {
    isSearchCarByVinNumberLoading = true;
    emit(SearchCarByVinNumberLoadingState());

    final result = await _repository.searchCarsByVinNumber(
      vinNumber: searchCarVinNumberController.text,
      insuranceCompanyId: '${selectedInsuranceComp?.id}',
    );

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isSearchCarByVinNumberLoading = false;
        emit(SearchCarByVinNumberErrorState(error: failure));
      },
      (data) {
        searchCarByVinNumberResponseModel = data;
        isSearchCarByVinNumberLoading = false;
        emit(SearchCarByVinNumberSuccessState());
      },
    );
  }

// create new user

  TextEditingController userNameController = TextEditingController();

  TextEditingController userPhoneController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  TextEditingController userRoleController = TextEditingController();

  TextEditingController userIdentifierController = TextEditingController();

  TextEditingController userCorporateCompanyController = TextEditingController();

  TextEditingController selectedUserInsuranceCompController = TextEditingController();

  Roles? _selectedUserRole;

  Roles? get selectedUserRole => _selectedUserRole;

  set selectedUserRole(Roles? value) {
    _selectedUserRole = value;
    userRoleController.text = value!.name!;
    if (_selectedUserRole != null && _selectedUserRole?.name == 'Corporate') {
      if (corporatesModel == null) {
        getAllCorporates();
      }
    }
    if (_selectedUserRole != null && _selectedUserRole?.name == 'Insurance') {
      if (corporatesModel == null) {
        getAllInsuranceCompanies();
      }
    }
    emit(UserRoleSelectedState());
  }

  Rows? _selectedCorporateForUser;

  Rows? get selectedCorporateForUser => _selectedCorporateForUser;

  set selectedCorporateForUser(Rows? value) {
    _selectedCorporateForUser = value;
    userCorporateCompanyController.text = value!.enName!;
    emit(SelectedCorporateForUserChanged());
  }

  InsuranceCompany? _selectedUserInsuranceComp;

  InsuranceCompany? get selectedUserInsuranceComp => _selectedUserInsuranceComp;

  set selectedUserInsuranceComp(InsuranceCompany? value) {
    _selectedUserInsuranceComp = value;
    selectedUserInsuranceCompController.text = value!.enName!;
    emit(UserRoleSelectedState());
  }

  void clearCreateUserControllers() {
    userNameController.clear();
    userPhoneController.clear();
    userEmailController.clear();
    userPasswordController.clear();
    userRoleController.clear();
    selectedUserInsuranceCompController.clear();
    userIdentifierController.clear();
    userCorporateCompanyController.clear();
  }

  bool isCreateNewUserLoading = false;
  CreateUserResponseModel? createUserResponseModel;
  CreateNewUserDTO? createNewUserDTO;

  void createUser() async {
    emit(CreateNewUserLoadingState());
    isCreateNewUserLoading = true;

    createNewUserDTO = CreateNewUserDTO(
      name: userNameController.text,
      phoneNumber: handlePhoneNumber(phoneNum: userPhoneController.text),
      email: userEmailController.text,
      password: userPasswordController.text,
      roleId: selectedUserRole?.id.toString() ?? '',
      identifier: userIdentifierController.text,
      corporateCompanyId: selectedCorporateForUser?.id,
      insuranceCompany: selectedUserInsuranceComp?.id,
    );

    final result = await _repository.createNewUser(
      data: createNewUserDTO!,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCreateNewUserLoading = false;
        emit(
          CreateNewUserErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCreateNewUserLoading = false;
        createUserResponseModel = data;
        emit(CreateNewUserSuccessState());
      },
    );
  }

  bool isActivateCarLoading = false;

  void activateCar() async {
    isActivateCarLoading = true;

    emit(ActivateCarLoadingState());
    ActivateCarDTO activateCarDTO = ActivateCarDTO(
      // ManufacturerId: selectedUserCar?.manufacturer?.id.toString(),
      ManufacturerId: selectedManufacturer?.id.toString(),
      CarModelId: selectedCarModel?.id.toString(),
      year: selectedYearOfManufacture?.toString(),
      color: selectedCarColor?.toString(),
      vin_number: selectedUserCar?.vinNumber.toString(),
      plateNumber: plateNumber,
      ClientId: createUserResponseModel?.user?.clientId.toString(),
      active: true,
      insuranceCompanyId: selectedInsuranceComp?.id.toString(),
    );

    final result = await _repository.activateCar(
      activateCarDTO: activateCarDTO,
      carId: selectedUserCar?.id.toString() ?? '',
    );

    result.fold(
      (l) {
        isActivateCarLoading = false;
        HelpooInAppNotification.showErrorMessage(message: 'Error while activating car.');
        emit(ActivateCarErrorState(error: l));
      },
      (r) {
        isActivateCarLoading = false;
        HelpooInAppNotification.showSuccessMessage(message: 'Car added to user successfully.');
        emit(ActivateCarSuccessState());
      },
    );
  }

// get all roles

  RolesModel? rolesModel;

  bool isGetAllRolesLoading = false;

  void getAllRoles() async {
    emit(GetAllRolesLoadingState());
    isGetAllRolesLoading = true;
    final result = await _repository.getAllRoles();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllRolesLoading = false;
        emit(
          GetAllRolesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllRolesLoading = false;
        rolesModel = data;
        emit(GetAllRolesSuccessState());
      },
    );
  }

  bool sideMenuCollapsed = false;

  void toggleSideMenu() {
    sideMenuCollapsed = !sideMenuCollapsed;
    emit(ToggleSideMenuState());
  }

// get widget width

  double getWidgetWidth() {
    return 90.w;
    if (sideMenuCollapsed) {
      return MediaQuery.of(navigatorKey.currentContext!).size.width;
    } else {
      return 1122;
    }
  }

  double widgetWidth = 1122;

  void setWidgetWidth(double width) {
    widgetWidth = width;
    emit(SetWidgetWidthState());
  }

// get all corporates

  CorporatesModel? corporatesModel;

  bool isGetAllCorporatesLoading = false;

  void getAllCorporates() async {
    emit(GetAllCorporatesLoadingState());
    isGetAllCorporatesLoading = true;
    final result = await _repository.getAllCorporates();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllCorporatesLoading = false;
        emit(
          GetAllCorporatesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllCorporatesLoading = false;
        corporatesModel = data;
        emit(GetAllCorporatesSuccessState());
      },
    );
  }

  int? _selectedCorporateId;

  int? get selectedCorporateId => _selectedCorporateId;

  set selectedCorporateId(int? value) {
    _selectedCorporateId = value;
    debugPrint('selected corporate id is $value');
    emit(SelectedCorporateIdChanged());
  }

// search corporates in local list

  bool isSearchingCorporates = false;

  TextEditingController searchCorporatesController = TextEditingController();

  List<Rows> searchedCorporatesList = [];

  void searchCorporates(String searchKey) {
    searchedCorporatesList = [];
    if (searchKey.isNotEmpty) {
      isSearchingCorporates = true;
      debugPrint('search key is $searchKey');
      for (var element in corporatesModel!.rows!) {
        if (element.enName!.toLowerCase().contains(searchKey) || element.arName!.toLowerCase().contains(searchKey)) {
          searchedCorporatesList.add(element);
        }
      }
      debugPrint('searched corporates list length is ${searchedCorporatesList.length}');
    } else {
      isSearchingCorporates = false;
    }
    emit(SearchCorporatesState());
  }

//create new corporate

  TextEditingController corporateEnNameController = TextEditingController();

  TextEditingController corporateArNameController = TextEditingController();

  TextEditingController corporateDiscountRatioController = TextEditingController();

  TextEditingController corporateEndDateController = TextEditingController();

  DateTime? _corporateEndDate;

  DateTime? get corporateEndDate => _corporateEndDate;

  set corporateEndDate(DateTime? value) {
    _corporateEndDate = value;
    emit(CorporateEndDateChanged());
  }

  bool _isDeferredPayment = false;

  bool get isDeferredPayment => _isDeferredPayment;

  set isDeferredPayment(bool value) {
    _isDeferredPayment = value;
    emit(IsDeferredPaymentChanged());
  }

  bool _isCashPayment = false;

  bool get isCashPayment => _isCashPayment;

  set isCashPayment(bool value) {
    _isCashPayment = value;
    emit(IsCashPaymentChanged());
  }

  bool _isCreditPayment = false;

  bool get isCreditPayment => _isCreditPayment;

  set isCreditPayment(bool value) {
    _isCreditPayment = value;
    emit(IsCreditPaymentChanged());
  }

  bool _isOnlinePayment = false;

  bool get isOnlinePayment => _isOnlinePayment;

  set isOnlinePayment(bool value) {
    _isOnlinePayment = value;
    emit(IsOnlinePaymentChanged());
  }

  void clearCreateCorporateControllers() {
    corporateEnNameController.clear();
    corporateArNameController.clear();
    corporateDiscountRatioController.clear();
    corporateEndDateController.clear();
    corporateEndDate = null;
    isDeferredPayment = false;
    isCashPayment = false;
    isCreditPayment = false;
    isOnlinePayment = false;
  }

  bool isCreateNewCorporateLoading = false;

  void createNewCorporate() async {
    emit(CreateNewCorporateLoadingState());
    isCreateNewCorporateLoading = true;

    CreateNewCorporateModel data = CreateNewCorporateModel(
      enName: corporateEnNameController.text,
      arName: corporateArNameController.text,
      discountRatio: corporateDiscountRatioController.text.isEmpty ? 0 : int.parse(corporateDiscountRatioController.text),
      endDate: corporateEndDateController.text,
      deferredPayment: isDeferredPayment,
      cash: isCashPayment,
      credit: isCreditPayment,
      online: isOnlinePayment,
    );
    final result = await _repository.createNewCorporate(
      data: data,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCreateNewCorporateLoading = false;
        emit(
          CreateNewCorporateErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCreateNewCorporateLoading = false;
        clearCreateCorporateControllers();
        emit(CreateNewCorporateSuccessState());
      },
    );
  }

  Branch? selectedCorpBranch ;
  List<Branch>? corpBranches;

  bool isGetAllCorpBranchesLoading = false;

  void getAllCorpBranches() async {
    emit(GetAllBranchesLoadingState());
    isGetAllCorpBranchesLoading = true;

    final result = await _repository.getAllCorpBranches(corpId: '${currentCompanyId != null && currentCompanyId != 0 ? currentCompanyId : selectedCorporateId}');

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllCorpBranchesLoading = false;
        emit(GetAllBranchesErrorState(error: failure),
        );
      },
      (data) {
        isGetAllCorpBranchesLoading = false;
        corpBranches = data.branches;
        emit(GetAllBranchesSuccessState());
      },
    );
  }

  bool isGetCorpBranchByIdLoading = false;

  void getCorpBranchById({required String branchId}) async {
    emit(GetCorpBranchByIdLoadingState());
    isGetCorpBranchByIdLoading = true;

    final result = await _repository.getCorpBranchById(branchId: branchId);

    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetCorpBranchByIdLoading = false;
        emit(GetCorpBranchByIdErrorState(error: failure),
        );
      },
      (data) {
        isGetCorpBranchByIdLoading = false;
        selectedCorpBranch = data.branch;
        emit(GetCorpBranchByIdSuccessState());
      },
    );
  }


// set popup width

  double popupWidth = 1000;

  void setPopupWidth(double width) {
    debugPrint('popup width is $width');
    popupWidth = width;
    emit(SetPopupWidthState());
  }

//******************************************************************************
  ///* get all Packages
  bool isGetAllPackagesLoading = false;
  List<PackageModel> allPackages = [];

  void getAllPackages({
    bool isForCorporate = false,
    bool isForInsurance = false,
    bool isForBroker = false,
  }) async {
    emit(GetAllPackagesLoadingState());
    isGetAllPackagesLoading = true;
    final result = await _repository.getAllPackages(
      isForCorporate: isForCorporate,
      isForInsurance: isForInsurance,
      isForBroker: isForBroker,
      insuranceId: currentCompanyId.toString(),
      corporateId: currentCompanyId.toString(),
      brokerId: generalID.toString(),
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllPackagesLoading = false;
        emit(
          GetAllPackagesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllPackagesLoading = false;
        allPackages = data.packages ?? [];
        debugPrint('all packages length is ${allPackages.length}');

        emit(GetAllPackagesSuccessState(
          role: isForCorporate
              ? Rules.Corporate
              : isForInsurance
                  ? Rules.Insurance
                  : isForBroker
                      ? Rules.Broker
                      : Rules.none,
        ));
      },
    );
  }

//******************************************************************************
  ///* create Package
  TextEditingController packageNameEnController = TextEditingController();

  TextEditingController packageNameArController = TextEditingController();

  TextEditingController packageDescriptionENController = TextEditingController();

  TextEditingController packageDescriptionARController = TextEditingController();

  TextEditingController packageFeesController = TextEditingController();

  TextEditingController packageMaxDiscountPerTimeController = TextEditingController();
  TextEditingController packageDiscountPercentageController = TextEditingController();
  TextEditingController packageNumberOfDaysController = TextEditingController();
  TextEditingController packageNumberOfCarsController = TextEditingController();
  TextEditingController packageDiscountAfterMaxTimesController = TextEditingController();
  TextEditingController packageIsActiveController = TextEditingController();
  TextEditingController packageIsPrivateController = TextEditingController();
  TextEditingController packageCorporateController = TextEditingController();

  List<TextEditingController> benefitsNameEnControllers = [
    TextEditingController(),
  ];
  List<TextEditingController> benefitsNameArControllers = [
    TextEditingController(),
  ];

  void addControllerToBenefitsList() {
    benefitsNameEnControllers.add(TextEditingController());
    benefitsNameArControllers.add(TextEditingController());
    emit(AddControllerToBenefitsListState());
  }

  void removeControllerFromBenefitsList(int index) {
    benefitsNameEnControllers.removeAt(index);
    benefitsNameArControllers.removeAt(index);
    emit(RemoveControllerFromBenefitsListState());
  }

  Rows? _selectedPackageCorporate;

  Rows? get selectedPackageCorporate => _selectedPackageCorporate;

  set selectedPackageCorporate(Rows? value) {
    _selectedPackageCorporate = value;
    packageCorporateController.text = value != null ? value.enName! : '';
    emit(SelectedPackageCorporateChanged());
  }

// create package

  bool isCreatePackageLoading = false;

  void createPackage() async {
    emit(CreatePackageLoadingState());
    isCreatePackageLoading = true;

    List<CreatePackageBenefits> benefits = [];
    for (int i = 0; i < benefitsNameEnControllers.length; i++) {
      benefits.add(
        CreatePackageBenefits(
          enName: benefitsNameEnControllers[i].text,
          arName: benefitsNameArControllers[i].text,
        ),
      );
    }

    CreatePackageDto data = CreatePackageDto(
      enName: packageNameEnController.text,
      arName: packageNameArController.text,
      enDescription: packageDescriptionENController.text,
      arDescription: packageDescriptionARController.text,
      fees: packageFeesController.text.isEmpty ? 0 : int.parse(packageFeesController.text),
      originalFees: 0,
      maxDiscountPerTime: packageMaxDiscountPerTimeController.text.isEmpty ? 0 : int.parse(packageMaxDiscountPerTimeController.text),
      discountPercentage: packageDiscountPercentageController.text.isEmpty ? 0 : int.parse(packageDiscountPercentageController.text),
      numberOfDays: packageNumberOfDaysController.text.isEmpty ? 0 : int.parse(packageNumberOfDaysController.text),
      numberOfCars: packageNumberOfCarsController.text.isEmpty ? 0 : int.parse(packageNumberOfCarsController.text),
      discountAfterMaxTimes: packageDiscountAfterMaxTimesController.text.isEmpty ? 0 : int.parse(packageDiscountAfterMaxTimesController.text),
      active: packageIsActiveController.text.isEmpty ? false : packageIsActiveController.text == 'true',
      private: packageIsPrivateController.text.isEmpty ? false : packageIsPrivateController.text == 'true',
      corporateCompanyId: selectedPackageCorporate?.id,
      insuranceCompanyId: selectedPackageInsurance?.id,
      brokerId: selectedPackageBroker?.id,
      price: 0,
      benefits: benefits,
    );

    debugPrintFullText(data.toJson().toString());

    final result = await _repository.createPackage(
      data: data,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCreatePackageLoading = false;
        emit(
          CreatePackageErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCreatePackageLoading = false;
        createPackageCustomization(
          packageId: data.newPackage!.newPackage!.id!,
        );
        emit(CreatePackageSuccessState());
      },
    );
  }

  void clearCreatePackageControllers() {
    packageNameEnController.clear();
    packageNameArController.clear();
    packageDescriptionENController.clear();
    packageDescriptionARController.clear();
    packageFeesController.clear();
    packageMaxDiscountPerTimeController.clear();
    packageDiscountPercentageController.clear();
    packageNumberOfDaysController.clear();
    packageNumberOfCarsController.clear();
    packageDiscountAfterMaxTimesController.clear();
    packageIsActiveController.clear();
    packageIsPrivateController.clear();
    benefitsNameEnControllers.clear();
    benefitsNameArControllers.clear();
    emit(ClearCreatePackageControllersState());
  }

// create package customizations

  TextEditingController packageCustomizationMessageController = TextEditingController();

  Map<String, bool> packageCustomizations = {
    'Year': false,
    'Car Brand': false,
    'Car Model': false,
    'Color': false,
    'Vin Number': false,
    'Policy Number': false,
    'Policy Start Date': false,
    'Policy End Date': false,
    'Car Plate': false,
    'Email': false,
    'Insurance Company': false,
  };

  void changePackageCustomization({required String key, required bool value}) {
    packageCustomizations[key] = value;
    emit(ChangePackageCustomizationState());
  }

  void createPackageCustomization({
    required int packageId,
  }) async {
    emit(CreatePackageCustomizationLoadingState());
    isCreatePackageLoading = true;

    PackageCustomizationModel data = PackageCustomizationModel(
      packageId: packageId,
      sms: packageCustomizationMessageController.text,
      year: packageCustomizations['Year']!,
      carBrand: packageCustomizations['Car Brand']!,
      carModel: packageCustomizations['Car Model']!,
      color: packageCustomizations['Color']!,
      vinNumber: packageCustomizations['Vin Number']!,
      policyNumber: packageCustomizations['Policy Number']!,
      policyStartDate: packageCustomizations['Policy Start Date']!,
      policyEndDate: packageCustomizations['Policy End Date']!,
      carPlate: packageCustomizations['Car Plate']!,
      email: packageCustomizations['Email']!,
      insuranceCompanyId: packageCustomizations['Insurance Company']!,
    );

    final result = await _repository.createPackageCustomization(
      data: data,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isCreatePackageLoading = false;
        emit(
          CreatePackageCustomizationErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isCreatePackageLoading = false;
        packageCustomizationMessageController.clear();
        packageCustomizations.forEach((key, value) {
          packageCustomizations[key] = false;
        });
        clearCreatePackageControllers();
        emit(CreatePackageCustomizationSuccessState());
      },
    );
  }

//get package users

  int _selectedPackageId = 0;

  int get selectedPackageId => _selectedPackageId;

  set selectedPackageId(int value) {
    _selectedPackageId = value;
    emit(ChangeSelectedPackageIdState());
  }

  bool isGetPackageUsersLoading = false;

  PackageUsersModel? packageUsersModel;

  void getPackageUsers({
    bool isForCompany = false,
    int packageId = 0,
  }) async {
    emit(GetPackageUsersLoadingState());
    isGetPackageUsersLoading = true;

    final result = await _repository.getPackageUsers(
      packageId: isForCompany ? packageId : selectedPackageId,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetPackageUsersLoading = false;
        emit(
          GetPackageUsersErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetPackageUsersLoading = false;
        packageUsersModel = data;
        debugPrint('client by package length ${packageUsersModel?.clients?.length ?? 0}');
        emit(GetPackageUsersSuccessState());
      },
    );
  }

// get package customization

  bool isGetPackageCustomizationLoading = false;

  GetPackageCustomizationModel? packageCustomizationModel;

  Future<void> getPackageCustomization({bool exportSheetAfterSuccess = true}) async {
    emit(GetPackageCustomizationLoadingState());
    isGetPackageCustomizationLoading = true;

    final result = await _repository.getPackageCustomization(
      packageId: selectedPackageId,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetPackageCustomizationLoading = false;
        emit(
          GetPackageCustomizationErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetPackageCustomizationLoading = false;
        packageCustomizationModel = data;
        emit(GetPackageCustomizationSuccessState(exportSheetAfterSuccess: exportSheetAfterSuccess));
      },
    );
  }

// export excel template for package Customization

  bool isExportExcelTemplateLoading = false;

  Future<void> exportExcelTemplate({List<PackageBulkUserModel>? list, bool exportAfterFail = false}) async {
    emit(ExportExcelTemplateLoadingState());
    isExportExcelTemplateLoading = true;

    // add excel columns

    List<List<String>> packageExcelColumns = [[]];

    // add columns names to excel file based on customization data

    if (packageCustomizationModel!.customization!.name!) {
      packageExcelColumns[0].add('Name');
    }
    if (packageCustomizationModel!.customization!.phoneNumber!) {
      packageExcelColumns[0].add('Phone Number');
    }
    if (packageCustomizationModel!.customization!.email!) {
      packageExcelColumns[0].add('Email');
    }
    if (packageCustomizationModel!.customization!.year!) {
      packageExcelColumns[0].add('Year');
    }
    if (packageCustomizationModel!.customization!.carBrand!) {
      packageExcelColumns[0].add('Car Brand');
    }
    if (packageCustomizationModel!.customization!.carModel!) {
      packageExcelColumns[0].add('Car Model');
    }
    if (packageCustomizationModel!.customization!.color!) {
      packageExcelColumns[0].add('Color');
    }
    if (packageCustomizationModel!.customization!.vinNumber!) {
      packageExcelColumns[0].add('Vin Number');
    }
    if (packageCustomizationModel!.customization!.policyNumber!) {
      packageExcelColumns[0].add('Policy Number');
    }
    if (packageCustomizationModel!.customization!.policyStartDate!) {
      packageExcelColumns[0].add('Policy Start Date');
    }
    if (packageCustomizationModel!.customization!.policyEndDate!) {
      packageExcelColumns[0].add('Policy End Date');
    }
    if (packageCustomizationModel!.customization!.carPlate!) {
      packageExcelColumns[0].add('Car Plate');
    }
    if (packageCustomizationModel!.customization!.insuranceCompanyId!) {
      packageExcelColumns[0].add('Insurance Company');
    }
    if (exportAfterFail) {
      packageExcelColumns[0].add('Error');
    }

    //** add Failure Rows To Excel
    if (list != null && list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        List<String> row = [];
        if (packageCustomizationModel!.customization!.name!) {
          row.add(list[i].name ?? '');
        }
        if (packageCustomizationModel!.customization!.phoneNumber!) {
          row.add(list[i].phoneNumber ?? '');
        }
        if (packageCustomizationModel!.customization!.email!) {
          row.add(list[i].email ?? '');
        }
        if (packageCustomizationModel!.customization!.year!) {
          row.add(list[i].year ?? '');
        }
        if (packageCustomizationModel!.customization!.carBrand!) {
          row.add(list[i].carBrand ?? '');
        }
        if (packageCustomizationModel!.customization!.carModel!) {
          row.add(list[i].carModel ?? '');
        }
        if (packageCustomizationModel!.customization!.color!) {
          row.add(list[i].color ?? '');
        }
        if (packageCustomizationModel!.customization!.vinNumber!) {
          row.add(list[i].vinNumber ?? '');
        }
        if (packageCustomizationModel!.customization!.policyNumber!) {
          row.add(list[i].policyNumber ?? '');
        }
        if (packageCustomizationModel!.customization!.policyStartDate!) {
          row.add(Utils.covertTimeStampToString(list[i].policyStartDate ?? ''));
        }
        if (packageCustomizationModel!.customization!.policyEndDate!) {
          row.add(Utils.covertTimeStampToString(list[i].policyEndDate ?? ''));
        }
        if (packageCustomizationModel!.customization!.carPlate!) {
          row.add(list[i].carPlate ?? '');
        }
        if (packageCustomizationModel!.customization!.insuranceCompanyId!) {
          row.add(list[i].insuranceCompanyId ?? '');
        }
        if (exportAfterFail) {
          row.add(list[i].error ?? '');
        }

        packageExcelColumns.add(row);
      }
    }

    debugPrint('Export Excel (Rows)===>>> ${packageExcelColumns.length}');
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    final data = [
      ...packageExcelColumns,
    ];

    for (final row in data) {
      sheet.appendRow(<CellValue>[for(final rowValueSingle in row)TextCellValue(rowValueSingle)]);
    }

    final blob = html.Blob([excel.encode()], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = 'UsersTemplate.xlsx'
      ..click();
    html.Url.revokeObjectUrl(url);

    emit(ExportExcelTemplateSuccessState());
    packageExcelColumns[0].clear();

    // add data to excel file
  }

// import excel file for package Customization

  bool isImportExcelFileLoading = false;

// read data from excel file

  List<List<dynamic>> packageExcelData = [];

  List<PackageBulkUserModel> packageCustomizationList = [];
  List<String> packageCustomizationListNames = [];

  void importExcelFile() async {
    packageExcelData.clear();
    emit(ImportExcelFileLoadingState());
    isImportExcelFileLoading = true;
    // open window to select excel file

    final input = html.FileUploadInputElement()..accept = '.xlsx';
    input.click();

    // convert excel file to bytes

    input.onChange.listen(
      (event) async {
        debugPrint('-----on change------');
        final file = input.files!.first;
        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          (event) async {
            debugPrint('-----on load end------');
            final bytes = reader.result as String;
            final excel = Excel.decodeBytes(
              base64.decode(
                bytes.substring(bytes.indexOf(',') + 1),
              ),
            );
            for (var row in excel.tables['Sheet1']!.rows) {
              for (var element in row) {
                // get first row of excel file which is columns names
                // if (row.indexOf(element) == 0) {
                if (row.indexOf(element) == 0) {
                  packageCustomizationListNames = packageCustomizationListNames.isEmpty
                      ? row.map((e) {
                          if (e == null) {
                            emit(ImportExcelFileErrorState(error: 'Please check excel file columns names'));
                            // HelpooInAppNotification.showMessage(
                            //     message: 'Please check excel file data', color: Colors.red);
                            return '';
                          } else {
                            return e.value.toString();
                          }
                        }).toList()
                      : packageCustomizationListNames;
                  debugPrint('packageCustomizationListNames Length: ${packageCustomizationListNames.length}');
                  debugPrint('packageCustomizationListNames : $packageCustomizationListNames');
                  continue;
                }
                // add data to packageExcelData

                // convert String to bool
              }
              if (excel.tables['Sheet1']!.rows.indexOf(row) != 0) {
                packageExcelData.add(row.map((e) {
                  if (e == null) {
                    emit(ImportExcelFileErrorState(error: 'Please check excel file data'));
                    // HelpooInAppNotification.showMessage(message: 'Please check excel file data', color: Colors.red);
                    return '';
                  } else {
                    return e.value.toString();
                  }
                }).toList());

                debugPrint('packageExcelData: ${packageExcelData.length}');
              }

              // debugPrint('element: $element');
            }

            // add data to packageCustomizationList from packageExcelData based on packageCustomizationListNames
            packageCustomizationList.clear();
            debugPrint('packageExcelData.length  ${packageExcelData.length}');
            debugPrint('packageCustomizationListNames Length 22: ${packageCustomizationListNames.length}');
            debugPrint('packageCustomizationListNames 22: $packageCustomizationListNames');
            packageExcelData.removeAt(0);
            for (var i = 0; i < packageExcelData.length; i++) {
              debugPrintFullText('packageExcelData[$i]: ${packageExcelData[i]}');

              final packageCustomizationModel = PackageBulkUserModel(
                name: packageCustomizationListNames.contains('Name') ? packageExcelData[i][packageCustomizationListNames.indexOf('Name')] : '',
                phoneNumber: packageCustomizationListNames.contains('Phone Number')
                    ? handlePhoneNumber(phoneNum: packageExcelData[i][packageCustomizationListNames.indexOf('Phone Number')])
                    : '',
                email: packageCustomizationListNames.contains('Email') ? packageExcelData[i][packageCustomizationListNames.indexOf('Email')] : '',
                year: packageCustomizationListNames.contains('Year') ? packageExcelData[i][packageCustomizationListNames.indexOf('Year')] : '',
                carBrand: packageCustomizationListNames.contains('Car Brand')
                    ? packageExcelData[i][packageCustomizationListNames.indexOf('Car Brand')]
                    : '',
                carModel: packageCustomizationListNames.contains('Car Model')
                    ? packageExcelData[i][packageCustomizationListNames.indexOf('Car Model')]
                    : '',
                color: packageCustomizationListNames.contains('Color') ? packageExcelData[i][packageCustomizationListNames.indexOf('Color')] : '',
                vinNumber: packageCustomizationListNames.contains('Vin Number')
                    ? packageExcelData[i][packageCustomizationListNames.indexOf('Vin Number')]
                    : '',
                policyNumber: packageCustomizationListNames.contains('Policy Number')
                    ? packageExcelData[i][packageCustomizationListNames.indexOf('Policy Number')]
                    : '',
                policyStartDate: packageCustomizationListNames.contains('Policy Start Date')
                    ? Utils.covertStringToTimeStamp(packageExcelData[i][packageCustomizationListNames.indexOf('Policy Start Date')])
                    : '',
                policyEndDate: packageCustomizationListNames.contains('Policy End Date')
                    ? Utils.covertStringToTimeStamp(packageExcelData[i][packageCustomizationListNames.indexOf('Policy End Date')])
                    : '',
                carPlate: packageCustomizationListNames.contains('Car Plate')
                    ? (packageExcelData[i][packageCustomizationListNames.indexOf('Car Plate')] as String).replaceAll(' ', '-')
                    : '',
                insuranceCompanyId: userRoleName == Rules.Insurance.name
                    ? currentInsuranceCompanyName.toString()
                    : packageCustomizationListNames.contains('Insurance Company')
                        ? packageExcelData[i][packageCustomizationListNames.indexOf('Insurance Company')]
                        : '',
              );

              debugPrintFullText('packageCustomizationModel $i: ${packageCustomizationModel.toJson()}');
              packageCustomizationList.add(packageCustomizationModel);
            }

            if (isPackageCustomizationValid()) {
              emit(ImportExcelFileSuccessState());
            } else {
              emit(ImportExcelFileErrorState(error: 'Data is not valid'));
            }
          },
        );
      },
    );
  }

// package customization validation based on packageCustomizationModel fields and packageCustomizationNames

  bool isPackageCustomizationValid() {
    // for (var packageCustomizationModel in packageCustomizationList) {
    //   for(var name in packageCustomizationListNames){
    //     if(!packageCustomizationModel.toJson()[name]!.isEmpty){
    //       return false;
    //     }
    //   }
    //   // if (packageCustomizationModel.name!.isEmpty ||
    //   //     packageCustomizationModel.phoneNumber!.isEmpty ||
    //   //     packageCustomizationModel.email!.isEmpty ||
    //   //     packageCustomizationModel.year!.isEmpty ||
    //   //     packageCustomizationModel.carBrand!.isEmpty ||
    //   //     packageCustomizationModel.carModel!.isEmpty ||
    //   //     packageCustomizationModel.color!.isEmpty ||
    //   //     packageCustomizationModel.vinNumber!.isEmpty ||
    //   //     packageCustomizationModel.policyNumber!.isEmpty ||
    //   //     packageCustomizationModel.policyStartDate!.isEmpty ||
    //   //     packageCustomizationModel.policyEndDate!.isEmpty ||
    //   //     packageCustomizationModel.carPlate!.isEmpty) {
    //   //   return false;
    //   // }
    // }
    return true;
  }

// add users to package

  bool isAddUsersToPackageLoading = false;

  void addUsersToPackage() async {
    emit(AddUsersToPackageLoadingState());
    isAddUsersToPackageLoading = true;
    final result = await _repository.addUsersToPackage(
      packageId: selectedPackageId,
      users: packageCustomizationList,
    );

    result.fold(
      (l) {
        isAddUsersToPackageLoading = false;
        emit(AddUsersToPackageErrorState(error: l));
        HelpooInAppNotification.showMessage(message: l, color: Colors.red);
      },
      (r) async {
        isAddUsersToPackageLoading = false;
        debugPrintFullText('****************************************************************');
        debugPrintFullText('Failed Rows: ${r.data?.failureCount}');
        debugPrintFullText('Success Rows: ${r.data?.successCount}');
        debugPrintFullText('****************************************************************');

        if ((r.data!.failureCount! > 0)) {
          HelpooInAppNotification.showErrorMessage(message: 'Failed to add Some users. Please Open Exported Excel to handle the error');
          await getPackageCustomization(exportSheetAfterSuccess: false);
          await exportExcelTemplate(list: r.data?.failedRows ?? [], exportAfterFail: true);
          emit(FailedToAddSomeUsersToPackageState());
        }

        if ((r.data!.successCount! > 0)) {
          HelpooInAppNotification.showSuccessMessage(message: 'Users added successfully');
          getAllPackages(
            isForCorporate: userRoleName == Rules.Corporate.name,
            isForInsurance: userRoleName == Rules.Insurance.name,
            isForBroker: userRoleName == Rules.Broker.name,
          );
          emit(AddUsersToPackageSuccessState());
        }

        emit(AddUsersToPackageCallDone());
      },
    );
  }

// get corporate users

  bool isGetCorporateUsersLoading = false;

  CorporateUsersModel? corporateUsersModel;

  void getCorporateUsers() async {
    emit(GetCorporateUsersLoadingState());
    isGetCorporateUsersLoading = true;
    final result = await _repository.getCorporateUsers(corporateId: selectedCorporateId!);

    result.fold((l) {
      emit(GetCorporateUsersErrorState(error: l));
      HelpooInAppNotification.showMessage(message: l, color: Colors.red);
      isGetCorporateUsersLoading = false;
    }, (r) {
      isGetCorporateUsersLoading = false;
      corporateUsersModel = r;
      emit(GetCorporateUsersSuccessState());
    });
  }

// get all promo code users

  PromoCodeUsersModel? promoCodeUsersModel;

  bool isGetPromoCodeUsersLoading = false;

  void getPromoCodeUsers({
    bool isFromPackagePage = true,
  }) async {
    emit(GetPromoCodeUsersLoadingState());
    isGetPromoCodeUsersLoading = true;

    final result = await _repository.getPromoCodeUsers(
      packageId: isFromPackagePage ? selectedPackageId : null,
      promoId: isFromPackagePage ? null : selectedPromoCodeId,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetPromoCodeUsersLoading = false;
        emit(
          GetPromoCodeUsersErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetPromoCodeUsersLoading = false;
        promoCodeUsersModel = data;
        emit(GetPromoCodeUsersSuccessState());
      },
    );
  }

  int _selectedPromoCodeId = 0;

  int get selectedPromoCodeId => _selectedPromoCodeId;

  set selectedPromoCodeId(int value) {
    _selectedPromoCodeId = value;
    emit(SelectedPromoCodeIdChanged());
  }

// get all promo codes

  PromoCodesModel? promoCodesModel;

  bool isGetAllPromoCodesLoading = false;

  void getAllPromoCodes() async {
    emit(GetAllPromoCodesLoadingState());
    isGetAllPromoCodesLoading = true;

    final result = await _repository.getAllPromoCodes();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllPromoCodesLoading = false;
        emit(
          GetAllPromoCodesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllPromoCodesLoading = false;
        promoCodesModel = data;
        emit(GetAllPromoCodesSuccessState());
      },
    );
  }

//get all packages promo codes

  bool isGetAllPackagesPromoCodesLoading = false;

  PackagesPromoCodesModel? allPackagesPromoCodes;

  void getAllPackagesPromoCodes() async {
    emit(GetAllPackagesPromoCodesLoadingState());
    isGetAllPackagesPromoCodesLoading = true;

    final result = await _repository.getAllPackagesPromoCodes();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetAllPackagesPromoCodesLoading = false;
        emit(
          GetAllPackagesPromoCodesErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetAllPackagesPromoCodesLoading = false;
        allPackagesPromoCodes = data;
        emit(GetAllPackagesPromoCodesSuccessState());
      },
    );
  }

// get normal promo codes users

  bool isGetNormalPromoCodeUsersLoading = false;

  NormalPromoCodeUsers? normalPromoCodeUsersModel;

  void getNormalPromoCodeUsers() async {
    emit(GetNormalPromoCodeUsersLoadingState());
    isGetNormalPromoCodeUsersLoading = true;

    final result = await _repository.getNormalPromoCodeUsers(
      promoId: selectedPromoCodeId,
    );
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetNormalPromoCodeUsersLoading = false;
        emit(
          GetNormalPromoCodeUsersErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetNormalPromoCodeUsersLoading = false;
        normalPromoCodeUsersModel = data;
        emit(GetNormalPromoCodeUsersSuccessState());
      },
    );
  }

  String? _selectedPromoName;

  String? get selectedPromoName => _selectedPromoName;

  set selectedPromoName(String? value) {
    _selectedPromoName = value;
    emit(SelectedPromoNameChanged());
  }

  String? _selectedNormalPromoName;

  String? get selectedNormalPromoName => _selectedNormalPromoName;

  set selectedNormalPromoName(String? value) {
    _selectedNormalPromoName = value;
    emit(SelectedNormalPromoNameChanged());
  }

// export excel template for normal promo code

  List<String> normalPromoCodeUsersColumnNames = [
    'Id',
    'Phone Number',
    'Email',
    'Name',
    'Role',
    'Promo Code',
    'Created At',
  ];

  void exportNormalPromoCodeUsersSheet({
    bool isForNormalPromoCode = true,
  }) {
    List<dynamic> excelData = [];
    if (isForNormalPromoCode) {
      if (normalPromoCodeUsersModel!.users!.isEmpty) {
        HelpooInAppNotification.showMessage(message: 'No data to export', color: Colors.red);
        return;
      } else {
        for (var element in normalPromoCodeUsersModel!.users!) {
          excelData.add([
            element.id,
            element.phoneNumber,
            element.email,
            element.name,
            getRoleNameBasedOnRoleId(element.roleId ?? -1),
            selectedNormalPromoName,
            element.createdAt,
          ]);
        }
      }
    } else {
      if (promoCodeUsersModel!.promoes!.isEmpty) {
        HelpooInAppNotification.showMessage(message: 'No data to export', color: Colors.red);
        return;
      } else {
        for (var element in promoCodeUsersModel!.promoes!) {
          excelData.add([
            element.user!.id,
            element.user!.phoneNumber,
            '',
            element.user!.name,
            getRoleNameBasedOnRoleId(element.user!.roleId ?? -1),
            element.packagePromoCode!.value!,
            element.createdAt,
          ]);
        }
      }
    }

    excelData.sort((a, b) => a[0].compareTo(b[0]));

    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    final data = [
      normalPromoCodeUsersColumnNames,
      ...excelData,
    ];

    for (final row in data) {
      sheet.appendRow(row);
    }

    final blob = html.Blob([excel.encode()], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = 'promoCodeUsers.xlsx'
      ..click();
    html.Url.revokeObjectUrl(url);
    excelData.clear();
    allReportsModel = null;
    corporateSearchModel = null;
    customerSearchModel = null;
  }

// get drivers statistics

  bool isGetDriversStatisticsLoading = false;

  DriversStatisticsModel? driversStatisticsModel;

  AllDrivers? allDrivers;
  AllDrivers? offlineDrivers;
  AllDrivers? onlineDrivers;
  AllDrivers? busyDriversStatistics;
  AllDrivers? freeDriversStatistics;

  void getDriversStatistics() async {
    emit(GetDriversStatisticsLoadingState());
    isGetDriversStatisticsLoading = true;

    final result = await _repository.getDriversStatistics();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetDriversStatisticsLoading = false;
        emit(
          GetDriversStatisticsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetDriversStatisticsLoading = false;
        driversStatisticsModel = data;

        allDrivers = driversStatisticsModel!.stats!.allDrivers!;
        offlineDrivers = driversStatisticsModel!.stats!.offlineDrivers!;
        onlineDrivers = driversStatisticsModel!.stats!.onlineDrivers!;
        busyDriversStatistics = driversStatisticsModel!.stats!.busyDrivers!;
        freeDriversStatistics = driversStatisticsModel!.stats!.freeDrivers!;

        emit(GetDriversStatisticsSuccessState());
      },
    );
  }

// get vehicles statistics

  bool isGetVehiclesStatisticsLoading = false;

  VehiclesStatisticsModel? vehiclesStatisticsModel;

  AllVehicles? allVehicles;

  AllVehicles? onlineVehicles;

  AllVehicles? offlineVehicles;

  AllVehicles? busyVehicles;

  AllVehicles? freeVehicles;

  void getVehiclesStatistics() async {
    emit(GetVehiclesStatisticsLoadingState());
    isGetVehiclesStatisticsLoading = true;

    final result = await _repository.getVehiclesStatistics();
    result.fold(
      (failure) {
        debugPrint('-----failure------');
        debugPrint(failure.toString());
        isGetVehiclesStatisticsLoading = false;
        emit(
          GetVehiclesStatisticsErrorState(
            error: failure,
          ),
        );
      },
      (data) {
        isGetVehiclesStatisticsLoading = false;
        vehiclesStatisticsModel = data;

        allVehicles = vehiclesStatisticsModel?.stats?.allVehicles;
        onlineVehicles = vehiclesStatisticsModel!.stats!.onlineVehicles;
        offlineVehicles = vehiclesStatisticsModel!.stats!.offlineVehicles;
        busyVehicles = vehiclesStatisticsModel!.stats!.busyVehicles;
        freeVehicles = vehiclesStatisticsModel!.stats!.availableVehicles;

        emit(GetVehiclesStatisticsSuccessState());
      },
    );
  }

  ///* Pdf Screenshot controllers
  ScreenshotController autometerScreenshotController = ScreenshotController();
  ScreenshotController carFrontController = ScreenshotController();
  ScreenshotController carLicenseController = ScreenshotController();
  ScreenshotController firstPageController = ScreenshotController();
  ScreenshotController frontBumberController = ScreenshotController();
  ScreenshotController identityPageController = ScreenshotController();
  ScreenshotController leftBackCornerController = ScreenshotController();
  ScreenshotController leftFrontCornerController = ScreenshotController();
  ScreenshotController rightBackCornerController = ScreenshotController();
  ScreenshotController rightFrontCornerController = ScreenshotController();
  ScreenshotController locationController = ScreenshotController();
  ScreenshotController vinNumberPageController = ScreenshotController();

  List<ScreenshotController> pdfScreensControllers = [];

  bool _showExtractVoiceFailed = false;

  bool get showExtractVoiceFailed => _showExtractVoiceFailed;

  set showExtractVoiceFailed(bool value) {
    _showExtractVoiceFailed = value;
    emit(ShowExtractVoiceFailedState());
  }

  TextEditingController extractVoiceController = TextEditingController();

  bool isUpdateFnolLoading = false;

  void updateFnol() async {
    isUpdateFnolLoading = true;
    emit(UpdateFnolLoadingState());

    final result = await _repository.updateFnol(
      voiceText: extractVoiceController.text,
      fnolId: accidentDetailsModel!.report!.id.toString(),
    );

    result.fold(
      (l) {
        isUpdateFnolLoading = false;
        emit(UpdateFnolErrorState(error: l));
      },
      (r) {
        isUpdateFnolLoading = false;

        accidentDetailsModel!.report!.audioCommentWritten = extractVoiceController.text;
        emit(UpdateFnolSuccessState());
      },
    );
  }

  bool isGetInsuranceLoading = false;
  InsuranceCompany? insuranceModel;

  void getInsurance({
    required int id,
  }) async {
    isGetInsuranceLoading = true;
    emit(GetInsuranceLoadingState());
    final result = await _repository.getInsurance(id: id);

    result.fold(
      (l) {
        isGetInsuranceLoading = false;
        emit(GetInsuranceErrorState(error: l));
      },
      (r) {
        insuranceModel = r.insuranceCompany;
        emit(GetInsuranceSuccessState());
      },
    );
  }

  final List<String> _selectedEmails = [];

  List<String> get selectedEmails => _selectedEmails;

  set selectedEmail(String? value) {
    _selectedEmails.contains(value) ? _selectedEmails.remove(value) : _selectedEmails.add(value!);
    emit(SelectEmailState());
  }

  removeSelectedEmails() {
    _selectedEmails.clear();
    emit(SelectEmailState());
  }

  TextEditingController emailSubjectController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();
  String _selectedPdfPath = '/public/accidentReports/pdf/AiCalc-fbe8251c-98a1-4bc1-a035-9deeceb27640---e5aabd90-5ad4-41e0-82db-2d8112e5024a-76.pdf';

  String get selectedPdfPath => _selectedPdfPath;

  set selectedPdfPath(String value) {
    _selectedPdfPath = value;
    emit(SelectPdfPathState());
  }

  bool isSendPdfThrowEmailLoading = false;

  void sendPdfThrowEmail() async {
    isSendPdfThrowEmailLoading = true;
    emit(SendPdfThrowEmailLoadingState());

    final result = await _repository.sendPdfThrowEmail(
      emails: selectedEmails,
      subject: emailSubjectController.text,
      body: emailBodyController.text,
      pdfPath: selectedPdfPath,
      FNOLID: accidentDetailsModel!.report!.id.toString(),
      bcc: [accidentDetailsModel?.report?.car?.broker?.user?.email],
    );

    result.fold(
      (l) {
        isSendPdfThrowEmailLoading = false;
        emit(SendPdfThrowEmailErrorState(error: l));
      },
      (r) {
        isSendPdfThrowEmailLoading = false;
        emit(SendPdfThrowEmailSuccessState());
      },
    );
  }

  UploadPdfResponseModel? uploadPdfResponseModel;

  void uploadFnolPdf({
    required String pdfReportOne,
    required String pdfReportTwo,
  }) async {
    emit(UploadFnolPdfLoadingState());
    printWarning('===>>> uploadFnolPdf');
    final result = await _repository.uploadFnolPdf(
      accidentReportId: accidentDetailsModel!.report!.id!,
      carId: accidentDetailsModel!.report!.car!.id!,
      pdfReportOne: pdfReportOne,
      pdfReportTwo: pdfReportTwo,
    );

    result.fold(
      (l) {
        printMeLog('===>>> uploadFnolPdf error $l');
        emit(UploadFnolPdfErrorState(error: l));
      },
      (r) {
        uploadPdfResponseModel = r;
        selectedPdfPath = r.report!.report!;
        emit(UploadFnolPdfSuccessState());
      },
    );
  }

  ///* Refuse Request Reject
  void refuseRequestReject({
    required String requestId,
  }) async {
    emit(RefuseRequestRejectLoading());

    final result = await _repository.refuseRequestReject(serviceRequestId: requestId);

    result.fold(
      (l) {
        emit(RefuseRequestRejectError(error: l));
      },
      (r) {
        emit(RefuseRequestRejectSuccess());
      },
    );
  }

  ///* approveReqCancel
  void approveReqCancel({
    required String requestId,
  }) async {
    emit(ApproveReqCancelLoading());

    final result = await _repository.approveReqCancel(serviceRequestId: requestId);

    result.fold(
      (l) {
        emit(ApproveReqCancelError(error: l));
      },
      (r) {
        emit(ApproveReqCancelSuccess());
      },
    );
  }

  ///* stats

  AllStatsResponseModel? allStatsResponseModel;
  VehiclesStatsResponseModel? vehiclesStatsResponseModel;
  PromoStatsResponseModel? promoStatsResponseModel;

  bool isGetAllStatsLoading = false;
  bool isGetVehiclesStatsLoading = false;
  bool isGetPromoStatsLoading = false;

  void getAllStats() async {
    isGetAllStatsLoading = true;
    emit(GetAllStatsLoading());

    final result = await _repository.getAllStats();

    result.fold(
      (l) {
        HelpooInAppNotification.showErrorMessage(message: 'couldn\'t load the general statistics.');
        isGetAllStatsLoading = false;
        emit(GetAllStatsErrorState(error: l));
      },
      (r) {
        allStatsResponseModel = r;
        isGetAllStatsLoading = false;
        emit(GetAllStatsSuccessState());
      },
    );
  }

  void getVehiclesStats() async {
    isGetVehiclesStatsLoading = true;
    emit(GetAllStatsLoading());

    final result = await _repository.getVehiclesStats();

    result.fold(
      (l) {
        HelpooInAppNotification.showErrorMessage(message: 'couldn\'t load the vehicles statistics.');
        isGetVehiclesStatsLoading = false;
        emit(GetAllStatsErrorState(error: l));
      },
      (r) {
        vehiclesStatsResponseModel = r;
        isGetVehiclesStatsLoading = false;
        emit(GetAllStatsSuccessState());
      },
    );
  }

  void getPromoStats() async {
    isGetPromoStatsLoading = true;
    emit(GetAllStatsLoading());

    final result = await _repository.getPromoStats();

    result.fold(
      (l) {
        HelpooInAppNotification.showErrorMessage(message: 'couldn\'t load promos statistics.');
        isGetPromoStatsLoading = false;
        emit(GetAllStatsErrorState(error: l));
      },
      (r) {
        promoStatsResponseModel = r;
        isGetPromoStatsLoading = false;
        emit(GetAllStatsSuccessState());
      },
    );
  }

  ///* Administration

  int ENV_CONFIG_CLICKS = 0;
  String ENV_CONFIG_SELECTED = dev;
  String ENV_CONFIG_PASS = 'BelalAdmin';
}

enum ServicePaymentMethods {
  cash,
  cardToDriver,
  onlineCard,
  onlineWallet,
  deferred,
}

extension ServicePaymentMethodsExtension on ServicePaymentMethods {
  String get name {
    switch (this) {
      case ServicePaymentMethods.cash:
        return 'cash';
      case ServicePaymentMethods.cardToDriver:
        return 'cardToDriver';
      case ServicePaymentMethods.onlineCard:
        return 'online';
      case ServicePaymentMethods.onlineWallet:
        return 'Online Wallet';
      case ServicePaymentMethods.deferred:
        return 'deferredPayment';
    }
  }

  String get apiName {
    switch (this) {
      case ServicePaymentMethods.cash:
        return 'cash';
      case ServicePaymentMethods.cardToDriver:
        return 'card-to-driver';
      case ServicePaymentMethods.deferred:
        return 'deferred';
      case ServicePaymentMethods.onlineCard:
        return 'online';
      case ServicePaymentMethods.onlineWallet:
        return 'online-wallet';
    }
  }
}

enum ServiceStatus {
  all,
  open,
  pending,
  confirmed,
  started,
  arrived,
  done,
  destinationArrived,
  canceled,
  cancelWithPayment,
}

extension ServiceStatusExtension on ServiceStatus {
  String get name {
    switch (this) {
      case ServiceStatus.all:
        return 'All';
      case ServiceStatus.open:
        return 'Open';
      case ServiceStatus.pending:
        return 'Pending';
      case ServiceStatus.confirmed:
        return 'Confirmed';
      case ServiceStatus.started:
        return 'Started';
      case ServiceStatus.arrived:
        return 'Arrived';
      case ServiceStatus.done:
        return 'Done';
      case ServiceStatus.destinationArrived:
        return 'Destination Arrived';
      case ServiceStatus.canceled:
        return 'Canceled';
      case ServiceStatus.cancelWithPayment:
        return 'Cancel With Payment';
    }
  }

  String get value {
    switch (this) {
      case ServiceStatus.all:
        return 'all';
      case ServiceStatus.open:
        return 'open';
      case ServiceStatus.pending:
        return 'pending';
      case ServiceStatus.confirmed:
        return 'confirmed';
      case ServiceStatus.started:
        return 'started';
      case ServiceStatus.arrived:
        return 'arrived';
      case ServiceStatus.done:
        return 'done';
      case ServiceStatus.destinationArrived:
        return 'desArrived';
      case ServiceStatus.canceled:
        return 'canceled';
      case ServiceStatus.cancelWithPayment:
        return 'cancelWithPayment';
    }
  }
}

enum FilterTypes {
  all,
  status,
  serviceType,
  clientType,
}

extension FilterTypesExtension on FilterTypes {
  String get name {
    switch (this) {
      case FilterTypes.all:
        return 'All';
      case FilterTypes.status:
        return 'Status';
      case FilterTypes.serviceType:
        return 'Service Type';
      case FilterTypes.clientType:
        return 'Client Type';
    }
  }

  String get value {
    switch (this) {
      case FilterTypes.all:
        return 'all';
      case FilterTypes.status:
        return 'status';
      case FilterTypes.serviceType:
        return 'serviceType';
      case FilterTypes.clientType:
        return 'clientType';
    }
  }
}

enum ServiceRequestStatus {
  open,
  confirmed,
  canceled,
  // not_available,
  accepted,
  arrived,
  started,
  done,
  pending,
  destArrived,
  cancelWithPayment,
  // paid
}

extension ServiceRequestStatusExtension on ServiceRequestStatus {
  String get value {
    switch (this) {
      case ServiceRequestStatus.open:
        return 'طلب متاح';
      case ServiceRequestStatus.confirmed:
        return 'تم تأكيد الطلب';
      case ServiceRequestStatus.canceled:
        return 'مغلق';
      // case ServiceRequestStatus.not_available:
      //   return 'غير متاح';
      case ServiceRequestStatus.accepted:
        return 'السائق في الطريق اليك';
      case ServiceRequestStatus.arrived:
        return 'السائق وصل اليك';
      case ServiceRequestStatus.started:
        return 'جاري تنفيذ الخدمة';
      case ServiceRequestStatus.done:
        return 'تم تنفيذ الخدمة';
      case ServiceRequestStatus.pending:
        return 'الطلب معلق';
      case ServiceRequestStatus.destArrived:
        return 'السائق وصل الى الوجهه';
      case ServiceRequestStatus.cancelWithPayment:
        return 'تم الغاء الطلب بدفع رسوم';
      // case ServiceRequestStatus.paid:
      //   return 'تم الدفع';
    }
  }

  String get enName {
    switch (this) {
      case ServiceRequestStatus.open:
        return 'Open';
      case ServiceRequestStatus.confirmed:
        return 'Confirmed';
      case ServiceRequestStatus.canceled:
        return 'Canceled';
      // case ServiceRequestStatus.not_available:
      //   return 'Not Available';
      case ServiceRequestStatus.accepted:
        return 'Accepted';
      case ServiceRequestStatus.arrived:
        return 'Arrived';
      case ServiceRequestStatus.started:
        return 'Started';
      case ServiceRequestStatus.done:
        return 'Done';
      case ServiceRequestStatus.pending:
        return 'Pending';
      case ServiceRequestStatus.destArrived:
        return 'Distenation Arrived';
      case ServiceRequestStatus.cancelWithPayment:
        return 'Cancel With Payment';
      // case ServiceRequestStatus.paid:
      //   return 'Paid';
    }
  }

  String get arName {
    switch (this) {
      case ServiceRequestStatus.open:
        return 'متاح';
      case ServiceRequestStatus.confirmed:
        return 'تم تأكيد الطلب';
      case ServiceRequestStatus.canceled:
        return 'مغلق';
      // case ServiceRequestStatus.not_available:
      //   return 'غير متاح';
      case ServiceRequestStatus.accepted:
        return 'مقبول';
      case ServiceRequestStatus.arrived:
        return 'تم الوصول';
      case ServiceRequestStatus.started:
        return 'جاري تنفيذ الخدمة';
      case ServiceRequestStatus.done:
        return 'تم تنفيذ الخدمة';
      case ServiceRequestStatus.pending:
        return 'الطلب معلق';
      case ServiceRequestStatus.destArrived:
        return 'الوصول الى الوجهة';
      case ServiceRequestStatus.cancelWithPayment:
        return 'تم الغاء الطلب بدفع رسوم';
      // case ServiceRequestStatus.paid:
      //   return 'تم الدفع';
    }
  }
}

enum CarServiceType {
  fuel(1, 'نقل بنزين', 'Fuel'),
  tiresFix(2, 'اصلاح كاوتش', 'Tires Fix'),
  batteries(3, 'بطارية', 'Batteries'),
  carTowing(4, 'ونش عادي', 'normal'),
  premiumCarTowing(5, 'ونش اوروبي', 'European');

  final int id;
  final String nameAr;
  final String nameEn;

  const CarServiceType(this.id, this.nameAr, this.nameEn);
}
