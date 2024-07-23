import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';

import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/utils.dart';

import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/show_pop_up.dart';
import 'driver_card.dart';
import '../../../../main.dart';

class DriverSelectionBodyPopup extends StatefulWidget {
  final List<int> carServiceTypes;

  const DriverSelectionBodyPopup({super.key, required this.carServiceTypes});

  @override
  State<DriverSelectionBodyPopup> createState() => _DriverSelectionBodyPopupState();
}

class _DriverSelectionBodyPopupState extends State<DriverSelectionBodyPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.selectedDriver = null;
    appBloc.getAllAvailableDrivers(carServiceTypes: widget.carServiceTypes);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AssignDriverToServiceRequestSuccessState) {
          printWarning('newFees: ${state.assignDriverResponse.newFees}');
          if ((state.assignDriverResponse.newFees != null && state.assignDriverResponse.newFees! > 0) ||
              (appBloc.driverAlreadyInReq != null)) {
            Navigator.pop(context);
            showPrimaryPopUp(
              context: context,
              popUpBody: NewFeesAlertBody(
                newFees: state.assignDriverResponse.newFees!,
                diff: state.assignDriverResponse.differenceFees!,
                driverInReq: appBloc.driverAlreadyInReq,
              ),
            ).then(
              (value) {
                HelpooInAppNotification.showSuccessMessage(message: 'Driver changed successfully');
                appBloc.driverAlreadyInReq = null;
                appBloc.getAllServiceRequest(
                  pageNumber: 1
                );
              },
            );
          } else {
            HelpooInAppNotification.showSuccessMessage(message: 'Driver changed successfully');
            Navigator.pop(context);
            appBloc.getAllServiceRequest(
              pageNumber: 1
            );
          }
        }
        if (state is AssignDriverToServiceRequestErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is GetAllAvailableDriversLoading) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: CupertinoActivityIndicator()),
                ],
              ),
            ],
          );
        }
        return SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Driver', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black)),
              space24Vertical(),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: appBloc.availableDrivers.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        appBloc.selectedDriver = appBloc.availableDrivers[index];
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DriverCard(
                          title: appBloc.availableDrivers[index].driver?.user?.name ?? '',
                          distance: appBloc.availableDrivers[index].distance?.toString() ?? '0',
                          duration: appBloc.availableDrivers[index].duration?.toString() ?? '0',
                          wenchNum: '${appBloc.availableDrivers[index].vehicle?.vecNum ?? ''}',
                          wenchType: appBloc.availableDrivers[index].vehicle?.vecType == 5 ? 'European' : 'Normal',
                          selected: appBloc.selectedDriver != null &&
                              appBloc.selectedDriver!.driver!.id == appBloc.availableDrivers[index].driver!.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
              space24Vertical(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Confirm',
                      isLoading: state is AssignDriverToServiceRequestLoadingState,
                      onPressed: () {
                        appBloc.assignDriverToServiceRequest(
                          driverId: appBloc.selectedDriver!.driver!.id.toString(),
                          serviceRequestId: appBloc.selectedServiceRequestId.toString(),
                          isReAssignDriver: true,
                        );
                      },
                    ),
                  ),
                  space10Horizontal(),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancel',
                      backgroundColor: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
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

class NewFeesAlertBody extends StatelessWidget {
  final num newFees;
  final num diff;
  final int? driverInReq;

  const NewFeesAlertBody({
    super.key,
    required this.newFees,
    required this.diff,
    this.driverInReq,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/error_place_holder.png',
          height: 100,
          width: 100,
        ),
        space24Vertical(),
        if (diff > 0) ...[
          Text(
            'Fees Changed \n'
            'New Fees: $newFees',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
          ),
          space24Vertical(),
          Text(
            'Difference: $diff',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
          ),
          space24Vertical(),
        ],
        if (driverInReq != null) ...[
          Text(
            'This Driver Already In Req: $driverInReq',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
          ),
          space24Vertical(),
        ],
        PrimaryButton(
          text: 'Done!',
          width: 200,
          onPressed: () {
            Navigator.pop(navigatorKey.currentContext!);
          },
        ),
      ],
    );
  }
}
