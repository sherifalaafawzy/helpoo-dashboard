import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/extensions/build_context_extension.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';

class CancelWithPaymentPopupBody extends StatefulWidget {
  const CancelWithPaymentPopupBody({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<CancelWithPaymentPopupBody> createState() =>
      _CancelWithPaymentPopupBodyState();
}

class _CancelWithPaymentPopupBodyState
    extends State<CancelWithPaymentPopupBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.cancelWithPaymentFeesController.clear();
    appBloc.cancelWithPaymentReasonController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CancelServiceRequestWithPaymentSuccessState) {
          HelpooInAppNotification.showMessage(
              message: 'Request Cancelled successfully');
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          appBloc.cancelWithPaymentFeesController.clear();
          appBloc.cancelWithPaymentReasonController.clear();
          context.pop;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Cancel With Payment',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                space20Vertical(),
                PrimaryFormField(
                  validationError: '',
                  label: 'Fees',
                  controller: appBloc.cancelWithPaymentFeesController,
                ),
                space20Vertical(),
                PrimaryFormField(
                  validationError: '',
                  label: 'Reason',
                  controller: appBloc.cancelWithPaymentReasonController,
                ),
                space20Vertical(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Apply',
                        isLoading: appBloc.isCancelWithPaymentLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            appBloc.cancelServiceRequestWithPayment();
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
                          appBloc.cancelWithPaymentFeesController.clear();
                          appBloc.cancelWithPaymentReasonController.clear();
                          context.pop;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
