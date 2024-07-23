import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/helpoo_in_app_notifications.dart';
import '../../../../core/util/utils.dart';
import '../../../../core/util/widgets/primary_form_field.dart';
import '../../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../../../core/util/widgets/show_pop_up.dart';
import 'all_drivers_popup_body.dart';

class ServiceRequestConfirm extends StatefulWidget {
  const ServiceRequestConfirm({super.key});

  @override
  State<ServiceRequestConfirm> createState() => _ServiceRequestConfirmState();
}

class _ServiceRequestConfirmState extends State<ServiceRequestConfirm> {
  @override
  void initState() {
    super.initState();
    appBloc.paymentMethodController.clear();
    appBloc.corpBranchController.clear();

    if (!(appBloc.selectedCorporateId == null && userRoleName == Rules.CallCenter.name)) {
      appBloc.getAllCorpBranches();
    }

    appBloc.getPaymentMethodsList();
  }

  @override
  void dispose() {
    appBloc.selectedCorporateId = null;
    appBloc.corpBranches?.clear();
    debugPrint('lllllllllll selectedCorporateId: ${appBloc.selectedCorporateId}');
    super.dispose();
  }

  GlobalKey paymentMenuKey = GlobalKey();
  GlobalKey branchMenuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AssignDriverToServiceRequestSuccessState) {
          debugPrint('serviceRequestListModelStatus => ${appBloc.serviceRequestListModel?.status ?? 'null'}');
          // appBloc.serviceRequestListModel = null;
          printWarning('newFees: ${state.assignDriverResponse.newFees}');
          printWarning('driverAlreadyInReq : ${appBloc.driverAlreadyInReq}');
          if ((state.assignDriverResponse.newFees != null && state.assignDriverResponse.newFees! > 0) ||
              (appBloc.driverAlreadyInReq != null)) {
            showPrimaryPopUp(
              context: context,
              popUpBody: NewFeesAlertBody(
                newFees: state.assignDriverResponse.newFees!,
                diff: state.assignDriverResponse.differenceFees!,
                driverInReq: appBloc.driverAlreadyInReq,
              ),
            ).then(
              (value) {
                appBloc.changeStackNav(
                  index: appBloc.currentSideMenuIndex,
                  isAdd: false,
                );
                appBloc.resetServiceRequestSteps();
              },
            );
          } else {
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: false,
            );
            appBloc.resetServiceRequestSteps();
          }
        }
        if (state is CreateNewRequestSuccessState) {
          HelpooInAppNotification.showSuccessMessage(message: 'Request sent successfully');
          if (appBloc.newFees > 0) {
            showPrimaryPopUp(
              context: context,
              popUpBody: NewFeesAlertBody(
                newFees: appBloc.newFees,
                diff: 0,
              ),
            );
          }
        }
        if (state is CreateNewRequestErrorState) {
          HelpooInAppNotification.showErrorMessage(message: state.error);
          appBloc.changeStackNav(
            index: appBloc.currentSideMenuIndex,
            isAdd: false,
          );
          appBloc.resetServiceRequestSteps();
        }
      },
      builder: (context, state) {
        if (appBloc.isCreateNewRequestLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Request Data',
              //         style: Theme.of(context).textTheme.bodyMedium,
              //       ),
              //       space10Vertical(),
              //       ConfirmTextComponent(
              //         headline: 'ID',
              //         text: appBloc
              //                 .serviceRequestListModel?.serviceRequestDetails.id
              //                 .toString() ??
              //             '',
              //       ),
              //       space10Vertical(),
              //       ConfirmTextComponent(
              //         headline: 'Payment status',
              //         text: appBloc.serviceRequestListModel
              //                     ?.serviceRequestDetails.paymentStatus ==
              //                 ''
              //             ? 'Please select payment method'
              //             : appBloc.serviceRequestListModel
              //                     ?.serviceRequestDetails.paymentStatus ??
              //                 '',
              //       ),
              //       space10Vertical(),
              //       ConfirmTextComponent(
              //         headline: 'Payment method',
              //         text: appBloc.serviceRequestListModel
              //                     ?.serviceRequestDetails.paymentMethod ==
              //                 ''
              //             ? 'Please select payment method'
              //             : appBloc.serviceRequestListModel
              //                     ?.serviceRequestDetails.paymentMethod ??
              //                 '',
              //       ),
              //       space10Vertical(),
              //       ConfirmTextComponent(
              //         headline: 'Service Status',
              //         text: appBloc.serviceRequestListModel
              //                 ?.serviceRequestDetails.status ??
              //             '',
              //       ),
              //       space10Vertical(),
              //       ConfirmTextComponent(
              //         headline: 'Service Fees',
              //         text: appBloc.serviceRequestListModel
              //                 ?.serviceRequestDetails.fees
              //                 .toString() ??
              //             '',
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   height: 300,
              //   width: 2,
              //   color: borderGrey,
              // ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Payment way',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    space10Vertical(),
                    SizedBox(
                      width: 300,
                      child: InkWell(
                        key: paymentMenuKey,
                        onTap: () {

                          debugPrint('gggggggggg ${appBloc.paymentMethodsList.toString()}');

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
                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                          fontSize: 16.0,
                                          color: secondaryGrey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  onTap: () {
                                    appBloc.selectedPaymentMethod = e;
                                  },
                                ),
                              )
                            ],
                          );
                        },
                        child: PrimaryFormField(
                          validationError: '',
                          controller: appBloc.paymentMethodController,
                          label: 'Choose payment method',
                          enabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (/*userRoleName == Rules.Corporate.name && (appBloc.corpBranches == null || */ appBloc.isGetAllCorpBranchesLoading/*)*/)
                const CupertinoActivityIndicator(radius: 20),
              if (/*userRoleName == Rules.Corporate.name && */ appBloc.corpBranches != null && appBloc.corpBranches!.isNotEmpty && appBloc.isGetAllCorpBranchesLoading == false)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Branch name',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      space10Vertical(),
                      SizedBox(
                        width: 300,
                        child: InkWell(
                          key: branchMenuKey,
                          onTap: () {
                            showPrimaryMenu(
                              context: context,
                              key: branchMenuKey,
                              items: [
                                ...appBloc.corpBranches!.map(
                                      (e) => PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      e.name!,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                        fontSize: 16.0,
                                        color: secondaryGrey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    onTap: () {
                                      appBloc.selectedCorpBranch = e;
                                      appBloc.corpBranchController.text = e.name!;
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                          child: PrimaryFormField(
                            validationError: 'Choose branch',
                            isValidate: true,
                            controller: appBloc.corpBranchController,
                            label: 'Choose branch',
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
} // 01067300073
