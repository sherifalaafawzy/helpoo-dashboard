// import 'package:flutter/material.dart';
// import 'package:helpoo_inspections_web/core/util/constants.dart';
// import 'package:helpoo_inspections_web/core/util/cubit/cubit.dart';
// import 'package:helpoo_inspections_web/core/util/widgets/primary_button.dart';
// import 'package:helpoo_inspections_web/core/util/widgets/primary_padding.dart';
// import 'package:helpoo_inspections_web/features/home/widgets/main_card.dart';
// import 'package:helpoo_inspections_web/core/util/extensions/types_extension.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
//
// class InspectorsWidget extends StatelessWidget {
//   const InspectorsWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return PrimaryPadding(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           space20Vertical(),
//           SizedBox(
//             width: 1122,
//             child: Row(
//               children: [
//                 Text(
//                   appTranslation(context).inspectors,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 space10Horizontal(),
//                 Text(
//                   'تحت التطوير',
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: secondaryGrey,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
