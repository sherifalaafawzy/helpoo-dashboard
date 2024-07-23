// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:helpoo_inspections_web/core/util/constants.dart';
// import 'package:helpoo_inspections_web/core/util/cubit/cubit.dart';
// import 'package:helpoo_inspections_web/core/util/cubit/cubit.dart';
// import 'package:helpoo_inspections_web/core/util/cubit/cubit.dart';
// import 'package:helpoo_inspections_web/core/util/cubit/cubit.dart';
// import 'package:helpoo_inspections_web/core/util/cubit/state.dart';
// import 'package:helpoo_inspections_web/core/util/extensions/build_context_extension.dart';
// import 'package:helpoo_inspections_web/core/util/extensions/types_extension.dart';
// import 'package:helpoo_inspections_web/core/util/helpoo_in_app_notifications.dart';
// import 'package:helpoo_inspections_web/core/util/widgets/primary_button.dart';
// import 'package:helpoo_inspections_web/core/util/widgets/primary_form_field.dart';
// import 'package:helpoo_inspections_web/core/util/widgets/primary_padding.dart';
// import 'package:helpoo_inspections_web/features/home/widgets/main_card.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class CreateInspectionWidget extends StatelessWidget {
//   const CreateInspectionWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppBloc, AppState>(
//       listener: (context, state) {
//         if (state is CreateInspectionSuccess) {
//           AppBloc.get(context).isCreateInspection = false;
//
//           HelpooInAppNotification.showMessage(
//             message: 'تم انشاء المعاينة بنجاح',
//             color: chooseColor(TOAST.success),
//             iconPath: chooseIcon(TOAST.success),
//           );
//         }
//
//         if (state is UpdateInspectionSuccess) {
//           AppBloc.get(context).isCreateInspection = false;
//
//           HelpooInAppNotification.showMessage(
//             message: 'تم تعديل المعاينة بنجاح',
//             color: chooseColor(TOAST.success),
//             iconPath: chooseIcon(TOAST.success),
//           );
//         }
//       },
//       builder: (context, state) {
//         return PrimaryPadding(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               space20Vertical(),
//               SizedBox(
//                 width: 1122,
//                 child: Row(
//                   children: [
//                     Text(
//                       appTranslation(context).createInspection,
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                   ],
//                 ),
//               ),
//               space40Vertical(),
//               Expanded(
//                 child: Container(
//                   width: 1122,
//                   height: double.infinity,
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: borderGrey,
//                     ),
//                   ),
//                   child: PrimaryPadding(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'برجاء ادخال البيانات بما يناسب نوع المعاينة٬ ولا يجب ملئ كل الحقول',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge!
//                                   .copyWith(
//                                     color: secondaryGrey,
//                                   ),
//                             ),
//                             const Spacer(),
//                             Text(
//                               'مرر لاسفل للاطلاع علي كل الحقول',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge!
//                                   .copyWith(
//                                     color: secondaryGrey,
//                                     fontSize: 16.0,
//                                   ),
//                             ),
//                           ],
//                         ),
//                         space20Vertical(),
//                         const MyDivider(),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 space20Vertical(),
//                                 Text(
//                                   'بيانات العميل',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                         color: secondaryGrey,
//                                         fontSize: 20.0,
//                                       ),
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'اسم العميل',
//                                   controller:
//                                       AppBloc.get(context).clientNameController,
//                                 ),
//                                 space20Vertical(),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: PrimaryFormField(
//                                         enabled: AppBloc.get(context)
//                                                 .selectedInspection ==
//                                             null,
//                                         validationError: '',
//                                         label: 'المحافظة',
//                                         controller: AppBloc.get(context)
//                                             .governmentController,
//                                       ),
//                                     ),
//                                     space20Horizontal(),
//                                     Expanded(
//                                       child: PrimaryFormField(
//                                         enabled: AppBloc.get(context)
//                                                 .selectedInspection ==
//                                             null,
//                                         validationError: '',
//                                         label: 'المدينة',
//                                         controller:
//                                             AppBloc.get(context).cityController,
//                                       ),
//                                     ),
//                                     space20Horizontal(),
//                                     Expanded(
//                                       child: PrimaryFormField(
//                                         enabled: AppBloc.get(context)
//                                                 .selectedInspection ==
//                                             null,
//                                         validationError: '',
//                                         label: 'المنطقة',
//                                         controller:
//                                             AppBloc.get(context).areaController,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'تفاصيل العنوان',
//                                   controller:
//                                       AppBloc.get(context).addressController,
//                                 ),
//                                 space20Vertical(),
//                                 const MyDivider(),
//                                 space20Vertical(),
//                                 Text(
//                                   'بيانات السيارة',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                         color: secondaryGrey,
//                                         fontSize: 20.0,
//                                       ),
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'نوع السيارة',
//                                   controller:
//                                       AppBloc.get(context).carTypeController,
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'رقم الشاسيه',
//                                   controller:
//                                       AppBloc.get(context).vinNumberController,
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'رقم المحرك',
//                                   controller: AppBloc.get(context)
//                                       .engineNumberController,
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'رقم اللوحة',
//                                   controller: AppBloc.get(context)
//                                       .plateNumberController,
//                                 ),
//                                 space20Vertical(),
//                                 const MyDivider(),
//                                 space20Vertical(),
//                                 Text(
//                                   'بيانات المعاينة',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                         color: secondaryGrey,
//                                         fontSize: 20.0,
//                                       ),
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'وصف الحادث',
//                                   controller: AppBloc.get(context)
//                                       .accidentDescriptionController,
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label: 'الإستثناءات',
//                                   controller: AppBloc.get(context)
//                                       .accidentExceptionsController,
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label:
//                                       'نوع المعاينة (اضغط للتحديد٬ لا تحاول الكتابة ولا النسخ هنا)',
//                                   onTap: () {
//                                     showCupertinoModalPopup(
//                                       context: context,
//                                       builder: (context) {
//                                         return CupertinoActionSheet(
//                                           title: Text(
//                                             'اختر نوع المعاينة',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge!
//                                                 .copyWith(
//                                                   color: secondaryGrey,
//                                                   fontSize: 24.0,
//                                                 ),
//                                           ),
//                                           actions: [
//                                             ...InspectionType.values
//                                                 .map(
//                                                   (e) =>
//                                                       CupertinoActionSheetAction(
//                                                     child: Text(
//                                                       e.name,
//                                                     ),
//                                                     onPressed: () {
//                                                       AppBloc.get(context)
//                                                           .inspectionType = e;
//                                                       context.pop;
//                                                     },
//                                                   ),
//                                                 )
//                                                 .toList(),
//                                           ],
//                                           cancelButton:
//                                               CupertinoActionSheetAction(
//                                             child: Text(
//                                               appTranslation(context).cancel,
//                                             ),
//                                             onPressed: () {
//                                               context.pop;
//                                             },
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   controller: AppBloc.get(context)
//                                       .inspectionTypeController,
//                                 ),
//                                 space20Vertical(),
//                                 PrimaryFormField(
//                                   enabled:
//                                       AppBloc.get(context).selectedInspection ==
//                                           null,
//                                   validationError: '',
//                                   label:
//                                       'تحديد المعاين (اضغط للتحديد٬ لا تحاول الكتابة ولا النسخ هنا)',
//                                   onTap: () {
//                                     showCupertinoModalPopup(
//                                       context: context,
//                                       builder: (context) {
//                                         return CupertinoActionSheet(
//                                           title: Text(
//                                             'حدد المعاين',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge!
//                                                 .copyWith(
//                                                   color: secondaryGrey,
//                                                   fontSize: 24.0,
//                                                 ),
//                                           ),
//                                           actions: [
//                                             ...AppBloc.get(context)
//                                                 .allInspectors
//                                                 .map(
//                                                   (e) =>
//                                                       CupertinoActionSheetAction(
//                                                     child: Text(
//                                                       e.name,
//                                                     ),
//                                                     onPressed: () {
//                                                       AppBloc.get(context)
//                                                           .inspectorModel = e;
//                                                       context.pop;
//                                                     },
//                                                   ),
//                                                 )
//                                                 .toList(),
//                                           ],
//                                           cancelButton:
//                                               CupertinoActionSheetAction(
//                                             child: Text(
//                                               appTranslation(context).cancel,
//                                             ),
//                                             onPressed: () {
//                                               context.pop;
//                                             },
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                   controller:
//                                       AppBloc.get(context).inspectorController,
//                                 ),
//                                 space20Vertical(),
//                                 Wrap(
//                                   spacing: 20.0,
//                                   runSpacing: 20.0,
//                                   children: [
//                                     if (AppBloc.get(context)
//                                             .selectedInspection ==
//                                         null)
//                                       InkWell(
//                                         onTap: () {
//                                           AppBloc.get(context).selectFiles();
//                                         },
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         child: Container(
//                                           width: 200.0,
//                                           height: 200.0,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             border: Border.all(
//                                               color: borderGrey,
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Icon(
//                                                   Icons.add,
//                                                   color: HexColor(mainColor),
//                                                   size: 50.0,
//                                                 ),
//                                                 space20Vertical(),
//                                                 Text(
//                                                   'إضافة صور',
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .titleLarge!
//                                                       .copyWith(
//                                                         color:
//                                                             HexColor(mainColor),
//                                                         fontSize: 20.0,
//                                                       ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     if (AppBloc.get(context).filesResult !=
//                                         null)
//                                       ...AppBloc.get(context)
//                                           .filesResult!
//                                           .files
//                                           .map(
//                                             (e) => Container(
//                                               width: 200.0,
//                                               height: 200.0,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: MemoryImage(e.bytes!),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10.0),
//                                                 border: Border.all(
//                                                   color: borderGrey,
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Align(
//                                                   alignment:
//                                                       AlignmentDirectional
//                                                           .topStart,
//                                                   child: IconButton(
//                                                     icon: const Icon(
//                                                       Icons.remove_circle,
//                                                       color: Colors.red,
//                                                       size: 30.0,
//                                                     ),
//                                                     onPressed: () {
//                                                       AppBloc.get(context)
//                                                           .removeFile(e);
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                           .toList(),
//                                     if (AppBloc.get(context)
//                                             .selectedInspection !=
//                                         null) ...[
//                                       if (AppBloc.get(context)
//                                           .selectedInspection!
//                                           .adminAttachments!
//                                           .isNotEmpty)
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             SizedBox(
//                                               width: 200.0,
//                                               child: PrimaryButton(
//                                                 isLoading: AppBloc.get(context)
//                                                     .downloadAdminImagesAsZipLoading,
//                                                 text: 'تنزيل الكل',
//                                                 onPressed: () async {
//                                                   await AppBloc.get(context)
//                                                       .downloadImages(
//                                                           AppBloc.get(context)
//                                                                   .selectedInspection!
//                                                                   .adminAttachments ??
//                                                               [],
//                                                           'images.zip',
//                                                           true);
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                     ],
//                                     if (AppBloc.get(context)
//                                             .selectedInspection !=
//                                         null)
//                                       ...AppBloc.get(context)
//                                           .selectedInspection!
//                                           .adminAttachments!
//                                           .map(
//                                             (e) => Container(
//                                               width: 200.0,
//                                               height: 200.0,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: NetworkImage(e),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10.0),
//                                                 border: Border.all(
//                                                   color: borderGrey,
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Align(
//                                                   alignment:
//                                                       AlignmentDirectional
//                                                           .topStart,
//                                                   child: IconButton(
//                                                     icon: const Icon(
//                                                       Icons
//                                                           .download_for_offline_rounded,
//                                                       color: Colors.green,
//                                                       size: 30.0,
//                                                     ),
//                                                     onPressed: () async {
//                                                       if (!await launchUrl(
//                                                           Uri.parse(e))) {
//                                                         throw Exception(
//                                                           'Could not launch $e',
//                                                         );
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                           .toList(),
//                                   ],
//                                 ),
//                                 if (AppBloc.get(context).selectedInspection !=
//                                     null)
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       space20Vertical(),
//                                       const MyDivider(),
//                                       space20Vertical(),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'صور المعاين',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge!
//                                                 .copyWith(
//                                                   color: secondaryGrey,
//                                                   fontSize: 20.0,
//                                                 ),
//                                           ),
//                                           SizedBox(
//                                             width: 200.0,
//                                             child: PrimaryButton(
//                                               isLoading: AppBloc.get(context)
//                                                   .downloadInspectorImagesAsZipLoading,
//                                               text: 'تنزيل الكل',
//                                               onPressed: () async {
//                                                 await AppBloc.get(context)
//                                                     .downloadImages(
//                                                   AppBloc.get(context)
//                                                           .selectedInspection!
//                                                           .inspectorAttachments ??
//                                                       [],
//                                                   'images.zip',
//                                                   false,
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       space20Vertical(),
//                                       Wrap(
//                                         spacing: 20.0,
//                                         runSpacing: 20.0,
//                                         children: [
//                                           if (AppBloc.get(context)
//                                               .selectedInspection!
//                                               .inspectorAttachments!
//                                               .isNotEmpty)
//                                             ...AppBloc.get(context)
//                                                 .selectedInspection!
//                                                 .inspectorAttachments!
//                                                 .map(
//                                                   (e) => Container(
//                                                     width: 200.0,
//                                                     height: 200.0,
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: NetworkImage(e),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10.0),
//                                                       border: Border.all(
//                                                         color: borderGrey,
//                                                       ),
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Align(
//                                                         alignment:
//                                                             AlignmentDirectional
//                                                                 .topStart,
//                                                         child: IconButton(
//                                                           icon: const Icon(
//                                                             Icons
//                                                                 .download_for_offline_rounded,
//                                                             color: Colors.green,
//                                                             size: 30.0,
//                                                           ),
//                                                           onPressed: () async {
//                                                             if (!await launchUrl(
//                                                                 Uri.parse(e))) {
//                                                               throw Exception(
//                                                                 'Could not launch $e',
//                                                               );
//                                                             }
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                                 .toList(),
//                                         ],
//                                       ),
//                                       space20Vertical(),
//                                       const MyDivider(),
//                                       space20Vertical(),
//                                       Text(
//                                         'فيديوهات المعاين',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleLarge!
//                                             .copyWith(
//                                               color: secondaryGrey,
//                                               fontSize: 20.0,
//                                             ),
//                                       ),
//                                       space20Vertical(),
//                                       Wrap(
//                                         spacing: 20.0,
//                                         runSpacing: 20.0,
//                                         children: [
//                                           if (AppBloc.get(context)
//                                               .selectedInspection!
//                                               .inspectorVideos!
//                                               .isNotEmpty)
//                                             ...AppBloc.get(context)
//                                                 .selectedInspection!
//                                                 .inspectorVideos!
//                                                 .map(
//                                                   (e) => InkWell(
//                                                     onTap: () async {
//                                                       if (!await launchUrl(
//                                                           Uri.parse(e))) {
//                                                         throw Exception(
//                                                           'Could not launch $e',
//                                                         );
//                                                       }
//                                                     },
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.0),
//                                                     child: Container(
//                                                       width: 200.0,
//                                                       height: 200.0,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10.0),
//                                                         border: Border.all(
//                                                           color: borderGrey,
//                                                         ),
//                                                       ),
//                                                       child: Center(
//                                                         child: Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Icon(
//                                                               Icons
//                                                                   .video_camera_back_rounded,
//                                                               color: HexColor(
//                                                                   mainColor),
//                                                               size: 50.0,
//                                                             ),
//                                                             space10Vertical(),
//                                                             Text(
//                                                               'اضغط لمشاهدة الفيديو',
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center,
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .titleLarge!
//                                                                   .copyWith(
//                                                                     color: HexColor(
//                                                                         mainColor),
//                                                                     fontSize:
//                                                                         20.0,
//                                                                   ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                                 .toList(),
//                                         ],
//                                       ),
//                                       space20Vertical(),
//                                       const MyDivider(),
//                                       space20Vertical(),
//                                       Text(
//                                         'ملاحظات المعاين',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleLarge!
//                                             .copyWith(
//                                               color: secondaryGrey,
//                                               fontSize: 20.0,
//                                             ),
//                                       ),
//                                       space20Vertical(),
//                                       PrimaryFormField(
//                                         enabled: AppBloc.get(context)
//                                                 .selectedInspection ==
//                                             null,
//                                         validationError: '',
//                                         label: 'الملاحظات',
//                                         initialValue: AppBloc.get(context)
//                                             .selectedInspection!
//                                             .hints,
//                                       ),
//                                       space20Vertical(),
//                                       const MyDivider(),
//                                       space20Vertical(),
//                                       Text(
//                                         'اضف PDF بعد تجهيزه',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleLarge!
//                                             .copyWith(
//                                               color: secondaryGrey,
//                                               fontSize: 20.0,
//                                             ),
//                                       ),
//                                       space20Vertical(),
//                                       if (AppBloc.get(context).pdfFileResult ==
//                                               null &&
//                                           AppBloc.get(context)
//                                               .selectedInspection!
//                                               .adminPdf!
//                                               .isEmpty)
//                                         InkWell(
//                                           onTap: () {
//                                             AppBloc.get(context).selectPDF();
//                                           },
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                           child: Container(
//                                             width: 200.0,
//                                             height: 200.0,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               border: Border.all(
//                                                 color: borderGrey,
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.add,
//                                                     color: HexColor(mainColor),
//                                                     size: 50.0,
//                                                   ),
//                                                   space20Vertical(),
//                                                   Text(
//                                                     'إضافة PDF',
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .titleLarge!
//                                                         .copyWith(
//                                                           color: HexColor(
//                                                               mainColor),
//                                                           fontSize: 20.0,
//                                                         ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       if (AppBloc.get(context).pdfFileResult !=
//                                           null)
//                                         Container(
//                                           width: 200.0,
//                                           height: 200.0,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             border: Border.all(
//                                               color: borderGrey,
//                                             ),
//                                           ),
//                                           child: Stack(
//                                             children: [
//                                               Center(
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Icon(
//                                                       Icons.picture_as_pdf,
//                                                       color:
//                                                           HexColor(mainColor),
//                                                       size: 50.0,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Align(
//                                                   alignment:
//                                                       AlignmentDirectional
//                                                           .topStart,
//                                                   child: IconButton(
//                                                     icon: const Icon(
//                                                       Icons.remove_circle,
//                                                       color: Colors.red,
//                                                       size: 30.0,
//                                                     ),
//                                                     onPressed: () {
//                                                       AppBloc.get(context)
//                                                           .removePDF();
//                                                     },
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       if (AppBloc.get(context)
//                                           .selectedInspection!
//                                           .adminPdf!
//                                           .isNotEmpty)
//                                         InkWell(
//                                           onTap: () async {
//                                             String pdf = AppBloc.get(context)
//                                                 .selectedInspection!
//                                                 .adminPdf!;
//
//                                             if (!await launchUrl(
//                                                 Uri.parse(pdf))) {
//                                               throw Exception(
//                                                 'Could not launch $pdf',
//                                               );
//                                             }
//                                           },
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                           child: Container(
//                                             width: 200.0,
//                                             height: 200.0,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               border: Border.all(
//                                                 color: borderGrey,
//                                               ),
//                                             ),
//                                             child: Stack(
//                                               children: [
//                                                 Center(
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(
//                                                         Icons.picture_as_pdf,
//                                                         color:
//                                                             HexColor(mainColor),
//                                                         size: 50.0,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Align(
//                                                     alignment:
//                                                         AlignmentDirectional
//                                                             .topStart,
//                                                     child: IconButton(
//                                                       icon: const Icon(
//                                                         Icons
//                                                             .download_for_offline_rounded,
//                                                         color: Colors.green,
//                                                         size: 30.0,
//                                                       ),
//                                                       onPressed: () async {
//                                                         String pdf = AppBloc
//                                                                 .get(context)
//                                                             .selectedInspection!
//                                                             .adminPdf!;
//
//                                                         if (!await launchUrl(
//                                                             Uri.parse(pdf))) {
//                                                           throw Exception(
//                                                             'Could not launch $pdf',
//                                                           );
//                                                         }
//                                                       },
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         )
//                                     ],
//                                   ),
//                                 // if(AppBloc.get(context).selectedInspection != null && AppBloc.get(context).selectedInspection!.inspectionStatus != InspectionStatus.completed)
//                                 if (AppBloc.get(context).isButton)
//                                   space40Vertical(),
//                                 // if(AppBloc.get(context).selectedInspection != null && AppBloc.get(context).selectedInspection!.inspectionStatus != InspectionStatus.completed)
//                                 if (AppBloc.get(context).isButton)
//                                   PrimaryButton(
//                                     text: AppBloc.get(context)
//                                                 .selectedInspection ==
//                                             null
//                                         ? 'تأكيد الطلب'
//                                         : 'تعديل الطلب وانتقاله الي المنجزة',
//                                     onPressed: () {
//                                       if (AppBloc.get(context)
//                                               .selectedInspection ==
//                                           null) {
//                                         if (AppBloc.get(context)
//                                                 .inspectorModel ==
//                                             null) {
//                                           HelpooInAppNotification.showMessage(
//                                             message: 'يجب تحديد المعاين',
//                                             color: chooseColor(TOAST.warning),
//                                             iconPath: chooseIcon(TOAST.warning),
//                                           );
//                                           return;
//                                         }
//
//                                         AppBloc.get(context).createInspection();
//                                       } else {
//                                         AppBloc.get(context).updateInspection();
//                                       }
//                                     },
//                                     isLoading:
//                                         state is CreateInspectionLoading ||
//                                             state is UpdateInspectionLoading,
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
