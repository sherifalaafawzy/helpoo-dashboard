import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/extensions/build_context_extension.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';
import '../../../../core/util/widgets/primary_pop_up_menu.dart';

class ChangeStatusPopupBody extends StatefulWidget {
  const ChangeStatusPopupBody({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<ChangeStatusPopupBody> createState() => _ChangeStatusPopupBodyState();
}

class _ChangeStatusPopupBodyState extends State<ChangeStatusPopupBody> {
  GlobalKey statusDropdownKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is UpdateServiceRequestSuccessState) {
          HelpooInAppNotification.showMessage(
              message: 'Status changed successfully');
          appBloc.getAllServiceRequest(pageNumber: 1);
          appBloc.serviceRequestStatusController.clear();
          context.pop;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change Status',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black,
                    ),
              ),
              space20Vertical(),
              PrimaryFormField(
                key: statusDropdownKey,
                validationError: '',
                label: 'Select Status',
                controller: appBloc.serviceRequestStatusController,
                onTap: () {
                  showPrimaryMenu(
                      context: context,
                      key: statusDropdownKey,
                      items: [
                        ...ServiceRequestStatus.values.map(
                          (e) => PopupMenuItem(
                            value: 1,
                            child: Text(
                              e.enName,
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
                              appBloc.selectedServiceRequestStatus = e;
                            },
                          ),
                        ),
                      ]);
                },
              ),
              space20Vertical(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Change',
                      isLoading: appBloc.isUpdateServiceRequestLoading,
                      onPressed: () {
                        if (appBloc.selectedServiceRequestStatus != null) {
                          appBloc.updateServiceRequest(isUpdatePayment: false);
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
                        appBloc.serviceRequestStatusController.clear();
                        context.pop;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
