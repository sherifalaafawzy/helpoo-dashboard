import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../core/util/constants.dart';

import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';

import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../../core/util/widgets/show_pop_up.dart';

class CreateNewUserBodyPopup extends StatefulWidget {
  final VoidCallback onClickCreate;

  const CreateNewUserBodyPopup({
    super.key,
    required this.onClickCreate,
  });

  @override
  State<CreateNewUserBodyPopup> createState() => _CreateNewUserBodyPopupState();
}

class _CreateNewUserBodyPopupState extends State<CreateNewUserBodyPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appBloc.getAllRoles();
    appBloc.clearCreateUserControllers();
  }

  final formKey = GlobalKey<FormState>();

  GlobalKey userRoleKey = GlobalKey();
  GlobalKey userInsuranceCompKey = GlobalKey();
  GlobalKey userCorporateCompanyKey = GlobalKey();

  GlobalKey colorsKey = GlobalKey();
  GlobalKey carTypeKey = GlobalKey();
  GlobalKey carModelKey = GlobalKey();
  GlobalKey carFirstCharKey = GlobalKey();
  GlobalKey carSecondCharKey = GlobalKey();
  GlobalKey carThirdCharKey = GlobalKey();
  GlobalKey insuranceCompaniesKey = GlobalKey();
  GlobalKey manufacturesYearsKey = GlobalKey();
  final formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CreateNewUserSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
              message: 'User Created Successfully');

          Navigator.pop(context);

          if (userRoleName == Rules.CallCenter.name || userRoleName == Rules.Super.name) {
            showPrimaryPopUp(
            context: context,
            isDismissible: false,
            horizontalPadding: 30.w,
            popUpBody: BlocConsumer<AppBloc, AppState>(
              listener: (context, state) {
                if (state is ActivateCarSuccessState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.clear)),
                      ],
                    ),
                    const Text('Final Step', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    space10Vertical(),
                    const Text('Connect the car to the client', style: TextStyle(fontSize: 16),),
                    space10Vertical(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Icon(Icons.car_rental, size: 50, color: mainColorHex,),
                          ),
                        ),
                        space10Horizontal(),
                        const Icon(Icons.arrow_forward_ios),
                        space10Horizontal(),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Icon(Icons.account_circle, size: 50, color: mainColorHex,),
                          ),
                        ),
                      ],
                    ),

                    //       ManufacturerId: selectedUserCar?.manufacturer?.id.toString(),
                    //       CarModelId: selectedUserCar?.carModel?.id.toString(),
                    //       year: selectedUserCar?.year?.toString(),
                    //       color: selectedUserCar?.color?.toString(),
                    //       vin_number: selectedUserCar?.vinNumber.toString(),
                    //       plateNumber: selectedUserCar?.plateNumber,
                    //       ClientId: createUserResponseModel?.user?.clientId.toString(),
                    //       active: true,
                    //       insuranceCompanyId: selectedUserCar?.insuranceCompany?.id.toString(),


                    space30Vertical(),

                    Row(
                      children: [
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
                        space20Horizontal(),
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
                      ],
                    ),

                    space20Vertical(),

                    Row(
                      children: [
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
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.7),
                              borderRadius: const BorderRadius.only(
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

                    space50Vertical(),

                    PrimaryButton(
                        isDisabled: appBloc.isActivateCarLoading,
                        isLoading: appBloc.isActivateCarLoading,
                        text: 'Connect Car to Client',
                        onPressed: () {
                          appBloc.activateCar();
                        }
                    ),
                  ],
                );
              }
            ),
            ).then((value) => appBloc.getAllUsers());
          } else {
            appBloc.getAllUsers();
          }
        }

        if (state is CreateNewUserErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        if (state is GetAllRolesLoadingState) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ],
              ),
            ],
          );
        }
        return SizedBox(
          width: 1122,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create New User',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Colors.black)),
                  space24Vertical(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.userIdentifierController,
                          validationError: 'Enter user Identifier',
                          label: 'Identifier*',
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.userNameController,
                          validationError: 'Enter name',
                          label: 'Name*',
                        ),
                      ),
                    ],
                  ),
                  space20Vertical(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.userEmailController,
                          validationError: 'Enter email',
                          label: 'Email',
                          isValidate: false,
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.userPhoneController,
                          validationError: 'Enter PhoneNumber',
                          label: 'PhoneNumber*',
                          isValidate: false,
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
                          key: userRoleKey,
                          onTap: () {
                            showPrimaryMenu(
                              context: context,
                              key: userRoleKey,
                              items: [
                                ...appBloc.rolesModel!.roles!.map(
                                  (e) => PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      e.name!,
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
                                      appBloc.selectedUserRole = e;
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          child: PrimaryFormField(
                            controller: appBloc.userRoleController,
                            validationError: 'Enter User Role',
                            label: 'Role*',
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
                          controller: appBloc.userPasswordController,
                          validationError: 'Enter Password',
                          label: 'Password*',
                        ),
                      ),
                    ],
                  ),
                  space20Vertical(),
                  if (appBloc.isGetAllInsuranceCompanies && appBloc.userRoleController.text == 'Insurance') ...{
                    const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  },
                  if (appBloc.insuranceCompanies.isNotEmpty && appBloc.userRoleController.text == 'Insurance') ...{
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            key: userInsuranceCompKey,
                            onTap: () {
                              showPrimaryMenu(
                                context: context,
                                key: userInsuranceCompKey,
                                items: [
                                  ...appBloc.insuranceCompanies.map(
                                        (e) => PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        '${e.enName}',
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
                                        appBloc.selectedUserInsuranceComp = e;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: PrimaryFormField(
                              controller: appBloc.selectedUserInsuranceCompController,
                              validationError: 'Select User\'s Insurance Company',
                              label: 'Insurance Company*',
                              enabled: false,
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                        space20Horizontal(),
                      ],
                    ),
                  },

                  if (appBloc.isGetAllCorporatesLoading && appBloc.userRoleController.text == 'Corporate') ...{
                    const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  },
                  if (appBloc.corporatesModel != null && appBloc.userRoleController.text == 'Corporate')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            key: userCorporateCompanyKey,
                            onTap: () {
                              showPrimaryMenu(
                                context: context,
                                key: userCorporateCompanyKey,
                                items: [
                                  ...appBloc.corporatesModel!.rows!.map(
                                    (e) => PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        e.enName!,
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
                                        appBloc.selectedCorporateForUser = e;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: PrimaryFormField(
                              controller:
                                  appBloc.userCorporateCompanyController,
                              validationError: 'Enter Corporate Company',
                              label: 'Corporate Company*',
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
                  space40Vertical(),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          isLoading: appBloc.isCreateNewUserLoading,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              widget.onClickCreate();
                            }
                          },
                          text: 'Create',
                        ),
                      ),
                      space10Horizontal(),
                      Expanded(
                        child: PrimaryButton(
                          isLoading: false,
                          onPressed: () {
                            appBloc.clearCreateUserControllers();
                            context.pop;
                          },
                          backgroundColor: Colors.red,
                          text: 'Cancel',
                        ),
                      ),
                    ],
                  ),
                  space24Vertical(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
