import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/shared_widgets/primary_checkbox.dart';

class CreateNewInspector extends StatefulWidget {
  const CreateNewInspector({super.key});

  @override
  State<CreateNewInspector> createState() => _CreateNewInspectorState();
}

class _CreateNewInspectorState extends State<CreateNewInspector> {
  GlobalKey insuranceCompaniesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  GlobalKey inspectorTypeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CreateNewInspectorSuccessState) {
          context.pop;
          HelpooInAppNotification.showSuccessMessage(
              message: 'Inspector Created');
          appBloc.getMyInspectors(isFromSuccess: true, isRefresh: true);
          if (userRoleName == Rules.Insurance.name) {
            appBloc.getMyInspectionCompaniesAsInsuranceCompany(
                isRefresh: true, isFromSuccess: true);
          }
        }
        if (state is CreateNewInspectorErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
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
                // space24Vertical(),
                PrimaryFormField(
                  controller: appBloc.inspectorNameController,
                  validationError: 'Enter Full Name',
                  label: 'Full Name*',
                ),
                space20Vertical(),
                PrimaryFormField(
                  controller: appBloc.inspectorMainPhoneController,
                  validationError: 'Enter Phone Number',
                  label: 'Main Phone Number*',
                  suffixIcon: appBloc.inspectorPhone2Shown
                      ? null
                      : InkWell(
                          onTap: () {
                            appBloc.showInspectorPhone2();
                          },
                          child: Icon(
                            Icons.add,
                            color: mainColorHex,
                          ),
                        ),
                ),
                space20Vertical(),
                Visibility(
                  visible: appBloc.inspectorPhone2Shown,
                  child: Column(
                    children: [
                      PrimaryFormField(
                        controller: appBloc.inspectorPhone2Controller,
                        validationError: '',
                        isValidate: false,
                        label: 'Phone Number 2',
                        suffixIcon: appBloc.inspectorPhone2Shown
                            ? InkWell(
                                onTap: () {
                                  appBloc.showInspectorPhone2();
                                  appBloc.inspectorPhone2Controller.clear();
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                              )
                            : null,
                      ),
                      space20Vertical(),
                    ],
                  ),
                ),
                PrimaryFormField(
                  controller: appBloc.inspectorMainEmailController,
                  validationError: 'Enter Email',
                  label: 'Main Email Address*',
                  suffixIcon: appBloc.inspectorEmail2Shown
                      ? null
                      : InkWell(
                          onTap: () {
                            appBloc.showInspectorEmail2();
                          },
                          child: Icon(
                            Icons.add,
                            color: mainColorHex,
                          ),
                        ),
                ),
                space20Vertical(),
                Visibility(
                  visible: appBloc.inspectorEmail2Shown,
                  child: Column(
                    children: [
                      PrimaryFormField(
                        controller: appBloc.inspectorEmail2Controller,
                        validationError: '',
                        isValidate: false,
                        label: 'Email Address 2',
                        suffixIcon: appBloc.inspectorEmail2Shown
                            ? InkWell(
                                onTap: () {
                                  appBloc.showInspectorEmail2();
                                  appBloc.inspectorEmail2Controller.clear();
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),

                if (userRoleName == Rules.Insurance.name) ...{
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryCheckbox(
                          text: InspectorTypes.values[0].name,
                          icon: Icons.add_home_work_outlined,
                          initialValue:
                              AppBloc.get(context).selectedInspectorType != null
                                  ? AppBloc.get(context)
                                          .selectedInspectorType ==
                                      InspectorTypes.values[0]
                                  : false,
                          valueChanged: (value) {
                            AppBloc.get(context).setSelectedInspectorType =
                                InspectorTypes.values[0];
                          },
                        ),
                      ),
                      space20Horizontal(),
                      Expanded(
                        child: PrimaryCheckbox(
                          text: InspectorTypes.values[1].name,
                          icon: Icons.person_outline,
                          initialValue:
                              AppBloc.get(context).selectedInspectorType != null
                                  ? AppBloc.get(context)
                                          .selectedInspectorType ==
                                      InspectorTypes.values[1]
                                  : false,
                          valueChanged: (value) {
                            AppBloc.get(context).setSelectedInspectorType =
                                InspectorTypes.values[1];
                          },
                        ),
                      ),
                    ],
                  ),
                },
                // PrimaryFormField(
                //   key: inspectorTypeKey,
                //   validationError: 'Please Select Type',
                //   label: 'Inspector Type*',
                //   controller: AppBloc.get(context).inspectorTypeController,
                //   onTap: () {
                //     showPrimaryMenu(
                //       context: context,
                //       key: inspectorTypeKey,
                //       items: [
                //         ...List.generate(
                //           InspectorTypes.values.length,
                //           (index) => PopupMenuItem(
                //             value: index,
                //             child: Text(
                //               InspectorTypes.values[index].name,
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displaySmall!
                //                   .copyWith(
                //                     fontSize: 16.0,
                //                     color: secondaryGrey,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //             ),
                //             onTap: () {
                //               AppBloc.get(context).selectedInspectorType =
                //                   InspectorTypes.values[index];
                //             },
                //           ),
                //         ),
                //       ],
                //     );
                //   },
                // ),
                space20Vertical(),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        isLoading: state is CreateNewInspectorLoadingState,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            appBloc.createNewInspector();
                          } else {
                            HelpooInAppNotification.showErrorMessage(
                              message: 'Please Fill All Fields',
                            );
                          }
                        },
                        text: 'Create',
                      ),
                    ),
                    space20Horizontal(),
                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.green,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                          onPressed: () {
                            appBloc.clearCreateInspectorData();
                            context.pop;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // space24Vertical(),
              ],
            ),
          ),
        );
      },
    );
  }
}
