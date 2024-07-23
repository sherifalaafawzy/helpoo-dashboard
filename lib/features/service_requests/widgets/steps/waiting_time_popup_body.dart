import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/extensions/build_context_extension.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';

class WaitingTimePopupBody extends StatefulWidget {
  final bool isApplied;
  final bool isNew;
  const WaitingTimePopupBody(
      {super.key, required this.isApplied, required this.isNew});

  @override
  State<WaitingTimePopupBody> createState() => _WaitingTimePopupBodyState();
}

class _WaitingTimePopupBodyState extends State<WaitingTimePopupBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey approvedByKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AddWaitingTimeSuccessState) {
          Navigator.of(context).pop();
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          HelpooInAppNotification.showMessage(
              message: 'Waiting Time Added Successfully');
        }
        if (state is AddWaitingTimeErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }

        if (state is ApplyWaitingTimeSuccessState) {
          Navigator.of(context).pop();
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          HelpooInAppNotification.showMessage(
              message: 'Waiting Time Applied Successfully');
        }

        if (state is ApplyWaitingTimeErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }

        if (state is RemoveWaitingTimeSuccessState) {
          Navigator.of(context).pop();
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          HelpooInAppNotification.showMessage(
              message: 'Waiting Time Removed Successfully');
        }

        if (state is RemoveWaitingTimeErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 800,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Waiting Time',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                space10Vertical(),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryFormField(
                        validationError: 'Time is required',
                        label: 'Waiting Time* (in minutes)',
                        enabled: appBloc.openWaitingTimeForms,
                        controller: appBloc.waitingTimeController,
                      ),
                    ),
                    space10Horizontal(),
                    Expanded(
                      child: PrimaryFormField(
                        validationError: 'Fees is required',
                        label: 'Waiting Fees*',
                        enabled: appBloc.openWaitingTimeForms,
                        controller: appBloc.waitingFeesController,
                      ),
                    ),
                    if (!widget.isNew && !widget.isApplied) ...{
                      space10Horizontal(),
                      InkWell(
                        onTap: () {
                          appBloc.openWaitingTimeForms =
                              !appBloc.openWaitingTimeForms;
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            appBloc.openWaitingTimeForms
                                ? Icons.close
                                : Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    }
                  ],
                ),
                // space10Vertical(),
                // Row(
                //   children: [
                //     Expanded(
                //       child: PrimaryFormField(
                //         key: approvedByKey,
                //         validationError: 'Approved By is required',
                //         label: 'Approved By*',
                //         controller: appBloc.discountApproverController,
                //         onTap: () {
                //           showPrimaryMenu(
                //             context: context,
                //             key: approvedByKey,
                //             items: const [
                //               PopupMenuItem(
                //                 value: 1,
                //                 child: Center(
                //                   child: Text('item 1'),
                //                 ),
                //               ),
                //               PopupMenuItem(
                //                 value: 2,
                //                 child: Center(
                //                   child: Text('item 2'),
                //                 ),
                //               ),
                //               PopupMenuItem(
                //                 value: 3,
                //                 child: Center(
                //                   child: Text('item 3'),
                //                 ),
                //               ),
                //             ],
                //           );
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                space10Vertical(),
                Row(
                  children: [
                    widget.isApplied
                        ? Expanded(
                            child: PrimaryButton(
                                text: 'Remove',
                                isLoading:
                                    state is RemoveWaitingTimeLoadingState,
                                onPressed: () {
                                  appBloc.removeWaitingTime();
                                }),
                          )
                        : Expanded(
                            child: PrimaryButton(
                                text: widget.isNew && !widget.isApplied
                                    ? 'Add'
                                    : appBloc.openWaitingTimeForms
                                        ? 'Edit'
                                        : 'Apply',
                                isLoading: appBloc.isWaitingTimeLoading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.isNew) {
                                      appBloc.addWaitingTime();
                                    } else {
                                      if (appBloc.openWaitingTimeForms) {
                                        appBloc.addWaitingTime();
                                      } else {
                                        appBloc.applyWaitingTime();
                                      }
                                    }
                                  }
                                }),
                          ),
                    space10Horizontal(),
                    Expanded(
                      child: PrimaryButton(
                          text: 'Cancel',
                          backgroundColor: Colors.red,
                          onPressed: () {
                            appBloc.waitingTimeController.clear();
                            appBloc.waitingFeesController.clear();
                            context.pop;
                          }),
                    ),
                    if (!widget.isNew && !widget.isApplied) ...{
                      space40Horizontal(),
                    }
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
