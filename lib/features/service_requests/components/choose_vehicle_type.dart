import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import 'vehicle_type_item.dart';

class ChooseVehicleTypeComponent extends StatelessWidget {
  const ChooseVehicleTypeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is GetDriverPathToDrawSuccess) {
          if (state.isCreateNew) {
            // appBloc.createNewRequest();

            appBloc.changeServiceRequestStep(
                step: appBloc.serviceRequestStep <
                        appBloc.serviceRequestSteps.length - 1
                    ? appBloc.serviceRequestStep + 1
                    : appBloc.serviceRequestStep);
            context.pop;
          }
        }
        // if (state is CreateNewRequestSuccessState) {
        //   context.pop;
        //   HelpooInAppNotification.showSuccessMessage(
        //       message: 'Request sent successfully');
        //   appBloc.changeServiceRequestStep(
        //       step: appBloc.serviceRequestStep <
        //               appBloc.serviceRequestSteps.length - 1
        //           ? appBloc.serviceRequestStep + 1
        //           : appBloc.serviceRequestStep);
        // }
        // if (state is CreateNewRequestErrorState) {
        //   context.pop;
        //   HelpooInAppNotification.showErrorMessage(
        //       context: context, message: state.error);
        //   appBloc.changeStackNav(
        //     index: appBloc.currentSideMenuIndex,
        //     isAdd: false,
        //   );
        //   appBloc.resetServiceRequestSteps();
        // }

        if (state is GetDriverBasedOnSelectedServiceTypeErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 550,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VehicleTypeItem(
                    onTap: () {
                      appBloc.setIsEuropeanVehicle = false;
                    },
                    isSelected: appBloc.isEuropeanVehicle == false,
                    imageName: 'basicTowing',
                    title: 'Normal Towing',
                    price: appBloc.calculateFeesModel!.normalFees.toString(),
                  ),
                  space20Horizontal(),
                  VehicleTypeItem(
                    onTap: () {
                      appBloc.setIsEuropeanVehicle = true;
                    },
                    isSelected: appBloc.isEuropeanVehicle == true,
                    imageName: 'premiumTowing',
                    title: 'Europe Towing',
                    price: appBloc.calculateFeesModel!.euroFees.toString(),
                  ),
                ],
              ),
              space24Vertical(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: PrimaryButton(
                      text: 'Confirm',
                      isLoading: state
                              is GetDriverBasedOnSelectedServiceTypeLoadingState ||
                          state is CreateNewRequestLoadingState,
                      onPressed: () {
                        if (appBloc.selectedVehicleServiceType != null) {
                          appBloc.getDriverBasedOnSelectedServiceType();
                        }
                      },
                    ),
                  ),
                  space20Horizontal(),
                  SizedBox(
                    width: 250,
                    child: PrimaryButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                        appBloc.setIsEuropeanVehicle = null;
                        appBloc.setSelectedVehicleServiceType = null;
                        // appBloc.setIsEuropeanVehicle = null;
                      },
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
