import 'package:flutter/material.dart';
import 'constants.dart';
import '../../features/home/home_page.dart';
import '../../features/login/login_page.dart';
import '../../features/pdf/pages/pdf_autometer_car_page.dart';
import '../../features/pdf/pages/pdf_first_page.dart';
import '../../features/pdf/pages/pdf_identity_page.dart';
import '../../features/pdf/pages/pdf_location_page.dart';
import '../../features/tracking_page/tracking_page.dart';

import '../../features/inspections/widgets/stepper_inspections.dart';

class Routes {
  static const String test = '/test';
  static const String login = '/login';
  static const String home = '/home';
  static const String pdfFirstPage = '/pdfFirstPage';
  static const String pdfSecondPage = '/pdfSecondPage';
  static const String pdfIdentityPage = '/PdfIdentityPage';
  static const String pdfAutometerCarPage = '/PdfAutometerCarPage';
  static const String allPdfPage = '/allPdfPage';

  static String tracking = '/tracking${idParam.isNotEmpty ? '?id=$idParam' : ''}';

  static Map<String, WidgetBuilder> get routes {
    return {
      test: (context) => const StepperInspection(),
      login: (context) => const LoginPage(),
      home: (context) => const HomePage(),
      tracking: (context) => const TrackingPage(),
      pdfFirstPage: (context) => const PdfFirstPage(),
      pdfSecondPage: (context) => const PdfFnolLocationPage(),
      pdfIdentityPage: (context) => const PdfIdentityPage(),
      pdfAutometerCarPage: (context) => const PdfAutometerCarPage(),
      // allPdfPage: (context) => const AllPdfPage(),
    };
  }
}
