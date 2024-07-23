import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/remote/api_endpoints.dart';
import '../app_scroll_behavior.dart';
import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../enums.dart';
import '../extensions/build_context_extension.dart';
import '../helpoo_in_app_notifications.dart';
import 'primary_button.dart';
import 'primary_form_field.dart';
import 'primary_padding.dart';
import 'primary_pop_up_menu.dart';
import 'package:url_launcher/url_launcher.dart';

void showCreatePolicyPopUp({
  String? title,
  String? label,
  required isDismissible,
  required BuildContext context,
  bool isScrollable = true,
  bool isMobile = false,
}) {
  GlobalKey colorsKey = GlobalKey();
  GlobalKey carTypeKey = GlobalKey();
  GlobalKey carModelKey = GlobalKey();
  GlobalKey carFirstCharKey = GlobalKey();
  GlobalKey carSecondCharKey = GlobalKey();
  GlobalKey carThirdCharKey = GlobalKey();
  GlobalKey insuranceCompaniesKey = GlobalKey();
  GlobalKey manufacturesYearsKey = GlobalKey();

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    useSafeArea: false,
    barrierColor: Colors.transparent,
    builder: (_) {
      return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (userRoleName == Rules.Super.name) {
            if (state is AddServiceRequestCarSuccessState) {
              context.pop;
              HelpooInAppNotification.showSuccessMessage(message: 'Car Added Successfully');
              appBloc.getAllAdminCars();
            }

            if (state is AddServiceRequestCarErrorState) {
              HelpooInAppNotification.showErrorMessage(message: state.error);
            }
          } else {
            if (state is CreateNewPolicySuccessState) {
              context.pop;
              HelpooInAppNotification.showSuccessMessage(message: 'Policy Created');

              appBloc.getPolicies(isRefresh: true, fromSuccess: true);
            }
            if (state is CreateNewPolicyErrorState) {
              HelpooInAppNotification.showErrorMessage(message: state.error);
            }
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: appBloc.isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: Form(
              key: formKey,
              child: GestureDetector(
                onTap: () {},
                child: Material(
                  color: Colors.transparent,
                  //* this container is all screen except the dialoge ************
                  child: Container(
                    color: popUpShadow,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 1122,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              space24Vertical(),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryFormField(
                                      controller: appBloc.policyFullNameController,
                                      validationError: 'Enter Full Name',
                                      label: 'Full Name*',
                                    ),
                                  ),
                                  space20Horizontal(),
                                  Expanded(
                                    child: PrimaryFormField(
                                      controller: appBloc.policyPhoneController,
                                      validationError: 'Enter Phone Number',
                                      label: 'Phone Number*',
                                    ),
                                  ),
                                ],
                              ),
                              space20Vertical(),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryFormField(
                                      controller: appBloc.policyEmailController,
                                      validationError: '',
                                      label: 'Email Address',
                                      isValidate: false,
                                    ),
                                  ),
                                  space20Horizontal(),
                                  Expanded(
                                    child: InkWell(
                                      key: manufacturesYearsKey,
                                      onTap: () {
                                        showPrimaryMenu(context: context, key: manufacturesYearsKey, items: [
                                          ...appBloc.yearsOfManufacture.map(
                                            (e) => PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                e,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                      fontSize: 16.0,
                                                      color: secondaryGrey,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                              ),
                                              onTap: () {
                                                appBloc.selectedYearOfManufacture = e;
                                              },
                                            ),
                                          ),
                                        ]);
                                      },
                                      child: PrimaryFormField(
                                        controller: appBloc.policyYearOfManufactureController,
                                        validationError: 'Enter year of manufacture',
                                        label: 'Year of manufacture*',
                                        enabled: false,
                                        suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (userRoleName != Rules.Super.name) space20Vertical(),
                              if (userRoleName != Rules.Super.name)
                                Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryFormField(
                                        controller: appBloc.policyNumberController,
                                        validationError: 'Enter Policy Number',
                                        label: 'Policy Number*',
                                      ),
                                    ),
                                    space20Horizontal(),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          ).then((value) {
                                            if (value == null) {
                                              // HelpooInAppNotification
                                              //     .showErrorMessage(
                                              //         context: context,
                                              //         message:
                                              //             'Please select a date');
                                              return;
                                            }
                                            appBloc.policyStartDate = value;
                                            appBloc.policyStartDateController.text = value.toString().split(' ').first;
                                          });
                                        },
                                        child: PrimaryFormField(
                                          controller: appBloc.policyStartDateController,
                                          validationError: 'Entre Policy Start Date',
                                          label: 'Policy Start Date',
                                          enabled: false,
                                          isValidate: false,
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (userRoleName != Rules.Super.name) space20Vertical(),
                              if (userRoleName != Rules.Super.name)
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (appBloc.policyEndDate != null) {
                                            debugPrint('policyEndDate: ${appBloc.policyEndDate}');
                                            showDatePicker(
                                              context: context,
                                              initialDate: appBloc.policyEndDate!,
                                              firstDate: appBloc.policyStartDate!,
                                              lastDate: appBloc.policyEndDate!,
                                            ).then((value) {
                                              if (value == null) {
                                                return;
                                              }

                                              appBloc.policyEndDateController.text = value.toString().split(' ').first;
                                            });
                                          } else {
                                            HelpooInAppNotification.showErrorMessage(message: 'Please select a start date first');
                                          }
                                        },
                                        child: PrimaryFormField(
                                          controller: appBloc.policyEndDateController,
                                          validationError: '',
                                          label: 'Policy End Date',
                                          isValidate: false,
                                          enabled: false,
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    space20Horizontal(),
                                    Expanded(
                                      child: PrimaryFormField(
                                        controller: appBloc.policyAppendixNumberController,
                                        validationError: '',
                                        label: 'Appendix Number',
                                        isValidate: false,
                                      ),
                                    ),
                                  ],
                                ),
                              space20Vertical(),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryFormField(
                                      controller: appBloc.policyVinNumberController,
                                      validationError: 'Enter Vin Number',
                                      label: 'Vin Number',
                                      isValidate: false,
                                    ),
                                  ),
                                  space20Horizontal(),
                                  Expanded(
                                    child: InkWell(
                                      key: carTypeKey,
                                      onTap: () {
                                        if (appBloc.manufacturersModel == null) {
                                          appBloc.getManufacturers();
                                          return;
                                        }

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
                                      },
                                      child: PrimaryFormField(
                                        controller: appBloc.policyCarTypeController,
                                        validationError: 'Enter Car Type',
                                        label: 'Car Type*',
                                        enabled: false,
                                        suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              space20Vertical(),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      key: carModelKey,
                                      onTap: () {
                                        if (appBloc.carsModel == null) {
                                          appBloc.getCarsModels();
                                          return;
                                        }

                                        if (appBloc.selectedManufacturer == null) {
                                          return;
                                        }

                                        showPrimaryMenu(
                                          context: context,
                                          key: carModelKey,
                                          items: [
                                            ...appBloc.carsModel!.models
                                                .where((element) =>
                                                    element.manufacturerId == appBloc.selectedManufacturer!.id)
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
                                      },
                                      child: PrimaryFormField(
                                        controller: appBloc.policyCarModelController,
                                        validationError: 'Enter Car Model',
                                        label: 'Car Model*',
                                        enabled: false,
                                        suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  space20Horizontal(),
                                  Expanded(
                                    child: InkWell(
                                      key: colorsKey,
                                      onTap: () {
                                        showPrimaryMenu(
                                          context: context,
                                          key: colorsKey,
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
                                        validationError: 'Enter Car Color',
                                        label: 'Car Color*',
                                        enabled: false,
                                        suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // if (userRoleName != Rules.Super.name)
                              //   space20Vertical(),
                              // if (userRoleName != Rules.Super.name)
                              //   Row(
                              //     children: [
                              //       Expanded(
                              //         child: InkWell(
                              //           key: insuranceCompaniesKey,
                              //           onTap: () {
                              //             showPrimaryMenu(
                              //               context: context,
                              //               key: insuranceCompaniesKey,
                              //               items: [
                              //                 ...appBloc.insuranceCompanies.map(
                              //                   (e) => PopupMenuItem(
                              //                     value: 1,
                              //                     child: Text(
                              //                       e.arName!,
                              //                       style: Theme.of(context)
                              //                           .textTheme
                              //                           .displaySmall!
                              //                           .copyWith(
                              //                             fontSize: 16.0,
                              //                             color: secondaryGrey,
                              //                             fontWeight:
                              //                                 FontWeight.w400,
                              //                           ),
                              //                     ),
                              //                     onTap: () {
                              //                       appBloc.selectedInsuranceCompany =
                              //                           e;
                              //                     },
                              //                   ),
                              //                 ),
                              //               ],
                              //             );
                              //           },
                              //           child: PrimaryFormField(
                              //             controller: appBloc
                              //                 .insuranceCompanyController,
                              //             validationError:
                              //                 'Enter InsuranceCompany',
                              //             label: 'Insurance company',
                              //             enabled: false,
                              //             suffixIcon: const Icon(
                              //               Icons.keyboard_arrow_down,
                              //               color: textColor,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),

                              space20Vertical(),
                              Container(
                                // height: 125.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: borderGrey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 35.0,
                                      width: double.infinity,
                                      // alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                                        child: Center(
                                          child: Text(
                                            'Car plate area',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: whiteColor, height: 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: appBloc.isOldPlate ? 2 : 1,
                                            child: PrimaryFormField(
                                              controller: appBloc.policyCarPlateNumberController,
                                              inputFormatters: [
                                                // only input numbers
                                                FilteringTextInputFormatter.digitsOnly,
                                                // only 5 digits
                                                LengthLimitingTextInputFormatter(appBloc.isOldPlate ? 7 : 4),
                                              ],
                                              validationError: 'Enter Plate number',
                                              label: 'Plate Number',
                                              isValidate: false,
                                            ),
                                          ),
                                          if (!appBloc.isOldPlate) space40Horizontal(),
                                          if (!appBloc.isOldPlate)
                                            Expanded(
                                              child: InkWell(
                                                key: carThirdCharKey,
                                                onTap: () {
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: carThirdCharKey,
                                                    items: [
                                                      ...arabicLetters.map(
                                                        (e) => PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            e,
                                                            textAlign: TextAlign.center,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                                  fontSize: 16.0,
                                                                  color: secondaryGrey,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                          ),
                                                          onTap: () {
                                                            appBloc.selectedCarThirdChar = e;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                child: PrimaryFormField(
                                                  controller: appBloc.policyCarThirdCharController,
                                                  isValidate: false,
                                                  validationError: 'Enter Plate Third Character',
                                                  label: 'Plate Third Character*',
                                                  enabled: false,
                                                  suffixIcon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: textColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (!appBloc.isOldPlate) space10Horizontal(),
                                          if (!appBloc.isOldPlate)
                                            Expanded(
                                              child: InkWell(
                                                key: carSecondCharKey,
                                                onTap: () {
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: carSecondCharKey,
                                                    items: [
                                                      ...arabicLetters.map(
                                                        (e) => PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            e,
                                                            textAlign: TextAlign.center,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                                  fontSize: 16.0,
                                                                  color: secondaryGrey,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                          ),
                                                          onTap: () {
                                                            appBloc.selectedCarSecondChar = e;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                child: PrimaryFormField(
                                                  controller: appBloc.policyCarSecondCharController,
                                                  isValidate: false,
                                                  validationError: 'Enter Plate Second Character',
                                                  label: 'Plate Second Character*',
                                                  enabled: false,
                                                  suffixIcon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: textColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (!appBloc.isOldPlate) space10Horizontal(),
                                          if (!appBloc.isOldPlate)
                                            Expanded(
                                              child: InkWell(
                                                key: carFirstCharKey,
                                                onTap: () {
                                                  showPrimaryMenu(
                                                    context: context,
                                                    key: carFirstCharKey,
                                                    items: [
                                                      ...arabicLetters.map(
                                                        (e) => PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            e,
                                                            textAlign: TextAlign.center,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                                  fontSize: 16.0,
                                                                  color: secondaryGrey,
                                                                  fontWeight: FontWeight.w400,
                                                                ),
                                                          ),
                                                          onTap: () {
                                                            appBloc.selectedCarFirstChar = e;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                child: PrimaryFormField(
                                                  controller: appBloc.policyCarFirstCharController,
                                                  validationError: 'Enter Plate First Character',
                                                  label: 'Plate First Character*',
                                                  isValidate: false,
                                                  enabled: false,
                                                  suffixIcon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: textColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          space40Horizontal(),
                                          Expanded(
                                            flex: 1,
                                            child: PrimaryButton(
                                                text: appBloc.isOldPlate ? 'NEW PLATE' : 'OLD PLATE',
                                                onPressed: () {
                                                  appBloc.isOldPlate = !appBloc.isOldPlate;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              space40Vertical(),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      isLoading: state is CreateNewPolicyLoadingState ||
                                          state is AddServiceRequestCarLoadingState,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          if (userRoleName == Rules.Super.name) {
                                            appBloc.addServiceRequestCar();
                                          } else {
                                            appBloc.createNewPolicy();
                                          }
                                        }
                                      },
                                      text: 'Create',
                                    ),
                                  ),
                                  space20Horizontal(),
                                  Expanded(
                                    child: SizedBox(
                                      height: 43,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Colors.green,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                color: Colors.green,
                                              ),
                                        ),
                                        onPressed: () {
                                          appBloc.clearCreatePolicyData();
                                          context.pop;
                                        },
                                      ),
                                    ),
                                    //  PrimaryButton(
                                    //   backgroundColor: Colors.red,
                                    //   onPressed: () {
                                    //     appBloc.clearCreatePolicyData();
                                    //     context.pop;
                                    //   },
                                    //   text: 'Cancel',
                                    // ),
                                  ),
                                ],
                              ),
                              space24Vertical(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

//******************************************************************************
Future<void> showPrimaryPopUp({
  String? title,
  String? label,
  bool isDismissible = true,
  required BuildContext context,
  bool isScrollable = true,
  bool isMobile = false,
  Widget? popUpBody,
  double width = 1222,
  double horizontalPadding = 0,
}) async {
  await showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: isDismissible,
    barrierColor: Colors.transparent,
    builder: (_) {
      return BlocBuilder<AppBloc, AppState>(
        builder: (context, snapshot) {
          return Directionality(
            textDirection: appBloc.isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: GestureDetector(
              onTap: () {
                if (isDismissible) {
                  context.pop;
                }
              },
              child: Material(
                color: Colors.transparent,
                //* this container is all screen except the dialog ************
                child: Container(
                  color: popUpShadow,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50, horizontal: horizontalPadding),
                      child: Container(
                        // width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: popUpBody ?? Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

//******************************************************************************
void showImageSliderPopUp({
  bool isDismissible = true,
  required BuildContext context,
  double width = 800,
  double height = 600,
  required List<String> images,
  int index = 0,
}) {
  var imagesController = PageController(initialPage: index);
  AppBloc.get(context).changeCurrentImageIndex(index);
  showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: isDismissible,
    barrierColor: Colors.transparent,
    builder: (_) {
      return BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          debugPrintFullText('showImageSliderPopUp: ${appBloc.currentImageIndex}');
          return Directionality(
            textDirection: appBloc.isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: GestureDetector(
              onTap: () => context.pop,
              child: Material(
                color: Colors.transparent,
                //* this container is all screen except the dialoge ************
                child: SingleChildScrollView(
                  child: Container(
                    color: popUpShadow,
                    child: PrimaryPadding(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          // width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: SizedBox(
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () => context.pop,
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                space40Vertical(),
                                SizedBox(
                                  height: height,
                                  child: PageView.builder(
                                    controller: imagesController,
                                    onPageChanged: (index) {
                                      AppBloc.get(context).changeCurrentImageIndex(index);
                                    },
                                    scrollBehavior: AppScrollBehavior(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          if (!await launchUrl(
                                            Uri.parse('$imagesBaseUrl${images[index]}'),
                                          )) {
                                            throw Exception(
                                              'Could not launch $imagesBaseUrl${images[index]}',
                                            );
                                          }
                                        },
                                        child: MyNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl: images[index],
                                        ),
                                      );
                                    },
                                    itemCount: images.length,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                                  child: SizedBox(
                                    height: 65,
                                    width: width,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            imagesController.previousPage(
                                              duration: const Duration(milliseconds: 100),
                                              curve: Curves.linear,
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: appBloc.currentImageIndex == 0 ? Colors.grey : mainColorHex,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        space30Horizontal(),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ...List.generate(
                                                  images.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        imagesController.jumpToPage(index);
                                                      },
                                                      child: SizedBox(
                                                        width:
                                                            AppBloc.get(context).currentImageIndex == index ? 70 : 50,
                                                        height:
                                                            AppBloc.get(context).currentImageIndex == index ? 70 : 50,
                                                        child: MyNetworkImage(
                                                          imageUrl: images[index],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        space30Horizontal(),
                                        InkWell(
                                          onTap: () {
                                            imagesController.nextPage(
                                              duration: const Duration(milliseconds: 100),
                                              curve: Curves.linear,
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: appBloc.currentImageIndex == images.length - 1
                                                  ? Colors.grey
                                                  : mainColorHex,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          ),
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
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
