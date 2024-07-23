import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';
import '../../../../core/util/widgets/primary_pop_up_menu.dart';

class CustomerData extends StatefulWidget {
  const CustomerData({super.key});

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  GlobalKey colorsKey = GlobalKey();
  GlobalKey carTypeKey = GlobalKey();
  GlobalKey carModelKey = GlobalKey();
  GlobalKey carFirstCharKey = GlobalKey();
  GlobalKey carSecondCharKey = GlobalKey();
  GlobalKey carThirdCharKey = GlobalKey();
  GlobalKey insuranceCompaniesKey = GlobalKey();
  GlobalKey manufacturesYearsKey = GlobalKey();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.getAllInsuranceCompanies();
    appBloc.getManufacturers();
    appBloc.getCarsModels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AddServiceRequestCarSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
              message: 'Car Added Successfully');

          appBloc.changeServiceRequestStep(step: 1);
        }

        if (state is AddServiceRequestCarErrorState) {
          HelpooInAppNotification.showErrorMessage(
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: appBloc.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Form(
            key: formKey,
            child: Material(
              color: Colors.transparent,
              //* this container is all screen except the dialoge ************
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              key: manufacturesYearsKey,
                              onTap: () {
                                showPrimaryMenu(
                                    context: context,
                                    key: manufacturesYearsKey,
                                    items: [
                                      ...appBloc.yearsOfManufacture.map(
                                        (e) => PopupMenuItem(
                                          value: 1,
                                          child: Text(
                                            e,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  fontSize: 16.0,
                                                  color: secondaryGrey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          onTap: () {
                                            appBloc.selectedYearOfManufacture =
                                                e;
                                          },
                                        ),
                                      ),
                                    ]);
                              },
                              child: PrimaryFormField(
                                controller:
                                    appBloc.policyYearOfManufactureController,
                                validationError: 'Enter year of manufacture',
                                label: 'Year of manufacture*',
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: textColor,
                                ),
                                enabled: false,
                              ),
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
                                    ...appBloc.manufacturersModel!.manufacturers
                                        .map(
                                      (e) => PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          e.enName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                            element.manufacturerId ==
                                            appBloc.selectedManufacturer!.id)
                                        .map(
                                          (e) => PopupMenuItem(
                                            value: 1,
                                            child: Text(
                                              e.enName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
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
                      // space20Vertical(),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: PrimaryFormField(
                      //         key: insuranceCompaniesKey,
                      //         controller: appBloc.insuranceCompanyController,
                      //         validationError: 'Enter Insurance Company',
                      //         isValidate: false,
                      //         label: 'Insurance company',
                      //         onTap: () {
                      //           showPrimaryMenu(
                      //             context: context,
                      //             key: insuranceCompaniesKey,
                      //             items: [
                      //               ...appBloc.insuranceCompanies.map(
                      //                 (e) => PopupMenuItem(
                      //                   value: 1,
                      //                   child: Text(
                      //                     e.arName!,
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .displaySmall!
                      //                         .copyWith(
                      //                           fontSize: 16.0,
                      //                           color: secondaryGrey,
                      //                           fontWeight: FontWeight.w400,
                      //                         ),
                      //                   ),
                      //                   onTap: () {
                      //                     appBloc.selectedInsuranceCompany = e;
                      //                   },
                      //                 ),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //     space20Horizontal(),
                      //     Expanded(
                      //       child: PrimaryFormField(
                      //         controller: appBloc.promoCodeController,
                      //         validationError: '',
                      //         label: 'Promo Code',
                      //         isValidate: false,
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      space20Vertical(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              controller: appBloc.policyVinNumberController,
                              validationError: currentCompanyId == 131 || appBloc.selectedCorporateId == 131 ? 'vin number is required' : '', // special case for star company
                              isValidate: currentCompanyId == 131 || appBloc.selectedCorporateId == 131 ? true : false,
                              label: 'Car vin number',
                            ),
                          ),
                          space20Horizontal(),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),

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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: appBloc.isOldPlate ? 2 : 1,
                                    child: PrimaryFormField(
                                      controller: appBloc
                                          .policyCarPlateNumberController,
                                      validationError: 'Enter Plate number',
                                      isValidate: false,
                                      label: 'Plate Number',
                                      inputFormatters: [
                                        // only input numbers
                                        FilteringTextInputFormatter.digitsOnly,
                                        // only 5 digits
                                        LengthLimitingTextInputFormatter(
                                            appBloc.isOldPlate ? 7 : 4),
                                      ],
                                      // onChange: (value) {
                                      //   // check if value is 5 digits
                                      //   if (value.length >= 5) {
                                      //     HelpooInAppNotification.showErrorMessage(
                                      //         context: context,
                                      //         message:
                                      //             'Plate number must be less than 5 digits');
                                      //   }
                                      // },
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                          fontSize: 16.0,
                                                          color: secondaryGrey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                  onTap: () {
                                                    appBloc.selectedCarThirdChar =
                                                        e;
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        child: PrimaryFormField(
                                          controller: appBloc
                                              .policyCarThirdCharController,
                                          isValidate: false,
                                          validationError:
                                              'Enter Plate Third Character',
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                          fontSize: 16.0,
                                                          color: secondaryGrey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                  onTap: () {
                                                    appBloc.selectedCarSecondChar =
                                                        e;
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        child: PrimaryFormField(
                                          controller: appBloc
                                              .policyCarSecondCharController,
                                          isValidate: false,
                                          enabled: false,
                                          validationError:
                                              'Enter Plate Second Character',
                                          label: 'Plate Second Character*',
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
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                          fontSize: 16.0,
                                                          color: secondaryGrey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                  onTap: () {
                                                    appBloc.selectedCarFirstChar =
                                                        e;
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        child: PrimaryFormField(
                                          controller: appBloc
                                              .policyCarFirstCharController,
                                          validationError:
                                              'Enter Plate First Character',
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
                                        text: appBloc.isOldPlate
                                            ? 'NEW PLATE'
                                            : 'OLD PLATE',
                                        onPressed: () {
                                          appBloc.isOldPlate =
                                              !appBloc.isOldPlate;
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
                              isLoading:
                                  state is AddServiceRequestCarLoadingState,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  appBloc.addServiceRequestCar();
                                }
                              },
                              text: 'Next',
                            ),
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
        );
      },
    );
  }
}
