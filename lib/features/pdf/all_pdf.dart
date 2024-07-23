// import 'package:flutter/material.dart';
// import 'package:helpoo_insurance_dashboard/core/util/widgets/primary_button.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/controller/pdf_controller.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_Left_front_corner.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_autometer_car_page.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_car_front_page.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_car_licence.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_first_page.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_front_bumper_page.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_identity_page.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_left_back_corner.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_location_page.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_right_back_corner.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_right_front_corner.dart';
// import 'package:helpoo_insurance_dashboard/features/pdf/pages/pdf_vin_number_page.dart';
//
// class AllPdfPage extends StatelessWidget {
//   const AllPdfPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             PrimaryButton(
//               onPressed: () {
//                 PdfController.exportFNOLPdf(
//                   context,
//                 );
//               },
//               text: 'Export',
//             ),
//             PdfFirstPage(),
//             PdfFnolLocationPage(),
//             PdfIdentityPage(),
//             PdfCarLicensePage(),
//             PdfVinNumberPage(),
//             PdfAutometerCarPage(),
//             PdfCarFrontPage(),
//             PdfFrontBumberPage(),
//             PdfRightFrontCornerPage(),
//             PdfRightBackCornerPage(),
//             PdfLeftBackCornerPage(),
//             PdfLeftFrontCornerPage(),
//           ],
//         ),
//       ),
//     );
//   }
// }
