import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';
import '../../../../core/util/widgets/show_pop_up.dart';
import 'car_selection_body.dart';

import '../../../../core/util/constants.dart';

class ExistingCustomerSearch extends StatefulWidget {
  const ExistingCustomerSearch({super.key});

  @override
  State<ExistingCustomerSearch> createState() => _ExistingCustomerSearchState();
}

class _ExistingCustomerSearchState extends State<ExistingCustomerSearch> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is SearchForExistingCustomerSuccessState) {
          appBloc.getExistingCustomerCarsByPhone(phone: appBloc.searchForExistingCustomerController.text);
        }
        if (state is GetExistingCustomerCarsSuccessState) {
          if (appBloc.userCarsModel!.cars!.length == 1) {
            appBloc.selectedUserCar = appBloc.userCarsModel!.cars![0];
            HelpooInAppNotification.showSuccessMessage(
                message: 'Car selected successfully');
          } else if (appBloc.userCarsModel!.cars!.length > 1) {
            showPrimaryPopUp(
              width: 500,
              isDismissible: false,
              context: context,
              popUpBody: CarSelectionBodyPopup(
                carsDataList: appBloc.userCarsModel!.cars!,
                onConfirmSelection: () {
                  if (appBloc.selectedUserCar != null) {
                    HelpooInAppNotification.showSuccessMessage(
                        message: 'Car selected successfully');
                    Navigator.pop(context);
                  } else {
                    HelpooInAppNotification.showErrorMessage(
                        message: 'Please select a car');
                  }
                },
              ),
            );
          } else {
            HelpooInAppNotification.showSuccessMessage(
                message: 'No cars found for this customer');
          }
        }

        if (state is SearchForExistingCustomerErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text('Search for an existing customer by phone number',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: textColor)),
              space24Vertical(),
              SizedBox(
                width: 600,
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryFormField(
                        validationError: '',
                        label: 'Phone Number',
                        controller: appBloc.searchForExistingCustomerController,
                        onChange: (value) {
                          appBloc.emptyStateToRebuild();
                        },
                      ),
                    ),
                    space10Horizontal(),
                    SizedBox(
                      height: 48,
                      width: 150,
                      child: PrimaryButton(
                        onPressed: () {
                          appBloc.searchForExistingCustomer();
                        },
                        isLoading:
                            state is SearchForExistingCustomerLoadingState ||
                                state is GetExistingCustomerCarsLoadingState,
                        isDisabled: appBloc.searchForExistingCustomerController
                                .text.length <
                            10,
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
              if (appBloc.customerSearchModel != null) space24Vertical(),
              if (appBloc.customerSearchModel != null)
                Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('User Name: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.black)),
                          Text(appBloc.customerSearchModel!.user!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.black)),
                        ],
                      ),
                      if (appBloc.selectedUserCar != null) space10Vertical(),
                      if (appBloc.selectedUserCar != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/car.png',
                                height: 40, width: 40),
                            space10Horizontal(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Car Type',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                                space10Vertical(),
                                Text(
                                  appBloc
                                      .selectedUserCar!.manufacturer!.enName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            space20Horizontal(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Car Model',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                                space10Vertical(),
                                Text(
                                  appBloc.selectedUserCar!.carModel!.enName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            space20Horizontal(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Plate Number',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                                space10Vertical(),
                                Text(
                                  appBloc.selectedUserCar!.plateNumber!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            space20Horizontal(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Year',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                                space10Vertical(),
                                Text(
                                  appBloc.selectedUserCar!.year!.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            space20Horizontal(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Color',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                                space10Vertical(),
                                Text(
                                  appBloc.selectedUserCar!.color!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black),
                                  // style: TextStyles.title14_500
                                  //     .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              space40Vertical(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {
                        if (appBloc.customerSearchModel != null &&
                            // appBloc.userCarsModel != null &&
                            appBloc.selectedUserCar != null) {
                          appBloc.changeServiceRequestStep(step: 1);
                          appBloc.searchForExistingCustomerController.clear();
                        } else {
                          HelpooInAppNotification.showErrorMessage(
                              message: 'Please select a customer and a car');
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
        );
      },
    );
  }
}
