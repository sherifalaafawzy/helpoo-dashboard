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
import '../../service_requests/components/service_component.dart';

class CreateNewCorporateBodyPopup extends StatefulWidget {
  const CreateNewCorporateBodyPopup({
    super.key,
  });

  @override
  State<CreateNewCorporateBodyPopup> createState() =>
      _CreateNewCorporateBodyPopupState();
}

class _CreateNewCorporateBodyPopupState
    extends State<CreateNewCorporateBodyPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CreateNewCorporateSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
              message: 'Corporate Created Successfully');
          appBloc.getAllCorporates();
          context.pop;
        }

        if (state is CreateNewCorporateErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 1122,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create New Corporate',
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
                          controller: appBloc.corporateEnNameController,
                          validationError: 'Enter English Name',
                          label: 'English Name*',
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: PrimaryFormField(
                          controller: appBloc.corporateArNameController,
                          validationError: 'Enter Arabic Name',
                          label: 'Arabic Name*',
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
                          controller: appBloc.corporateDiscountRatioController,
                          validationError: 'Enter Discount Ratio',
                          label: 'Discount Ratio',
                          isValidate: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'),
                            ),
                            LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              if (value == null) {
                                // HelpooInAppNotification
                                //     .showErrorMessage(
                                //         context: context,
                                //         message:
                                //             'Please select a date');
                                return;
                              }
                              appBloc.policyStartDate = value;
                              appBloc.corporateEndDateController.text =
                                  value.toString().split(' ').first;
                            });
                          },
                          child: PrimaryFormField(
                            controller: appBloc.corporateEndDateController,
                            validationError: 'Entre End Date Date',
                            label: 'End Date',
                            enabled: false,
                            isValidate: false,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ServiceComponent(
                        isSelected: appBloc.isDeferredPayment,
                        serviceName: 'Deferred Payment',
                        onSelectChanged: (value) {
                          appBloc.isDeferredPayment = value!;
                        },
                      ),
                      ServiceComponent(
                        isSelected: appBloc.isCashPayment,
                        serviceName: 'Cash Payment',
                        onSelectChanged: (value) {
                          appBloc.isCashPayment = value!;
                        },
                      ),
                      ServiceComponent(
                        isSelected: appBloc.isCreditPayment,
                        serviceName: 'Credit Payment',
                        onSelectChanged: (value) {
                          appBloc.isCreditPayment = value!;
                        },
                      ),
                      ServiceComponent(
                        isSelected: appBloc.isOnlinePayment,
                        serviceName: 'Online Payment',
                        onSelectChanged: (value) {
                          appBloc.isOnlinePayment = value!;
                        },
                      ),
                    ],
                  ),
                  space40Vertical(),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          isLoading: appBloc.isCreateNewCorporateLoading,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              appBloc.createNewCorporate();
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
                            appBloc.clearCreateCorporateControllers();
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
