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

class DiscountPopupBody extends StatefulWidget {
  final bool isApplied;
  final bool isNew;

  const DiscountPopupBody(
      {super.key, required this.isApplied, required this.isNew});

  @override
  State<DiscountPopupBody> createState() => _DiscountPopupBodyState();
}

class _DiscountPopupBodyState extends State<DiscountPopupBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey approvedByKey = GlobalKey();
  GlobalKey reasonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AddDiscountSuccessState) {
          Navigator.pop(context);
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          HelpooInAppNotification.showMessage(
              message: 'Discount Added Successfully');
        }

        if (state is AddDiscountErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }

        if (state is ApplyDiscountSuccessState) {
          Navigator.pop(context);
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          HelpooInAppNotification.showMessage(
              message: 'Discount Applied Successfully');
        }

        if (state is ApplyDiscountErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }

        if (state is RemoveDiscountSuccessState) {
          Navigator.pop(context);
          appBloc.getAllServiceRequest(
            pageNumber: 1
          );
          appBloc.discountValueController.text = '0';
          HelpooInAppNotification.showMessage(
              message: 'Discount Removed Successfully');
        }

        if (state is RemoveDiscountErrorState) {
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
                  widget.isNew ? 'Add Discount' : 'Apply Discount',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                space10Vertical(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PrimaryFormField(
                        validationError: 'Value is required',
                        label: 'Value*',
                        enabled: appBloc.openDiscountForms,
                        controller: appBloc.discountValueController,
                      ),
                    ),
                    if (!widget.isNew && !widget.isApplied) ...{
                      space10Horizontal(),
                      InkWell(
                        onTap: () {
                          appBloc.openDiscountForms =
                              !appBloc.openDiscountForms;
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            appBloc.openDiscountForms
                                ? Icons.close
                                : Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    }
                  ],
                ),
                if (!widget.isNew) ...{
                  if (!appBloc.openDiscountForms) ...{
                    space10Vertical(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PrimaryFormField(
                            key: reasonKey,
                            validationError: 'Reason is required',
                            label: 'Reason*',
                            enabled: !widget.isApplied,
                            controller: appBloc.discountReasonController,
                            onTap: () {
                              showPrimaryMenu(
                                  context: context,
                                  key: reasonKey,
                                  items: [
                                    ...appBloc.discountReasons.map(
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
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        onTap: () {
                                          appBloc.selectedDiscountReason = e;
                                        },
                                      ),
                                    )
                                  ]);
                            },
                          ),
                        ),
                        space10Horizontal(),
                        Expanded(
                          child: PrimaryFormField(
                            key: approvedByKey,
                            validationError: 'Approved By is required',
                            label: 'Approved By*',
                            enabled: !widget.isApplied,
                            controller: appBloc.discountApproverController,
                            onTap: () {
                              showPrimaryMenu(
                                  context: context,
                                  key: approvedByKey,
                                  items: [
                                    ...appBloc.approvedByList.map(
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
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        onTap: () {
                                          appBloc.selectedApprovedBy = e;
                                        },
                                      ),
                                    )
                                  ]);
                            },
                          ),
                        ),
                        if (!widget.isNew && !widget.isApplied) ...{
                          space40Horizontal(),
                        }
                      ],
                    ),
                  },
                },
                if (appBloc.isOtherReason) ...{
                  space10Vertical(),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryFormField(
                          validationError: 'Reason is required',
                          label: 'Other Reason*',
                          controller: appBloc.discountOtherReasonController,
                        ),
                      ),
                      if (!widget.isNew && !widget.isApplied) ...{
                        space40Horizontal(),
                      }
                    ],
                  ),
                },
                space10Vertical(),
                Row(
                  children: [
                    widget.isApplied
                        ? Expanded(
                            child: PrimaryButton(
                              text: 'Remove',
                              isLoading: state is RemoveDiscountLoadingState,
                              onPressed: () {
                                appBloc.removeDiscount();
                              },
                            ),
                          )
                        : Expanded(
                            child: PrimaryButton(
                                text: widget.isNew
                                    ? 'Add'
                                    : appBloc.openDiscountForms
                                        ? 'Edit'
                                        : 'Apply',
                                isLoading: appBloc.isDiscountLoading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.isNew && !widget.isApplied) {
                                      appBloc.addDiscount();
                                    } else {
                                      if (appBloc.openDiscountForms) {
                                        appBloc.addDiscount();
                                      } else {
                                        appBloc.applyDiscount();
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
                            appBloc.discountValueController.clear();
                            appBloc.discountApproverController.clear();
                            appBloc.discountReasonController.clear();
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
