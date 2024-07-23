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

class ChangePaymentPopupBody extends StatefulWidget {
  const ChangePaymentPopupBody({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<ChangePaymentPopupBody> createState() => _ChangePaymentPopupBodyState();
}

class _ChangePaymentPopupBodyState extends State<ChangePaymentPopupBody> {
  GlobalKey paymentMenuKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.paymentMethodController.clear();
    appBloc.getPaymentMethodsList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is UpdateServiceRequestSuccessState) {
          HelpooInAppNotification.showMessage(
              message: 'Payment changed successfully');
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          appBloc.paymentMethodController.clear();
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
                'Change Payment',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.black,
                    ),
              ),
              space20Vertical(),
              PrimaryFormField(
                key: paymentMenuKey,
                validationError: '',
                label: 'Select Payment Method',
                controller: appBloc.paymentMethodController,
                onTap: () {
                  showPrimaryMenu(
                    context: context,
                    key: paymentMenuKey,
                    items: [
                      ...appBloc.paymentMethodsList.map(
                        (e) => PopupMenuItem(
                          value: 1,
                          child: Text(
                            appBloc.handlePaymentMethodNames(name: e),
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
                            appBloc.selectedPaymentMethodFrompopup = e;
                          },
                        ),
                      )
                    ],
                  );
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
                        if (appBloc.selectedPaymentMethod != null) {
                          appBloc.updateServiceRequest(isUpdatePayment: true);
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
                        appBloc.paymentMethodController.clear();
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
