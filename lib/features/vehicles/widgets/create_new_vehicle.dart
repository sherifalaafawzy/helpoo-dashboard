import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';

import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';

import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';

class CreateNewVehicleBodyPopup extends StatefulWidget {
  const CreateNewVehicleBodyPopup({
    super.key,
  });

  @override
  State<CreateNewVehicleBodyPopup> createState() =>
      _CreateNewVehicleBodyPopupState();
}

class _CreateNewVehicleBodyPopupState extends State<CreateNewVehicleBodyPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.getServiceRequestTypes();
    appBloc.getAllVehiclesTypes();
  }

  final formKey = GlobalKey<FormState>();

  GlobalKey carFirstCharKey = GlobalKey();
  GlobalKey carSecondCharKey = GlobalKey();
  GlobalKey carThirdCharKey = GlobalKey();
  GlobalKey vehicleTypeKey = GlobalKey();
  GlobalKey vehicleServiceTypeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CreateNewVehicleSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
              message: 'Vehicle Created Successfully');
          appBloc.getAllVehicles();
          context.pop;
        }

        if (state is CreateNewVehicleErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        if (state is GetServiceRequestTypesLoadingState ||
            state is GetAllVehiclesTypesLoadingState) {
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
                  Text('Create New Vehicle',
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
                          controller: appBloc.vehicleNameController,
                          validationError: 'Enter Vehicle Name',
                          label: 'Vehicle Name*',
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.vehiclePhoneController,
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
                        child: PrimaryFormField(
                          controller: appBloc.vehicleNumberController,
                          validationError: 'Enter Vehicle Number',
                          label: 'Vehicle Number*',
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.vehicleIMEIController,
                          validationError: 'Enter IMEI',
                          label: 'IMEI*',
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
                          key: vehicleTypeKey,
                          onTap: () {
                            showPrimaryMenu(
                              context: context,
                              key: vehicleTypeKey,
                              items: [
                                ...appBloc.vehiclesTypesModel!.types!.map(
                                  (e) => PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      e.typeName ?? '',
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
                                      appBloc.selectedVehicleType = e;
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          child: PrimaryFormField(
                            controller: appBloc.vehicleTypeController,
                            validationError: 'Enter Vehicle Type',
                            label: 'Vehicle Type*',
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
                          key: vehicleServiceTypeKey,
                          onTap: () {
                            showPrimaryMenu(
                              context: context,
                              key: vehicleServiceTypeKey,
                              items: [
                                ...appBloc.serviceRequestTypes!.map(
                                  (e) => PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      e.enName ?? '',
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
                                      appBloc.addVehicleServiceTypeToList(e);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: borderGrey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: appBloc
                                              .selectedVehicleTypesList.isEmpty
                                          ? Text(
                                              'Service Type*',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    fontSize: 16.0,
                                                    color: secondaryGrey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: appBloc
                                                  .selectedVehicleTypesList
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 4.0,
                                                    vertical: 10.0,
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2.0,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        appBloc
                                                                .selectedVehicleTypesList[
                                                                    index]
                                                                .enName ??
                                                            '',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall!
                                                            .copyWith(
                                                              fontSize: 12.0,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                      ),
                                                      space5Horizontal(),
                                                      InkWell(
                                                        onTap: () {
                                                          appBloc.removeVehicleServiceTypeFromList(
                                                              appBloc.selectedVehicleTypesList[
                                                                  index]);
                                                        },
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 18.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )),
                                ),
                                if (appBloc
                                    .selectedVehicleTypesList.isNotEmpty) ...{
                                  InkWell(
                                    onTap: () {
                                      appBloc
                                          .clearSelectedVehicleServiceTypesList();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: textColor,
                                      size: 18.0,
                                    ),
                                  ),
                                  space10Horizontal(),
                                },
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: textColor,
                                  size: 18.0,
                                ),
                                space5Horizontal(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  space20Vertical(),
                  Container(
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
                                'Vehicle plate area',
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
                                  controller:
                                      appBloc.policyCarPlateNumberController,
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
                                      controller:
                                          appBloc.policyCarThirdCharController,
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
                                      controller:
                                          appBloc.policyCarSecondCharController,
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
                                      controller:
                                          appBloc.policyCarFirstCharController,
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
                          isLoading: appBloc.isCreateNewVehicleLoading,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              appBloc.createNewVehicle();
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
                            appBloc.clearCreateNewVehicleData();
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
