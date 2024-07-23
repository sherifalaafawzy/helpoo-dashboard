import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectDatePopupBody extends StatefulWidget {
  const SelectDatePopupBody({super.key});

  @override
  State<SelectDatePopupBody> createState() => _SelectDatePopupBodyState();
}

class _SelectDatePopupBodyState extends State<SelectDatePopupBody> {
  @override
  void initState() {
    super.initState();
    appBloc.startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    appBloc.endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is EndDateChanged) {
          appBloc.getServiceRequestReports();
          appBloc.reportsSelectDateController.selectedRange = null;
          Navigator.pop(context);
        }
        // if (state is GetServiceRequestReportsSuccessState) {
        //   appBloc.reportsSelectDateController.selectedRange = null;
        //   appBloc.sideMenu = SideMenu.reports;
        //   if (appBloc.homeScreens[18].length > 1) {
        //     appBloc.changeStackNav(index: 18, isAdd: false);
        //   }
        //   Navigator.pop(context);
        // }
        if (state is GetServiceRequestReportsErrorState) {
          HelpooInAppNotification.showErrorMessage(message: 'Error while getting reports');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 500,
                    child: SfDateRangePicker(
                      controller: appBloc.reportsSelectDateController,
                      view: DateRangePickerView.month,
                      selectionMode: DateRangePickerSelectionMode.range,
                      enableMultiView: true,
                      startRangeSelectionColor: Theme.of(context).primaryColor,
                      endRangeSelectionColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  space10Vertical(),
                  SizedBox(
                    width: 500,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Confirm',
                            isLoading:
                                appBloc.isGetServiceRequestReportsLoading,
                            onPressed: () {
                              if (appBloc.reportsSelectDateController
                                      .selectedRange !=
                                  null) {
                                appBloc.startDate = DateFormat('yyyy-MM-dd')
                                    .format(appBloc.reportsSelectDateController
                                        .selectedRange!.startDate!);
                                appBloc.endDate = DateFormat('yyyy-MM-dd')
                                    .format(appBloc.reportsSelectDateController
                                            .selectedRange?.endDate ??
                                        appBloc.reportsSelectDateController
                                            .selectedRange?.startDate ??
                                        DateTime.now());
                              }
                            },
                          ),
                        ),
                        space10Horizontal(),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Cancel',
                            backgroundColor: Colors.red,
                            onPressed: () {
                              appBloc.reportsSelectDateController
                                  .selectedRange = null;
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
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
