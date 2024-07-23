import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/remote/api_endpoints.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/loading_progress_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../../core/util/widgets/selected_inspector_pop_up.dart';
import '../../../core/util/widgets/shared_widgets/primary_checkbox.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/util/widgets/accident_details_pop_up.dart';
import '../../../core/util/widgets/extract_reco_text_pop_up.dart';
import 'stepper_inspections.dart';

class CreateInspectionWidget extends StatefulWidget {
  final bool isOpenFromFNOL;
  final bool isUpdate;
  int sideMenuPageIndex;

  CreateInspectionWidget({super.key, required this.sideMenuPageIndex, this.isUpdate = false, this.isOpenFromFNOL = false});

  @override
  State<CreateInspectionWidget> createState() => _CreateInspectionWidgetState();
}

class _CreateInspectionWidgetState extends State<CreateInspectionWidget> {
  GlobalKey carTypeKey = GlobalKey();
  GlobalKey insuranceCompanySelectionKey = GlobalKey();
  GlobalKey carModelKey = GlobalKey();
  GlobalKey carColorKey = GlobalKey();
  GlobalKey governmentKey = GlobalKey();
  GlobalKey areaKey = GlobalKey();
  GlobalKey commitmentKey = GlobalKey();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (appBloc.myTimer != null) {
      appBloc.myTimer!.cancel();
      appBloc.myTimer = null;
    }
    if (appBloc.mySecondTimer != null) {
      debugPrint('timer disposed');
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
// appBloc.getAllInspectors();
    if (appBloc.selectedInspection == null) {
      appBloc.getManufacturers();
      appBloc.getCarsModels();
    }
    appBloc.getAllInsuranceCompanies();
  }

  @override
  void dispose() {
    appBloc.activeStepIndex = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CreateInspectionSuccessState) {
          appBloc.changeStackNav(index: appBloc.currentSideMenuIndex, isAdd: false);
          HelpooInAppNotification.showMessage(
            message: 'Inspection created successfully',
            color: chooseColor(TOAST.success),
            iconPath: chooseIcon(TOAST.success),
          );
        }

        if (state is UpdateInspectionSuccessState) {
          appBloc.changeStackNav(index: appBloc.currentSideMenuIndex, isAdd: false);
          HelpooInAppNotification.showMessage(
            message: 'Inspection Updated successfully',
            color: chooseColor(TOAST.success),
            iconPath: chooseIcon(TOAST.success),
          );
        }

        if (state is CreateInspectionErrorState) {
          HelpooInAppNotification.showErrorMessage(
            message: 'Error while creating inspection',
          );
        }
        if (state is UpdateInspectionErrorState) {
          HelpooInAppNotification.showErrorMessage(
            message: 'Error while updating inspection',
          );
        }
      },
      builder: (context, state) {
        if (widget.isOpenFromFNOL) {
          return PrimaryPadding(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    space20Vertical(),
                    SizedBox(
                      width: 1122,
                      child: Row(
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     appBloc.changeStackNav(
                          //       index: appBloc.currentSideMenuIndex,
                          //       isAdd: false,
                          //     );
                          //   },
                          //   hoverColor: Colors.transparent,
                          //   highlightColor: Colors.transparent,
                          //   child: Container(
                          //     height: 35,
                          //     width: 35,
                          //     margin: const EdgeInsetsDirectional.only(end: 20),
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       border: Border.all(
                          //         width: 1,
                          //         color: Colors.grey.shade200,
                          //       ),
                          //     ),
                          //     child: RotatedBox(
                          //       quarterTurns: isEnglish ? 2 : 0,
                          //       child: const Icon(
                          //         Icons.keyboard_arrow_right_rounded,
                          //         size: 20,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const BackButtonWidget(),
                          Text(
                            widget.isUpdate ? appTranslation(context).updateInspection : appTranslation(context).createInspection,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                    space40Vertical(),
                    Expanded(
                      child: Container(
                        width: 1122,
                        height: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: borderGrey,
                          ),
                        ),
                        child: PrimaryPadding(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Please fill the form below',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          color: secondaryGrey,
                                        ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'scroll down to see more',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          color: secondaryGrey,
                                          fontSize: 16.0,
                                        ),
                                  ),
                                ],
                              ),
                              space20Vertical(),
                              const MyDivider(),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      space20Vertical(),
                                      Text(
                                        'Client Information',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: secondaryGrey,
                                              fontSize: 20.0,
                                            ),
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.clientNameController) ? true : false,
                                        validationError: 'Please Enter Client Name',
                                        label: 'Client Name*',
                                        controller: appBloc.clientNameController,
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.clientPhoneController) ? true : false,
                                        validationError: 'Please Enter Client Phone Number',
                                        label: 'Client phone number*',
                                        controller: appBloc.clientPhoneController,
                                      ),
                                      space20Vertical(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                // if (appBloc.checkIfControllerEmpty(
                                                //     controller: appBloc
                                                //         .governmentController)) {
                                                //   showPrimaryMenu(
                                                //     context: context,
                                                //     key: governmentKey,
                                                //     items: [
                                                //       ...appBloc
                                                //           .governments
                                                //           .map(
                                                //             (e) =>
                                                //                 PopupMenuItem(
                                                //               value: 1,
                                                //               child: Text(
                                                //                 e,
                                                //                 style: Theme.of(
                                                //                         context)
                                                //                     .textTheme
                                                //                     .displaySmall!
                                                //                     .copyWith(
                                                //                       fontSize:
                                                //                           16.0,
                                                //                       color:
                                                //                           secondaryGrey,
                                                //                       fontWeight:
                                                //                           FontWeight
                                                //                               .w400,
                                                //                     ),
                                                //               ),
                                                //               onTap: () {
                                                //                 AppBloc.get(
                                                //                         context)
                                                //                     .selectedGovernment = e;
                                                //               },
                                                //             ),
                                                //           ),
                                                //     ],
                                                //   );
                                                // }
                                                showPrimaryMenu(
                                                  context: context,
                                                  key: governmentKey,
                                                  items: [
                                                    ...appBloc.governments.map(
                                                      (e) => PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          e,
                                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                                fontSize: 16.0,
                                                                color: secondaryGrey,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                        ),
                                                        onTap: () {
                                                          AppBloc.get(context).selectedGovernment = e;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              child: PrimaryFormField(
                                                key: governmentKey,
                                                enabled: false,
                                                validationError: 'Please Enter Government',
                                                label: 'Government*',
                                                controller: appBloc.governmentController,
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (appBloc.selectedGovernment == null) {
                                                  HelpooInAppNotification.showErrorMessage(message: 'Please select government first');
                                                  return;
                                                }

                                                showPrimaryMenu(
                                                  context: context,
                                                  key: areaKey,
                                                  items: [
                                                    ...appBloc.availableAreas.map(
                                                      (e) => PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          e,
                                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                                fontSize: 16.0,
                                                                color: secondaryGrey,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                        ),
                                                        onTap: () {
                                                          AppBloc.get(context).selectedArea = e;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              child: PrimaryFormField(
                                                key: areaKey,
                                                enabled: appBloc.isSelectedGovernmentHasAreas ? true : false,
                                                validationError: 'Please Enter Area',
                                                isValidate: false,
                                                label: 'Area*',
                                                controller: appBloc.areaController,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.addressController) ? true : false,
                                        validationError: 'Please Enter Address',
                                        label: 'Address*',
                                        controller: appBloc.addressController,
                                      ),
                                      space20Vertical(),
                                      const MyDivider(),
                                      space20Vertical(),
                                      Text(
                                        'Car Information',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: secondaryGrey,
                                              fontSize: 20.0,
                                            ),
                                      ),
                                      space20Vertical(),
                                      InkWell(
                                        key: carModelKey,
                                        onTap: () {
                                          if (appBloc.manufacturersModel == null) {
                                            appBloc.getManufacturers();
                                            return;
                                          }

                                          if (appBloc.selectedManufacturer == null) {
                                            showPrimaryMenu(
                                              context: context,
                                              key: carTypeKey,
                                              items: [
                                                ...appBloc.manufacturersModel!.manufacturers.map(
                                                  (e) => PopupMenuItem(
                                                    value: 1,
                                                    child: Text(
                                                      e.enName,
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 16.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                    onTap: () {
                                                      appBloc.selectedManufacturer = e;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          key: carTypeKey,
                                          enabled: false,
                                          // appBloc
                                          //             .selectedInspection ==
                                          //         null
                                          //     ? true
                                          //     : false,
                                          controller: appBloc.policyCarTypeController,
                                          validationError: 'Enter Car Type',
                                          label: 'Car Type*',
                                        ),
                                      ),
                                      space20Vertical(),
                                      InkWell(
                                        onTap: () {
                                          if (appBloc.carsModel == null) {
                                            appBloc.getCarsModels();
                                            return;
                                          }

                                          if (appBloc.selectedManufacturer == null) {
                                            HelpooInAppNotification.showErrorMessage(message: 'Please select car type first');
                                            return;
                                          }

                                          if (appBloc.checkIfControllerEmpty(controller: appBloc.policyCarModelController)) {
                                            showPrimaryMenu(
                                              context: context,
                                              key: carModelKey,
                                              items: [
                                                ...appBloc.carsModel!.models
                                                    .where((element) => element.manufacturerId == appBloc.selectedManufacturer!.id)
                                                    .map(
                                                      (e) => PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          e.enName,
                                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                                fontSize: 16.0,
                                                                color: secondaryGrey,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                        ),
                                                        onTap: () {
                                                          appBloc.selectedCarModel = e;
                                                        },
                                                      ),
                                                    ),
                                              ],
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          // appBloc
                                          //             .selectedInspection ==
                                          //         null
                                          //     ? true
                                          //     : false,
                                          controller: appBloc.policyCarModelController,
                                          validationError: 'Enter Car Model',
                                          label: 'Car Model*',
                                        ),
                                      ),
                                      space20Vertical(),
                                      InkWell(
                                        key: carColorKey,
                                        onTap: () {
                                          showPrimaryMenu(
                                            context: context,
                                            key: carColorKey,
                                            items: [
                                              ...carColors.map(
                                                (e) => PopupMenuItem(
                                                  value: 1,
                                                  child: Text(
                                                    e,
                                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                          fontSize: 16.0,
                                                          color: secondaryGrey,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                  ),
                                                  onTap: () {
                                                    appBloc.selectedCarColor = e;
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        child: PrimaryFormField(
                                          controller: appBloc.policyCarColorController,
                                          validationError: '',
                                          isValidate: false,
                                          label: 'Car Color',
                                          enabled: false,
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.vinNumberController) ? true : false,
                                        // appBloc
                                        //         .selectedInspection ==
                                        //     null,
                                        validationError: 'Please Enter Vin Number',
                                        label: 'Vin Number*',
                                        controller: appBloc.vinNumberController,
                                      ),
                                      // space20Vertical(),
                                      // PrimaryFormField(
                                      //   enabled: widget.isUpdate ? true : false,
                                      //   //  appBloc
                                      //   //             .selectedInspection ==
                                      //   //         null
                                      //   //     ? true
                                      //   //     : false,
                                      //   validationError: '',
                                      //   isValidate: false,
                                      //   label: 'Engine Number',
                                      //   controller: appBloc
                                      //       .engineNumberController,
                                      // ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.plateNumberController) ? true : false,
                                        // appBloc
                                        //             .selectedInspection ==
                                        //         null
                                        //     ? true
                                        //     : false,
                                        validationError: '',
                                        isValidate: false,
                                        label: 'Plate Number',
                                        controller: appBloc.plateNumberController,
                                      ),
                                      space20Vertical(),
                                      const MyDivider(),
                                      space20Vertical(),
                                      Text(
                                        'Accident Information',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: secondaryGrey,
                                              fontSize: 20.0,
                                            ),
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.accidentDescriptionController) ? true : false,
                                        //  appBloc
                                        //             .selectedInspection ==
                                        //         null
                                        //     ? true
                                        //     : false,
                                        validationError: '',
                                        isValidate: false,
                                        label: 'Accident Description',
                                        controller: appBloc.accidentDescriptionController,
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.accidentExceptionsController) ? true : false,
                                        //  appBloc
                                        //             .selectedInspection ==
                                        //         null
                                        //     ? true
                                        //     : false,
                                        validationError: '',
                                        isValidate: false,
                                        label: 'Exceptions',
                                        controller: appBloc.accidentExceptionsController,
                                      ),
                                      space20Vertical(),
                                      InkWell(
                                        onTap: () {
                                          if (appBloc.checkIfControllerEmpty(controller: appBloc.inspectionTypeController)) {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoActionSheet(
                                                  title: Text(
                                                    'Type of the Inspection',
                                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                          color: secondaryGrey,
                                                          fontSize: 24.0,
                                                        ),
                                                  ),
                                                  actions: [
                                                    ...InspectionType.values
                                                        .map(
                                                          (e) => CupertinoActionSheetAction(
                                                            child: Text(
                                                              e.arName,
                                                            ),
                                                            onPressed: () {
                                                              AppBloc.get(context).inspectionType = e;
                                                              context.pop;
                                                            },
                                                          ),
                                                        )
                                                        ,
                                                  ],
                                                  cancelButton: CupertinoActionSheetAction(
                                                    child: Text(
                                                      appTranslation(context).cancel,
                                                    ),
                                                    onPressed: () {
                                                      context.pop;
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          // appBloc
                                          //             .selectedInspection ==
                                          //         null
                                          //     ? true
                                          //     : false,
                                          validationError: 'Enter Inspection Type',
                                          label: 'Type of the Inspection (Click to select, do not try to write or copy here)',

                                          controller: appBloc.inspectionTypeController,
                                        ),
                                      ),
                                      space20Vertical(),

                                      ///******************* inspectors Type **********************///
                                      if (userRoleName == Rules.Insurance.name) ...{
                                        Text(
                                          'Choose the Inspector Type',
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                color: secondaryGrey,
                                                fontSize: 24.0,
                                              ),
                                        ),
                                        space20Vertical(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: PrimaryCheckbox(
                                                text: InspectorTypes.values[0].name,
                                                icon: Icons.add_home_work_outlined,
                                                initialValue: AppBloc.get(context).selectedInspectorType == InspectorTypes.values[0],
                                                valueChanged: (value) {
                                                  appBloc.inspectorController.clear();
                                                  appBloc.setSelectedInspectorType = InspectorTypes.values[0];
                                                },
                                              ),
                                            ),
                                            space20Horizontal(),
                                            Expanded(
                                              child: PrimaryCheckbox(
                                                text: InspectorTypes.values[1].name,
                                                icon: Icons.person_outline,
                                                initialValue: AppBloc.get(context).selectedInspectorType == InspectorTypes.values[1],
                                                valueChanged: (value) {
                                                  appBloc.inspectorController.clear();
                                                  appBloc.setSelectedInspectorType = InspectorTypes.values[1];
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      },
                                      space20Vertical(),
                                      InkWell(
                                        onTap: () {
                                          if (appBloc.checkIfControllerEmpty(controller: appBloc.inspectorController)) {
                                            showPrimaryPopUp(
                                              context: context,
                                              isDismissible: false,
                                              title: 'Choose the Inspector',
                                              popUpBody: const SelectInspectorPopUp(),
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          //  widget.isUpdate ? true : false,
                                          //  appBloc
                                          //             .selectedInspection ==
                                          //         null
                                          //     ? true
                                          //     : false,
                                          validationError: '',
                                          isValidate: false,
                                          suffixIcon: Text(
                                              '(assigned at: ${appBloc.assignDate != null ? DateTime.parse(appBloc.assignDate!).dateAndTimeFormat : ''})  '),
                                          label: 'Inspector (Click to select, do not try to write or copy here)',
                                          // onTap: () {

                                          //   // showCupertinoModalPopup(
                                          //   //   context: context,
                                          //   //   builder: (context) {
                                          //   //     return CupertinoActionSheet(
                                          //   //       title: Text(
                                          //   //         'Choose the Inspector',
                                          //   //         style: Theme.of(context)
                                          //   //             .textTheme
                                          //   //             .titleLarge!
                                          //   //             .copyWith(
                                          //   //               color: secondaryGrey,
                                          //   //               fontSize: 24.0,
                                          //   //             ),
                                          //   //       ),
                                          //   //       actions: [
                                          //   //         if (appBloc
                                          //   //                 .selectedInspectorType ==
                                          //   //             InspectorTypes
                                          //   //                 .values[0]) ...{
                                          //   //           ...appBloc
                                          //   //               .myInspectionsCompanyList
                                          //   //               .map(
                                          //   //                 (e) =>
                                          //   //                     CupertinoActionSheetAction(
                                          //   //                   child: Text(
                                          //   //                     e.name ?? '',
                                          //   //                   ),
                                          //   //                   onPressed: () {
                                          //   //                     appBloc
                                          //   //                         .inspectionCompanyModel = e;
                                          //   //                     context.pop;
                                          //   //                   },
                                          //   //                 ),
                                          //   //               )
                                          //   //               .toList()
                                          //   //         } else ...{
                                          //   //           ...appBloc
                                          //   //               .inspectors
                                          //   //               .map(
                                          //   //                 (e) =>
                                          //   //                     CupertinoActionSheetAction(
                                          //   //                   child: Text(
                                          //   //                     e.user?.name ?? '',
                                          //   //                   ),
                                          //   //                   onPressed: () {
                                          //   //                     appBloc
                                          //   //                         .inspectorModel = e;
                                          //   //                     context.pop;
                                          //   //                   },
                                          //   //                 ),
                                          //   //               )
                                          //   //               .toList()
                                          //   //         },
                                          //   //       ],
                                          //   //       cancelButton:
                                          //   //           CupertinoActionSheetAction(
                                          //   //         child: Text(
                                          //   //           appTranslation(context)
                                          //   //               .cancel,
                                          //   //         ),
                                          //   //         onPressed: () {
                                          //   //           context.pop;
                                          //   //         },
                                          //   //       ),
                                          //   //     );
                                          //   //   },
                                          //   // );
                                          // },
                                          controller: appBloc.inspectorController,
                                        ),
                                      ),
                                      space20Vertical(),

                                      /// inspectDate, date
                                      InkWell(
                                        onTap: () {
                                          if (appBloc.checkIfControllerEmpty(controller: appBloc.inspectionDateController)) {
                                            showDatePicker(
                                              context: context,
                                              fieldLabelText: 'Inspection Date',
                                              fieldHintText: 'Inspection Date',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then(
                                              (value) {
                                                if (value == null) {
                                                  debugPrint('value is null');
                                                  return;
                                                }
                                                appBloc.inspectionDateController.text = DateFormat('yyyy-MM-dd').format(value).toString();
                                              },
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          validationError: '',
                                          label: 'Inspection Date',
                                          isValidate: false,
                                          controller: appBloc.inspectionDateController,
                                        ),
                                      ),
                                      space20Vertical(),

                                      /// arrivedAt
                                      InkWell(
                                        onTap: () {
                                          if (appBloc.checkIfControllerEmpty(controller: appBloc.arrivedAtController)) {
                                            showDatePicker(
                                              context: context,
                                              fieldLabelText: 'Receiving Date',
                                              fieldHintText: 'Receiving Date',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then(
                                              (value) {
                                                if (value == null) {
                                                  debugPrint('value is null');
                                                  return;
                                                }
                                                appBloc.arrivedAtController.text = DateFormat('yyyy-MM-dd').format(value).toString();
                                              },
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          validationError: '',
                                          label: 'Receiving Date',
                                          isValidate: false,
                                          controller: appBloc.arrivedAtController,
                                        ),
                                      ),
                                      space20Vertical(),

                                      /// followDate
                                      InkWell(
                                        onTap: () {
                                          if (appBloc.checkIfControllerEmpty(controller: appBloc.followDateController)) {
                                            showDatePicker(
                                              context: context,
                                              fieldLabelText: 'Follow-Up Date',
                                              fieldHintText: 'Follow-Up Date',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then(
                                              (value) {
                                                if (value == null) {
                                                  debugPrint('value is null');
                                                  return;
                                                }
                                                appBloc.followDateController.text = DateFormat('yyyy-MM-dd').format(value).toString();
                                              },
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          validationError: '',
                                          label: 'Follow-Up Date',
                                          isValidate: false,
                                          controller: appBloc.followDateController,
                                        ),
                                      ),
                                      space20Vertical(),

                                      ///****************************************** Insurance Images ******************************************///
                                      const MyDivider(),
                                      space20Vertical(),
                                      insuranceImages(context),

                                      if (appBloc.selectedInspection != null)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ///****************************************** Inspector Images ******************************************///
                                            if (appBloc.selectedInspection?.inspectorImages?.isNotEmpty ?? false) ...[
                                              inspectorImages(context),
                                            ],
                                            space20Vertical(),

                                            ///****************************************** Supplement Images ******************************************///
                                            if (appBloc.selectedInspection?.supplementImages?.isNotEmpty ?? false) ...[supplementImages(context)],

                                            ///*********************************** PDF ************************************************///
                                            // const MyDivider(),
                                            // space20Vertical(),
                                            // pdf(context),

                                            ///********************************************************************************************************///
                                            // space20Vertical(),
                                            // const MyDivider(),
                                            // space20Vertical(),
                                            // Text(
                                            //   'Inspector Notes',
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .titleLarge!
                                            //       .copyWith(
                                            //         color: secondaryGrey,
                                            //         fontSize: 20.0,
                                            //       ),
                                            // ),
                                            // space20Vertical(),
                                            // PrimaryFormField(
                                            //   enabled: widget.isUpdate
                                            //       ? true
                                            //       : appBloc
                                            //               .selectedInspection ==
                                            //           null,
                                            //   validationError: '',
                                            //   isValidate: false,
                                            //   label: 'notes',
                                            //   initialValue: appBloc
                                            //       .selectedInspection!
                                            //       .notes,
                                            // ),
                                            // space20Vertical(),
                                          ],
                                        ),
                                      space40Vertical(),

                                      ///************************************ Button ***************************************
                                      PrimaryButton(
                                        isDisabled: (appBloc.selectedInspection != null && appBloc.selectedInspection?.status == 'done'),
                                        text: appBloc.selectedInspection != null
                                            ? appBloc.selectedInspection!.status == 'pending'
                                                ? 'Update and move to finish'
                                                : 'Update'
                                            : 'Confirm',
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            if (appBloc.selectedInspection == null) {
                                              appBloc.createInspection(
                                                isFromFNOL: widget.isOpenFromFNOL,
                                              );
                                            } else {
                                              appBloc.updateInspection(
                                                  status: appBloc.selectedInspection!.status == 'pending' ? InspectionStatus.finished : null);
                                            }
                                          } else {
                                            HelpooInAppNotification.showErrorMessage(
                                              message: 'Please fill all required fields',
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return PrimaryPadding(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  space20Vertical(),
                  SizedBox(
                    width: 1122,
                    child: Row(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     appBloc.changeStackNav(
                        //       index: appBloc.currentSideMenuIndex,
                        //       isAdd: false,
                        //     );
                        //   },
                        //   hoverColor: Colors.transparent,
                        //   highlightColor: Colors.transparent,
                        //   child: Container(
                        //     height: 35,
                        //     width: 35,
                        //     margin: const EdgeInsetsDirectional.only(end: 20),
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       border: Border.all(
                        //         width: 1,
                        //         color: Colors.grey.shade200,
                        //       ),
                        //     ),
                        //     child: RotatedBox(
                        //       quarterTurns: isEnglish ? 2 : 0,
                        //       child: const Icon(
                        //         Icons.keyboard_arrow_right_rounded,
                        //         size: 20,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const BackButtonWidget(),
                        Text(
                          widget.isUpdate ? appTranslation(context).updateInspection : appTranslation(context).createInspection,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  Expanded(
                    child: Container(
                      width: 1122,
                      height: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: PrimaryPadding(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const StepperInspection(),
                            const MyDivider(),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    space20Vertical(),

                                    // client info 0

                                    if (appBloc.activeStepIndex == 0) ...[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.checkIfControllerEmpty(controller: appBloc.clientNameController) || appBloc.selectedInspection == null ? true : false,
                                              // validationError: 'Please Enter Client Name',
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Client Name*',
                                              controller: appBloc.clientNameController,
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.checkIfControllerEmpty(controller: appBloc.clientPhoneController) ? true : false,
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Client Phone',
                                              controller: appBloc.clientPhoneController,
                                            ),
                                          ),
                                        ],
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled: appBloc.checkIfControllerEmpty(controller: appBloc.engPhoneController) ? true : false,
                                        validationError: '',
                                        isValidate: false,
                                        label: 'Engineer\'s Phone',
                                        controller: appBloc.engPhoneController,
                                      ),
                                      space20Vertical(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                // if (appBloc
                                                //             .selectedInspection ==
                                                //         null ||
                                                //     appBloc.checkIfControllerEmpty(
                                                //         controller: appBloc
                                                //             .governmentController)) {

                                                // }
                                                showPrimaryMenu(
                                                  context: context,
                                                  key: governmentKey,
                                                  items: [
                                                    ...appBloc.governments.map(
                                                          (e) => PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          e,
                                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 16.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          appBloc.selectedGovernment = e;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              child: PrimaryFormField(
                                                key: governmentKey,
                                                enabled: false,
                                                // validationError: 'Please Enter Government',
                                                validationError: '',
                                                isValidate: false,
                                                label: 'Government*',
                                                controller: appBloc.governmentController,
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (appBloc.selectedGovernment == null) {
                                                  HelpooInAppNotification.showErrorMessage(message: 'Please select government first');
                                                  return;
                                                }

                                                if (appBloc.selectedInspection == null) {
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: areaKey,
                                                    items: [
                                                      ...appBloc.availableAreas.map(
                                                            (e) => PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            e,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            AppBloc.get(context).selectedArea = e;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                              child: PrimaryFormField(
                                                key: areaKey,
                                                enabled: appBloc.selectedGovernment == null || appBloc.isSelectedGovernmentHasAreas ? false : true,
                                                // validationError: 'Please Enter Area',
                                                validationError: '',
                                                isValidate: false,
                                                label: 'Area*',
                                                controller: appBloc.areaController,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      space20Vertical(),
                                      PrimaryFormField(
                                        enabled:
                                        appBloc.selectedInspection == null || appBloc.checkIfControllerEmpty(controller: appBloc.addressController)
                                            ? true
                                            : false,
                                        // validationError: 'Please Enter Address',
                                        validationError: '',
                                        isValidate: false,
                                        label: 'Address*',
                                        controller: appBloc.addressController,
                                      ),
                                    ],

                                    // car info 1

                                    if (appBloc.activeStepIndex == 1) ...[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              key: carModelKey,
                                              onTap: () {
                                                if (appBloc.manufacturersModel == null) {
                                                  appBloc.getManufacturers();
                                                  return;
                                                }

                                                if (appBloc.selectedInspection == null || appBloc.selectedManufacturer == null) {
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: carTypeKey,
                                                    items: [
                                                      ...appBloc.manufacturersModel!.manufacturers.map(
                                                            (e) => PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            e.enName,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            appBloc.selectedManufacturer = e;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                              child: PrimaryFormField(
                                                key: carTypeKey,
                                                enabled: false,
                                                // appBloc
                                                //             .selectedInspection ==
                                                //         null
                                                //     ? true
                                                //     : false,
                                                controller: appBloc.policyCarTypeController,
                                                // validationError: 'Enter Car Type',
                                                validationError: '',
                                                isValidate: false,
                                                label: 'Car Type*',
                                              ),
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (appBloc.carsModel == null) {
                                                  appBloc.getCarsModels();
                                                  return;
                                                }

                                                if (appBloc.selectedManufacturer == null ||
                                                    appBloc.selectedManufacturer == null && appBloc.selectedInspection == null) {
                                                  HelpooInAppNotification.showErrorMessage(message: 'Please select car type first');
                                                  return;
                                                }

                                                if (appBloc.checkIfControllerEmpty(controller: appBloc.policyCarModelController)) {
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: carModelKey,
                                                    items: [
                                                      ...appBloc.carsModel!.models
                                                          .where((element) => element.manufacturerId == appBloc.selectedManufacturer!.id)
                                                          .map(
                                                            (e) => PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            e.enName,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            appBloc.selectedCarModel = e;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                              child: PrimaryFormField(
                                                enabled: false,
                                                // appBloc
                                                //             .selectedInspection ==
                                                //         null
                                                //     ? true
                                                //     : false,
                                                controller: appBloc.policyCarModelController,
                                                // validationError: 'Enter Car Model',
                                                validationError: '',
                                                isValidate: false,
                                                label: 'Car Model*',
                                              ),
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: InkWell(
                                              key: carColorKey,
                                              onTap: () {
                                                showPrimaryMenu(
                                                  context: context,
                                                  key: carColorKey,
                                                  items: [
                                                    ...carColors.map(
                                                          (e) => PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          e,
                                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 16.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          appBloc.selectedCarColor = e;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                              child: PrimaryFormField(
                                                controller: appBloc.policyCarColorController,
                                                validationError: '',
                                                isValidate: false,
                                                label: 'Car Color',
                                                enabled: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      space20Vertical(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.selectedInspection == null || appBloc.checkIfControllerEmpty(controller: appBloc.vinNumberController) ? true : false,
                                              // validationError: 'Please Enter Vin Number',
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Vin Number*',
                                              controller: appBloc.vinNumberController,
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.selectedInspection == null || appBloc.checkIfControllerEmpty(controller: appBloc.engineNumberController) ? true : false,
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Engine Number',
                                              controller: appBloc.engineNumberController,
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.selectedInspection == null ||
                                                  appBloc.checkIfControllerEmpty(controller: appBloc.plateNumberController)
                                                  ? true
                                                  : false,
                                              // appBloc
                                              //             .selectedInspection ==
                                              //         null
                                              //     ? true
                                              //     : false,
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Plate Number',
                                              controller: appBloc.plateNumberController,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // space20Vertical(),
                                      // PrimaryFormField(
                                      //   enabled: widget.isUpdate ? true : false,
                                      //   //  appBloc
                                      //   //             .selectedInspection ==
                                      //   //         null
                                      //   //     ? true
                                      //   //     : false,
                                      //   validationError: '',
                                      //   isValidate: false,
                                      //   label: 'Engine Number',
                                      //   controller: appBloc
                                      //       .engineNumberController,
                                      // ),
                                    ],


                                    // inspection info 2

                                    if (appBloc.activeStepIndex == 2) ...[
                                      if (userRoleName == Rules.InspectionManager.name)
                                        InkWell(
                                          key: insuranceCompanySelectionKey,
                                          onTap: () {
                                            if (appBloc.insuranceCompanies.isEmpty && !appBloc.isGetAllInsuranceCompanies) {
                                              appBloc.getAllInsuranceCompanies();
                                              return;
                                            }

                                            // if (appBloc.selectedInspection != null ||
                                            //     appBloc.checkIfControllerEmpty(controller: appBloc.insuranceCompanyController)) {
                                            showPrimaryMenu(
                                              context: context,
                                              key: insuranceCompanySelectionKey,
                                              items: [
                                                ...appBloc.insuranceCompanies.map(
                                                      (e) => PopupMenuItem(
                                                    value: 1,
                                                    child: Text(
                                                      e.arName!,
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                        fontSize: 16.0,
                                                        color: secondaryGrey,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      appBloc.selectedInsuranceCompany = e;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                            // }
                                          },
                                          child: PrimaryFormField(
                                            key: insuranceCompanySelectionKey,
                                            enabled: false,
                                            controller: appBloc.insuranceCompanyController,
                                            validationError: 'Select insurance company',
                                            label: 'Insurance Company*',
                                          ),
                                        ),
                                      space20Vertical(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.selectedInspection == null ||
                                                  appBloc.checkIfControllerEmpty(controller: appBloc.accidentDescriptionController)
                                                  ? true
                                                  : false,
                                              //  appBloc
                                              //             .selectedInspection ==
                                              //         null
                                              //     ? true
                                              //     : false,
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Accident Description',
                                              controller: appBloc.accidentDescriptionController,
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: PrimaryFormField(
                                              enabled: appBloc.selectedInspection == null ||
                                                  appBloc.checkIfControllerEmpty(controller: appBloc.accidentExceptionsController)
                                                  ? true
                                                  : false,
                                              //  appBloc
                                              //             .selectedInspection ==
                                              //         null
                                              //     ? true
                                              //     : false,
                                              validationError: '',
                                              isValidate: false,
                                              label: 'Exceptions',
                                              controller: appBloc.accidentExceptionsController,
                                            ),
                                          ),
                                          space20Horizontal(),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (appBloc.selectedInspection == null ||
                                                    appBloc.checkIfControllerEmpty(controller: appBloc.inspectionTypeController)) {
                                                  showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (context) {
                                                      return CupertinoActionSheet(
                                                        title: Text(
                                                          'Type of the Inspection',
                                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                            color: secondaryGrey,
                                                            fontSize: 24.0,
                                                          ),
                                                        ),
                                                        actions: [
                                                          ...InspectionType.values
                                                              .map(
                                                                (e) => CupertinoActionSheetAction(
                                                              child: Text(
                                                                e.arName,
                                                              ),
                                                              onPressed: () {
                                                                appBloc.inspectionType = e;
                                                                context.pop;
                                                              },
                                                            ),
                                                          )
                                                              ,
                                                        ],
                                                        cancelButton: CupertinoActionSheetAction(
                                                          child: Text(
                                                            appTranslation(context).cancel,
                                                          ),
                                                          onPressed: () {
                                                            context.pop;
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: PrimaryFormField(
                                                enabled: false,
                                                // appBloc
                                                //             .selectedInspection ==
                                                //         null
                                                //     ? true
                                                //     : false,
                                                validationError: 'Enter Inspection Type',
                                                label: 'Type of the Inspection* (Click to select, do not try to write or copy here)',

                                                controller: appBloc.inspectionTypeController,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      space20Vertical(),
                                      ///******************* inspectors Type **********************///
                                      if (userRoleName == Rules.Insurance.name) ...{
                                        Text(
                                          'Choose the Inspector Type',
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: secondaryGrey,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                        space20Vertical(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: PrimaryCheckbox(
                                                text: InspectorTypes.values[0].name,
                                                icon: Icons.add_home_work_outlined,
                                                initialValue: appBloc.selectedInspectorType == InspectorTypes.values[0],
                                                valueChanged: (value) {
                                                  if (appBloc.selectedInspection == null ||
                                                      appBloc.checkIfControllerEmpty(controller: appBloc.inspectorController)) {
                                                    appBloc.inspectorController.clear();
                                                    appBloc.setSelectedInspectorType = InspectorTypes.values[0];
                                                  }
                                                },
                                              ),
                                            ),
                                            space20Horizontal(),
                                            Expanded(
                                              child: PrimaryCheckbox(
                                                text: InspectorTypes.values[1].name,
                                                icon: Icons.person_outline,
                                                initialValue: appBloc.selectedInspectorType == InspectorTypes.values[1],
                                                valueChanged: (value) {
                                                  if (appBloc.selectedInspection == null ||
                                                      appBloc.checkIfControllerEmpty(controller: appBloc.inspectorController)) {
                                                    appBloc.inspectorController.clear();
                                                    appBloc.setSelectedInspectorType = InspectorTypes.values[1];
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      },
                                      space20Vertical(),
                                      InkWell(
                                        onTap: () {
                                          if ((appBloc.selectedInspection == null && userRoleName == Rules.Insurance.name) || userRoleName == Rules.InspectionManager.name) {
                                            showPrimaryPopUp(
                                              context: context,
                                              isDismissible: false,
                                              title: 'Choose the Inspector',
                                              popUpBody: const SelectInspectorPopUp(),
                                            );
                                          }
                                        },
                                        child: PrimaryFormField(
                                          enabled: false,
                                          //  widget.isUpdate ? true : false,
                                          //  appBloc
                                          //             .selectedInspection ==
                                          //         null
                                          //     ? true
                                          //     : false,
                                          validationError: '',
                                          isValidate: false,
                                          suffixIcon: Text(
                                              '(assigned at: ${appBloc.assignDate != null ? DateTime.parse(appBloc.assignDate!).dateAndTimeFormat : ''})  '),
                                          label: 'Inspector* (Click to select, do not try to write or copy here)',
                                          // onTap: () {

                                          //   // showCupertinoModalPopup(
                                          //   //   context: context,
                                          //   //   builder: (context) {
                                          //   //     return CupertinoActionSheet(
                                          //   //       title: Text(
                                          //   //         'Choose the Inspector',
                                          //   //         style: Theme.of(context)
                                          //   //             .textTheme
                                          //   //             .titleLarge!
                                          //   //             .copyWith(
                                          //   //               color: secondaryGrey,
                                          //   //               fontSize: 24.0,
                                          //   //             ),
                                          //   //       ),
                                          //   //       actions: [
                                          //   //         if (appBloc
                                          //   //                 .selectedInspectorType ==
                                          //   //             InspectorTypes
                                          //   //                 .values[0]) ...{
                                          //   //           ...appBloc
                                          //   //               .myInspectionsCompanyList
                                          //   //               .map(
                                          //   //                 (e) =>
                                          //   //                     CupertinoActionSheetAction(
                                          //   //                   child: Text(
                                          //   //                     e.name ?? '',
                                          //   //                   ),
                                          //   //                   onPressed: () {
                                          //   //                     appBloc
                                          //   //                         .inspectionCompanyModel = e;
                                          //   //                     context.pop;
                                          //   //                   },
                                          //   //                 ),
                                          //   //               )
                                          //   //               .toList()
                                          //   //         } else ...{
                                          //   //           ...appBloc
                                          //   //               .inspectors
                                          //   //               .map(
                                          //   //                 (e) =>
                                          //   //                     CupertinoActionSheetAction(
                                          //   //                   child: Text(
                                          //   //                     e.user?.name ?? '',
                                          //   //                   ),
                                          //   //                   onPressed: () {
                                          //   //                     appBloc
                                          //   //                         .inspectorModel = e;
                                          //   //                     context.pop;
                                          //   //                   },
                                          //   //                 ),
                                          //   //               )
                                          //   //               .toList()
                                          //   //         },
                                          //   //       ],
                                          //   //       cancelButton:
                                          //   //           CupertinoActionSheetAction(
                                          //   //         child: Text(
                                          //   //           appTranslation(context)
                                          //   //               .cancel,
                                          //   //         ),
                                          //   //         onPressed: () {
                                          //   //           context.pop;
                                          //   //         },
                                          //   //       ),
                                          //   //     );
                                          //   //   },
                                          //   // );
                                          // },
                                          controller: appBloc.inspectorController,
                                        ),
                                      ),
                                      space20Vertical(),
                                      ///****************************************** dates ***************************************************///
                                      /// arrivedAt
                                      if (userRoleName == Rules.InspectionManager.name) ...{
                                        InkWell(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              fieldLabelText: 'Receiving Date',
                                              fieldHintText: 'Receiving Date',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then(
                                                  (value) {
                                                if (value == null) {
                                                  debugPrint('value is null');
                                                  return;
                                                }
                                                appBloc.arrivedAtController.text = DateFormat('yyyy-MM-dd').format(value).toString();
                                              },
                                            );
                                          },
                                          child: PrimaryFormField(
                                            enabled: false,
                                            validationError: '',
                                            label: 'Receiving Date',
                                            isValidate: false,
                                            controller: appBloc.arrivedAtController,
                                          ),
                                        ),
                                        space20Vertical(),
                                      },
                                      /// inspectDate, date
                                      if (userRoleName == Rules.InspectionManager.name ||
                                          (userRoleName == Rules.Insurance.name && appBloc.selectedInspectorType == InspectorTypes.values[1])) ...{
                                        InkWell(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              fieldLabelText: 'Inspection Date',
                                              fieldHintText: 'Inspection Date',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then(
                                                  (value) {
                                                if (value == null) {
                                                  debugPrint('value is null');
                                                  return;
                                                }
                                                appBloc.inspectionDateController.text = DateFormat('yyyy-MM-dd').format(value).toString();
                                              },
                                            );
                                          },
                                          child: PrimaryFormField(
                                            enabled: false,
                                            validationError: '',
                                            label: 'Inspection Date',
                                            isValidate: false,
                                            controller: appBloc.inspectionDateController,
                                          ),
                                        ),
                                        space20Vertical(),
                                      },
                                      /// followDate
                                      if (userRoleName == Rules.InspectionManager.name) ...{
                                        InkWell(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              fieldLabelText: 'Follow-Up Date',
                                              fieldHintText: 'Follow-Up Date',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then(
                                                  (value) {
                                                if (value == null) {
                                                  debugPrint('value is null');
                                                  return;
                                                }
                                                appBloc.followDateController.text = DateFormat('yyyy-MM-dd').format(value).toString();
                                              },
                                            );
                                          },
                                          child: PrimaryFormField(
                                            enabled: false,
                                            validationError: '',
                                            label: 'Follow-Up Date',
                                            isValidate: false,
                                            controller: appBloc.followDateController,
                                          ),
                                        ),
                                        space20Vertical(),
                                      },
                                    ],


                                    // attachs info 3

                                    if (appBloc.activeStepIndex == 3) ...[
                                      ///****************************************** Insurance Images ******************************************///
                                      const MyDivider(),
                                      space20Vertical(),
                                      insuranceImages(context),

                                      ///*********************************** ATTACHMENTS ************************************************///
                                      const MyDivider(),
                                      space20Vertical(),
                                      attachments(context),
                                    ],

                                    // additional info 4

                                    if (appBloc.activeStepIndex == 4) ...[
                                      ///************************************ commitment data *****************************************************///
                                      if (appBloc.inspectionType == InspectionType.beforeRepair ||
                                          appBloc.inspectionType == InspectionType.preInception ||
                                          appBloc.inspectionType == InspectionType.afterRepair) ...[
                                        InkWell(
                                          key: commitmentKey,
                                          onTap: () {
                                            // appBloc.selectedInspection == null && appBloc.checkIfControllerEmpty(controller: appBloc.notCommittedReasonController)
                                            if (appBloc.selectedInspection == null ||
                                                appBloc.checkIfControllerEmpty(controller: appBloc.commitmentStatusController)) {
                                              showPrimaryMenu(
                                                context: context,
                                                key: commitmentKey,
                                                items: [
                                                  ...CommitmentStatus.values.map(
                                                        (e) => PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        e.arName,
                                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                          fontSize: 16.0,
                                                          color: secondaryGrey,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        appBloc.setCommitmentStatus(status: e);
                                                        appBloc.commitmentStatusController.text = e.arName;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                          child: PrimaryFormField(
                                            enabled: false,
                                            controller: appBloc.commitmentStatusController,
                                            isValidate: false,
                                            validationError: '',
                                            label: 'بالتزام ام بدون؟',
                                          ),
                                        ),
                                        space20Vertical(),
                                        PrimaryFormField(
                                          enabled: appBloc.selectedInspection == null && appBloc.commitmentStatus == CommitmentStatus.notCommitted,
                                          isValidate: false,
                                          validationError: '',
                                          label: 'سبب عدم الالتزام ان وجد',
                                          controller: appBloc.notCommittedReasonController,
                                        ),
                                        space20Vertical(),
                                      ],
                                    ],

                                    // inspector process info 5

                                    if (appBloc.activeStepIndex == 5) ...[
                                      ///******************************************** when update (supplement images, inspector images, pdf, notes) **********************************************///
                                      if (appBloc.selectedInspection != null &&
                                          appBloc.selectedInspection!.status! != InspectionStatus.pending.name) ...[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ///****************************************** Inspector Images ******************************************///
                                            if (appBloc.selectedInspection?.inspectorImages?.isNotEmpty ?? false) ...[
                                              inspectorImages(context),
                                            ],
                                            space20Vertical(),

                                            ///****************************************** Supplement Images ******************************************///
                                            if (appBloc.selectedInspection?.supplementImages?.isNotEmpty ?? false) ...[supplementImages(context)],

                                            ///****************************************** Supplement Images ******************************************///
                                            const MyDivider(),
                                            space20Vertical(),
                                            if (appBloc.selectedInspection?.additionalPaperImages?.isNotEmpty ?? false) ...[additionalPaperImages(context)],

                                            ///*********************************** PDF ************************************************///
                                            const MyDivider(),
                                            space20Vertical(),
                                            pdf(context),

                                            ///************************************ notes *****************************************************///
                                            space20Vertical(),
                                            const MyDivider(),
                                            space20Vertical(),
                                            Text(
                                              'Inspector Notes',
                                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                color: secondaryGrey,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            space20Vertical(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: PrimaryFormField(
                                                    enabled: false,
                                                    validationError: '',
                                                    infiniteLines: true,
                                                    isValidate: false,
                                                    label: 'notes',
                                                    initialValue: appBloc.selectedInspection!.notes,
                                                  ),
                                                ),
                                                if (appBloc.selectedInspection!.audioRecords != null &&
                                                    appBloc.selectedInspection!.audioRecords!.isNotEmpty)
                                                  space20Horizontal(),
                                                if (appBloc.selectedInspection!.audioRecords != null &&
                                                    appBloc.selectedInspection!.audioRecords!.isNotEmpty)
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          if (!await launchUrl(Uri.parse(
                                                              '$imagesBaseUrl${appBloc.selectedInspection!.audioRecords!.first.audioPath}'))) {
                                                            throw Exception(
                                                              'Could not launch ${appBloc.selectedInspection!.audioRecords!.first.audioPath}',
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Theme.of(context).primaryColor,
                                                          ),
                                                          child: const Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      if (userRoleName == Rules.InspectionManager.name)
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.sticky_note_2,
                                                            color: Colors.green,
                                                            size: 30.0,
                                                            // outlook,
                                                          ),
                                                          onPressed: () async {
                                                            appBloc.extractedRecoTextController.text =
                                                                appBloc.selectedInspection!.audioRecords?.first.text ?? '';
                                                            showPrimaryPopUp(
                                                              context: context,
                                                              isDismissible: false,
                                                              title: 'Extract record data',
                                                              popUpBody: ExtractRecoToTextPopUp(isSupplementImage: false),
                                                            );
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                            space20Vertical(),
                                          ],
                                        ),
                                      ],
                                    ],

                                    // inspection manager features info 6

                                    if (appBloc.activeStepIndex == 6) ...[
                                      ///*************************** INSPECTION MANAGER VIEWs ******************************///
                                      ///**************************  &&  STATUS IS NOT PENDING ! ***************************///
                                      ///
                                      if (userRoleName == Rules.InspectionManager.name &&
                                          appBloc.selectedInspection != null &&
                                          appBloc.selectedInspection!.status! != InspectionStatus.pending.name) ...[
                                        ///*********************************** ACCIDENT LIST ************************************************///
                                        accidentList(context),

                                        ///*********************************** PARTS LIST ************************************************///
                                        const MyDivider(),
                                        space20Vertical(),
                                        partsList(context),

                                        ///*********************************** WORK FEES ************************************************///
                                        const MyDivider(),
                                        space20Vertical(),
                                        workerFees(context),

                                        ///*********************************** DAMAGE DESCRIPTION ************************************************///
                                        const MyDivider(),
                                        space20Vertical(),
                                        damageDescription(context),
                                      ],
                                    ],

                                    ///*************************** Loading upload indicator *****************************
                                    if (state is UploadInsuranceImagesLoadingState) const LoadingProgressWidget(),

                                    ///************************************ Buttons **************************************

                                    if ((appBloc.activeStepIndex == 4 && appBloc.selectedInspection == null) ||
                                        (appBloc.activeStepIndex == 4 && appBloc.selectedInspection != null && appBloc.selectedInspection!.inspectionStatus == InspectionsStatus.pending) ||
                                        (appBloc.activeStepIndex == 5 && userRoleName == Rules.Insurance.name && appBloc.selectedInspection != null && appBloc.selectedInspection!.inspectionStatus != InspectionsStatus.pending) ||
                                        (appBloc.activeStepIndex == 6 && userRoleName == Rules.InspectionManager.name && appBloc.selectedInspection != null && appBloc.selectedInspection!.inspectionStatus != InspectionsStatus.pending)
                                    ) ...[
                                      if (appBloc.selectedInspection == null)
                                        PrimaryButton(
                                          isDisabled: (appBloc.createInspectionLoading),
                                          isLoading: appBloc.createInspectionLoading,
                                          text: 'Create',
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              appBloc.createInspection();
                                            } else {
                                              HelpooInAppNotification.showErrorMessage(message: 'Please fill all required fields');
                                            }
                                          },
                                        ),
                                      if (appBloc.selectedInspection != null) ...[
                                        space20Vertical(),
                                        PrimaryButton(
                                          isDisabled: (appBloc.updateInspectionLoading),
                                          isLoading: (appBloc.updateInspectionLoading),
                                          text: 'Update',
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              appBloc.updateInspection();
                                            } else {
                                              HelpooInAppNotification.showErrorMessage(
                                                message: 'Please fill all required fields',
                                              );
                                            }
                                          },
                                        ),
                                        space20Vertical(),
                                        PrimaryButton(
                                          isDisabled: (appBloc.updateInspectionLoading),
                                          isLoading: (appBloc.updateInspectionLoading),
                                          text: 'Update and move to "Done"',
                                          backgroundColor: Colors.white,
                                          textColor: mainColorHex,
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              appBloc.updateInspection(status: InspectionStatus.done);
                                            } else {
                                              HelpooInAppNotification.showErrorMessage(
                                                message: 'Please fill all required fields',
                                              );
                                            }
                                          },
                                        ),
                                        space20Vertical(),
                                        PrimaryButton(
                                          isDisabled: (appBloc.updateInspectionLoading),
                                          isLoading: (appBloc.updateInspectionLoading),
                                          text: 'Update and move to "Pending"',
                                          backgroundColor: Colors.white,
                                          textColor: mainColorHex,
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              appBloc.updateInspection(status: InspectionStatus.pending);
                                            } else {
                                              HelpooInAppNotification.showErrorMessage(
                                                message: 'Please fill all required fields',
                                              );
                                            }
                                          },
                                        ),
                                        space20Vertical(),
                                        PrimaryButton(
                                          isDisabled: (appBloc.updateInspectionLoading),
                                          isLoading: (appBloc.updateInspectionLoading),
                                          text: 'Update and move to "Finished"',
                                          backgroundColor: Colors.white,
                                          textColor: mainColorHex,
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              appBloc.updateInspection(status: InspectionStatus.finished);
                                            } else {
                                              HelpooInAppNotification.showErrorMessage(
                                                message: 'Please fill all required fields',
                                              );
                                            }
                                          },
                                        ),
                                        space5Vertical(),
                                      ],
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: PrimaryButton(
                                    text: 'Previous',
                                    onPressed: () {
                                      appBloc.decrementActiveStepIndex();
                                      debugPrint('iiiiiiiiiiii ${appBloc.activeStepIndex}');
                                    },
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100,
                                  child: PrimaryButton(
                                    text: 'Next',
                                    onPressed: () {
                                      appBloc.incrementActiveStepIndex();
                                      debugPrint('iiiiiiiiiiii ${appBloc.activeStepIndex}');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//******************************************************************************
  Column insuranceImages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (appBloc.selectedInspection?.insuranceImages?.isNotEmpty ?? false) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 200.0,
                child: PrimaryButton(
                  isLoading: appBloc.downloadAdminImagesAsZipLoading,
                  text: 'Download Images',
                  onPressed: () async {
                    await appBloc.downloadImages(
                        appBloc.selectedInspection?.insuranceImages?.map((e) => e.imagePath ?? '').toList() ?? [], 'images.zip', true);
                  },
                ),
              ),
            ],
          ),
          space20Vertical(),
        ],
        Row(
          children: [
            InkWell(
              onTap: () {
                appBloc.selectFiles();
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: HexColor(mainColor),
                        size: 50.0,
                      ),
                      space20Vertical(),
                      Text(
                        'Add Images',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: HexColor(mainColor),
                              fontSize: 20.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            space20Horizontal(),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                ///************************** Local Images **************************
                if (appBloc.filesResult != null)
                  ...appBloc.filesResult!.files
                      .map(
                        (e) => Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(e.bytes!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: borderGrey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  appBloc.removeFile(e);
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                      ,

                ///************************** Remote Images **************************
                if (appBloc.selectedInspection?.insuranceImages?.isNotEmpty ?? false)
                  ...appBloc.selectedInspection!.insuranceImages!
                      .map(
                        (e) => Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('$imagesBaseUrl${e.imagePath}'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: borderGrey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.download_for_offline_rounded,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  if (!await launchUrl(Uri.parse('$imagesBaseUrl${e.imagePath}'))) {
                                    throw Exception(
                                      'Could not launch ${e.imagePath}',
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                      ,
              ],
            ),
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column inspectorImages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Inspector Images',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: secondaryGrey,
                    fontSize: 20.0,
                  ),
            ),
            if (appBloc.selectedInspection?.inspectorImages?.isNotEmpty ?? false)
              SizedBox(
                width: 200.0,
                child: PrimaryButton(
                  isLoading: appBloc.downloadInspectorImagesAsZipLoading,
                  text: 'Download Images',
                  onPressed: () async {
                    await appBloc.downloadImages(
                      appBloc.selectedInspection?.inspectorImages?.map((e) => e.imagePath ?? '').toList() ?? [],
                      'images.zip',
                      false,
                    );
                  },
                ),
              ),
          ],
        ),
        space20Vertical(),
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            if (appBloc.selectedInspection?.inspectorImages?.isNotEmpty ?? false)
              ...appBloc.selectedInspection!.inspectorImages!
                  .map(
                    (e) => Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('$imagesBaseUrl${e.imagePath}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              width: 200,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  e.text!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: IconButton(
                              icon: const Icon(
                                Icons.download_for_offline_rounded,
                                color: Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                if (!await launchUrl(Uri.parse('$imagesBaseUrl${e.imagePath}'))) {
                                  throw Exception(
                                    'Could not launch $e',
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  ,
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column additionalPaperImages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Papers',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: secondaryGrey,
                fontSize: 20.0,
              ),
        ),
        space20Vertical(),
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            if (appBloc.selectedInspection?.additionalPaperImages?.isNotEmpty ?? false)
              ...appBloc.selectedInspection!.additionalPaperImages!
                  .map(
                    (e) => Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('$imagesBaseUrl${e.imagePath}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Container(
                              width: 200,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  e.text!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: IconButton(
                              icon: const Icon(
                                Icons.download_for_offline_rounded,
                                color: Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                if (!await launchUrl(Uri.parse('$imagesBaseUrl${e.imagePath}'))) {
                                  throw Exception(
                                    'Could not launch $e',
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  ,
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column supplementImages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        space20Vertical(),
        const MyDivider(),
        space20Vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Supplement Images',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: secondaryGrey,
                    fontSize: 20.0,
                  ),
            ),
            SizedBox(
              width: 200.0,
              child: PrimaryButton(
                isLoading: appBloc.downloadInspectorImagesAsZipLoading,
                text: 'Download Images',
                onPressed: () async {
                  await appBloc.downloadImages(
                    appBloc.selectedInspection?.supplementImages?.map((e) => e.imagePath ?? '').toList() ?? [],
                    'images.zip',
                    false,
                  );
                },
              ),
            ),
          ],
        ),
        space20Vertical(),
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            ...appBloc.selectedInspection!.supplementImages!
                .map(
                  (e) => Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('$imagesBaseUrl${e.imagePath}'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: borderGrey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Wrap(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.download_for_offline_rounded,
                                color: Colors.green,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                debugPrint('----------- >> $imagesBaseUrl${e.imagePath}');
                                if (!await launchUrl(Uri.parse('$imagesBaseUrl${e.imagePath}'))) {
                                  throw Exception(
                                    'Could not launch $e',
                                  );
                                }
                              },
                            ),
                            if (e.text != null && e.text!.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.text_fields,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  showPrimaryPopUp(
                                    context: context,
                                    popUpBody: Text(
                                      '${e.text}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: secondaryGrey,
                                            fontSize: 20.0,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            if (e.reco64 != null && e.reco64!.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.play_circle,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  if (!await launchUrl(Uri.parse('$imagesBaseUrl${e.reco64}'))) {
                                    throw Exception(
                                      'Could not launch $e',
                                    );
                                  }
                                },
                              ),
                            if (userRoleName == Rules.InspectionManager.name && e.reco64 != null && e.reco64!.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.sticky_note_2,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  appBloc.extractedRecoTextController.text = e.audioText ?? '';
                                  appBloc.selectedSupplementImage = e;
                                  showPrimaryPopUp(
                                    context: context,
                                    isDismissible: false,
                                    title: 'Extract record data',
                                    popUpBody: ExtractRecoToTextPopUp(),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                ,
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column pdf(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Pdf Report',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: secondaryGrey,
                fontSize: 20.0,
              ),
        ),
        space20Vertical(),
        // if (appBloc
        //             .pdfFileResult ==
        //         null &&
        //     (appBloc.selectedInspection?.pdfReports?.isEmpty ?? false))
        Row(
          children: [
            InkWell(
              onTap: () {
                appBloc.selectPDF();
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: HexColor(mainColor),
                        size: 50.0,
                      ),
                      space20Vertical(),
                      Text(
                        'Add PDF',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: HexColor(mainColor),
                              fontSize: 20.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            space20Horizontal(),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                ///************************** Local PDFs **************************
                if (appBloc.pdfFileResult != null)
                  ...appBloc.pdfFileResult!.files.map((e) {
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: HexColor(mainColor),
                                  size: 50.0,
                                ),
                                space10Vertical(),
                                Text(
                                  e.name,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: HexColor(mainColor),
                                        fontSize: 20.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  appBloc.removePDF(e);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),

                ///************************** Remote PDFs **************************
                if (appBloc.selectedInspection?.pdfReports?.isNotEmpty ?? false)
                  ...appBloc.selectedInspection!.pdfReports!.map((e) {
                    return InkWell(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse('$imagesBaseUrl$e'))) {
                          throw Exception(
                            'Could not launch $e',
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: borderGrey,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.picture_as_pdf,
                                    color: HexColor(mainColor),
                                    size: 50.0,
                                  ),
                                  space10Vertical(),
                                  Text(
                                    'Press here to view Pdf',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: HexColor(mainColor),
                                          fontSize: 20.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //   const EdgeInsets.all(
                            //       8.0),
                            //   child: Align(
                            //     alignment:
                            //     AlignmentDirectional
                            //         .topStart,
                            //     child: IconButton(
                            //       icon: const Icon(
                            //         Icons
                            //             .download_for_offline_rounded,
                            //         color: Colors.green,
                            //         size: 30.0,
                            //       ),
                            //       onPressed: () async {
                            //         String pdf = AppBloc
                            //             .get(
                            //             context)
                            //             .selectedInspection!
                            //             .adminPdf!;
                            //
                            //         if (!await launchUrl(
                            //             Uri.parse(
                            //                 pdf))) {
                            //           throw Exception(
                            //             'Could not launch $pdf',
                            //           );
                            //         }
                            //       },
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  }),

                if (appBloc.selectedInspection!.inspectionsReports!.isNotEmpty)
                  ...appBloc.selectedInspection!.inspectionsReports!.map((e) => InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse('$imagesBaseUrl${e.report}'))) {
                        throw Exception(
                          'Could not launch $e',
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [ //
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: HexColor(mainColor),
                                  size: 50.0,
                                ),
                                space10Vertical(),
                                Text(
                                  'Press here to view Pdf (Solera)',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: HexColor(mainColor),
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),

              ],
            ),
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column attachments(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional attachments',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: secondaryGrey,
                fontSize: 20.0,
              ),
        ),
        space20Vertical(),
        // if (appBloc
        //             .pdfFileResult ==
        //         null &&
        //     (appBloc.selectedInspection?.pdfReports?.isEmpty ?? false))
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            InkWell(
              onTap: () {
                appBloc.selectAttachment();
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attachment,
                        color: HexColor(mainColor),
                        size: 50.0,
                      ),
                      space20Vertical(),
                      Text(
                        'Attach File',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: HexColor(mainColor),
                              fontSize: 20.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///************************** Local Attachments **************************
            if (appBloc.attachmentFileResult != null)
              ...appBloc.attachmentFileResult!.files.map((e) {
                return Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: borderGrey,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_copy,
                              color: HexColor(mainColor),
                              size: 50.0,
                            ),
                            space10Vertical(),
                            Text(
                              e.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: HexColor(mainColor),
                                    fontSize: 20.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 30.0,
                            ),
                            onPressed: () {
                              appBloc.removeAttachment(e);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),

            ///************************** Remote Attachment **************************
            if (appBloc.selectedInspection?.insuranceAttachments?.isNotEmpty ?? false)
              ...appBloc.selectedInspection!.insuranceAttachments!.map((e) {
                return InkWell(
                  onTap: () async {
                    if (!await launchUrl(Uri.parse('$imagesBaseUrl/$e'))) {
                      throw Exception(
                        'Could not launch $e',
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: borderGrey,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_copy,
                                color: HexColor(mainColor),
                                size: 50.0,
                              ),
                              space10Vertical(),
                              Text(
                                'Press here to view attachment',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: HexColor(mainColor),
                                      fontSize: 20.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //   const EdgeInsets.all(
                        //       8.0),
                        //   child: Align(
                        //     alignment:
                        //     AlignmentDirectional
                        //         .topStart,
                        //     child: IconButton(
                        //       icon: const Icon(
                        //         Icons
                        //             .download_for_offline_rounded,
                        //         color: Colors.green,
                        //         size: 30.0,
                        //       ),
                        //       onPressed: () async {
                        //         String pdf = AppBloc
                        //             .get(
                        //             context)
                        //             .selectedInspection!
                        //             .adminPdf!;
                        //
                        //         if (!await launchUrl(
                        //             Uri.parse(
                        //                 pdf))) {
                        //           throw Exception(
                        //             'Could not launch $pdf',
                        //           );
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              })
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column accidentList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accidents List',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: secondaryGrey,
                fontSize: 20.0,
              ),
        ),
        space20Vertical(),
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            InkWell(
              onTap: () {
                appBloc.accidentDescController.clear();
                appBloc.accidentOpinionController.clear();
                showPrimaryPopUp(
                  context: context,
                  isDismissible: false,
                  title: 'Enter accident details',
                  popUpBody: AccidentDetailsPopUp(),
                );
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: HexColor(mainColor),
                        size: 50.0,
                      ),
                      space20Vertical(),
                      Text(
                        'Add Accident',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: HexColor(mainColor),
                              fontSize: 20.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (appBloc.selectedInspection?.accidentList?.isNotEmpty ?? false)
              ...appBloc.selectedInspection!.accidentList!.map((e) {
                return InkWell(
                  onTap: () async {
                    appBloc.accidentDescController.text = e.description ?? '';
                    appBloc.accidentOpinionController.text = e.opinion ?? '';
                    showPrimaryPopUp(
                      context: context,
                      isDismissible: false,
                      title: 'Enter accident details',
                      popUpBody: AccidentDetailsPopUp(accident: e),
                    );
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: borderGrey,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.car_crash,
                                color: HexColor(mainColor),
                                size: 50.0,
                              ),
                              space20Vertical(),
                              Text(
                                'Accident',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: HexColor(mainColor),
                                      fontSize: 20.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //   const EdgeInsets.all(
                        //       8.0),
                        //   child: Align(
                        //     alignment:
                        //     AlignmentDirectional
                        //         .topStart,
                        //     child: IconButton(
                        //       icon: const Icon(
                        //         Icons
                        //             .download_for_offline_rounded,
                        //         color: Colors.green,
                        //         size: 30.0,
                        //       ),
                        //       onPressed: () async {
                        //         String pdf = AppBloc
                        //             .get(
                        //             context)
                        //             .selectedInspection!
                        //             .adminPdf!;
                        //
                        //         if (!await launchUrl(
                        //             Uri.parse(
                        //                 pdf))) {
                        //           throw Exception(
                        //             'Could not launch $pdf',
                        //           );
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              })
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column partsList(BuildContext context) {
    debugPrint('------------> > > ${appBloc.selectedInspection!.partsList}');
    debugPrint('------------> > > ${appBloc.selectedInspection!.partsList?.length}');
    // debugPrint('------------> > > ${appBloc.selectedInspection!.partsList?.first.partPriceTextEditingController}');
    // debugPrint('------------> > > ${appBloc.selectedInspection!.partsList?.first.partPriceTextEditingController?.text}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Parts to replace',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: secondaryGrey,
                    fontSize: 20.0,
                  ),
            ),
            InkWell(
              onTap: () {
                // add an empty item to the parts list to show selection list
                // if (appBloc.selectedInspection!.partsList!.isNotEmpty && appBloc.selectedInspection!.partsList!.last.name == null) {
                if (appBloc.selectedInspection!.partsList!.isNotEmpty &&
                        appBloc.selectedInspection!.partsList!.last.partNameTextEditingController!.text.isEmpty ||
                    appBloc.selectedInspection!.partsList!.isNotEmpty &&
                        appBloc.selectedInspection!.partsList!.last.partPriceTextEditingController!.text.isEmpty) {
                  HelpooInAppNotification.showErrorMessage(message: 'Enter the data of the last part you added first');
                  return;
                }
                appBloc.addPartModelField();
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: HexColor(mainColor),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        space20Vertical(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appBloc.selectedInspection!.partsList!.length,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => space10Vertical(),
          itemBuilder: (context, index) {
            // appBloc.selectedInspection!.partsList![index].partNameTextEditingController!.text = appBloc.selectedInspection!.partsList![index].name!;
            // appBloc.selectedInspection!.partsList![index].partPriceTextEditingController!.text = appBloc.selectedInspection!.partsList![index].price!;
            // appBloc.selectedInspection!.partsList![index].textEditingController!.text = '${e.name} - ${e.price}';
            // appBloc.selectedInspection!.partsList!.last.selectedPart = e;
            ///* return a pop up list to select paret from
            // return InkWell(
            //   onTap: () {
            //     showPrimaryMenu(
            //       context: context,
            //       // key: appBloc.partsListView[index].globalKey!,
            //       key: appBloc.selectedInspection!.partsList![index].globalKey!,
            //       items: [
            //         ...[
            //           PartModel(name: 'battery', price: '20 egp'),
            //           PartModel(name: 'engine', price: '50 egp'),
            //           PartModel(name: 'mirror', price: '10 egp'),
            //         ].map((e) => PopupMenuItem(
            //             value: 1,
            //             child: Text(
            //               '${e.name} - ${e.price}',
            //               style: Theme.of(context).textTheme.displaySmall!.copyWith(
            //                 fontSize: 16.0,
            //                 color: secondaryGrey,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //             onTap: () {
            //               // save this part data to the last one added (the empty one)
            //               // appBloc.partsListView[index].textEditingController!.text = '${e.name} - ${e.price}';
            //               appBloc.selectedInspection!.partsList![index].textEditingController!.text = '${e.name} - ${e.price}';
            //               appBloc.selectedInspection!.partsList!.last.selectedPart = e;
            //             },
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            //   child: PrimaryFormField(
            //     key: appBloc.selectedInspection!.partsList![index].globalKey!,
            //     controller: appBloc.selectedInspection!.partsList![index].textEditingController!,
            //     isValidate: false,
            //     validationError: '',
            //     label: 'Select Part*',
            //     enabled: false,
            //   ),
            // );
            ///* return 2 fields to write manually
            return Row(
              children: [
                Expanded(
                  child: PrimaryFormField(
                    enabled: true,
                    validationError: 'enter part name',
                    isValidate: true,
                    label: 'Part name*',
                    // appBloc.selectedInspection!.partsList![index].textEditingController!.text = '${e.name} - ${e.price}';
                    // appBloc.selectedInspection!.partsList!.last.selectedPart = e;
                    controller: appBloc.selectedInspection!.partsList![index].partNameTextEditingController!,
                  ),
                ),
                space20Horizontal(),
                Expanded(
                  child: PrimaryFormField(
                    enabled: true,
                    validationError: 'enter part price',
                    isValidate: true,
                    label: 'Part price*',
                    controller: appBloc.selectedInspection!.partsList![index].partPriceTextEditingController!,
                  ),
                ),
              ],
            );
            // return InkWell(
            //   onTap: () {
            //     showPrimaryMenu(
            //       context: context,
            //       // key: appBloc.partsListView[index].globalKey!,
            //       key: appBloc.selectedInspection!.partsList![index].globalKey!,
            //       items: [
            //         ...[
            //           PartModel(name: 'battery', price: '20 egp'),
            //           PartModel(name: 'engine', price: '50 egp'),
            //           PartModel(name: 'mirror', price: '10 egp'),
            //         ].map((e) => PopupMenuItem(
            //             value: 1,
            //             child: Text(
            //               '${e.name} - ${e.price}',
            //               style: Theme.of(context).textTheme.displaySmall!.copyWith(
            //                 fontSize: 16.0,
            //                 color: secondaryGrey,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //             onTap: () {
            //               // save this part data to the last one added (the empty one)
            //               // appBloc.partsListView[index].textEditingController!.text = '${e.name} - ${e.price}';
            //               // appBloc.selectedInspection!.partsList![index].textEditingController!.text = '${e.name} - ${e.price}';
            //               // appBloc.selectedInspection!.partsList!.last.selectedPart = e;
            //             },
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            //   child: PrimaryFormField(
            //     key: appBloc.selectedInspection!.partsList![index].globalKey!,
            //     // controller: appBloc.selectedInspection!.partsList![index].textEditingController!,
            //     isValidate: false,
            //     validationError: '',
            //     label: 'Select Part*',
            //     enabled: false,
            //   ),
            // );
          },
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column workerFees(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Work Fees',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: secondaryGrey,
                fontSize: 20.0,
              ),
        ),
        space20Vertical(),
        Row(
          children: [
            Expanded(
              child: PrimaryFormField(
                enabled: true,
                validationError: '',
                isValidate: false,
                label: 'Before work',
                controller: appBloc.beforeWorkFeesController,
              ),
            ),
            space20Horizontal(),
            Expanded(
              child: PrimaryFormField(
                enabled: true,
                validationError: '',
                isValidate: false,
                label: 'After work',
                controller: appBloc.afterWorkFeesController,
              ),
            ),
          ],
        ),
        space20Vertical(),
      ],
    );
  }

//******************************************************************************
  Column damageDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviser Notes',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: secondaryGrey,
                fontSize: 20.0,
              ),
        ),
        space20Vertical(),
        PrimaryFormField(
          enabled: true,
          validationError: '',
          isValidate: false,
          label: 'Damage description',
          controller: appBloc.damageDescController,
        ),
        space20Vertical(),
      ],
    );
  }
}
