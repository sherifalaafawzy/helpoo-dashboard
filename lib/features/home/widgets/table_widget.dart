// import 'package:flutter/material.dart';
// import 'package:helpoo_insurance_dashboard/core/util/constants.dart';
// import 'package:helpoo_insurance_dashboard/core/util/widgets/primary_button.dart';
// import 'package:helpoo_insurance_dashboard/core/util/widgets/primary_padding.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
//
// class TableWidget extends StatelessWidget {
//   const TableWidget({Key? key}) : super(key: key);
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
//                   appTranslation(context).inspections,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const Spacer(),
//                 SizedBox(
//                   width: 200,
//                   child: PrimaryButton(
//                     text: appTranslation(context).createInspection,
//                     onPressed: () {
//                       // AppBloc.get(context).clearControllers();
//                       // AppBloc.get(context).isCreateInspection = true;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           space40Vertical(),
//           Expanded(
//             child: Container(
//               width: 1122,
//               height: double.infinity,
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: borderGrey,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     color: borderGrey,
//                     child: PrimaryPadding(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               '#',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'اسم العميل',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'النوع',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'المعاين',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'المحافظة',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'المدينة',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'التاريخ',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               'الحاله',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               '',
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           ...AppBloc.get(context)
//                               .allInspections
//                               .map((e) => Column(
//                                     children: [
//                                       PrimaryPadding(
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 (AppBloc.get(context)
//                                                             .allInspections
//                                                             .indexOf(e) +
//                                                         1)
//                                                     .toString(),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 e.clientName,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 e.inspectionType.name,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 AppBloc.get(context)
//                                                     .allInspectors
//                                                     .firstWhere((element) =>
//                                                         element.id ==
//                                                         e.inspectorId)
//                                                     .name,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 e.government,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 e.city,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 DateFormat(
//                                                         'dd MMM yyyy hh:mm a')
//                                                     .format(e.createdAt),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Text(
//                                                 e.inspectionStatus.name,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleMedium,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   AppBloc.get(context)
//                                                       .selectedInspection = e;
//
//                                                   AppBloc.get(context)
//                                                           .isCreateInspection =
//                                                       true;
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.edit,
//                                                   color: HexColor(mainColor),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (AppBloc.get(context)
//                                               .allInspections
//                                               .indexOf(e) !=
//                                           AppBloc.get(context)
//                                                   .allInspections
//                                                   .length -
//                                               1)
//                                         const MyDivider(),
//                                     ],
//                                   ))
//                               .toList(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
