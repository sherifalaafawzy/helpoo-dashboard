import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/service_request/get_all.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';

import '../../../core/util/widgets/back_button_widget.dart';

import '../../../core/util/widgets/primary_padding.dart';

import '../../../core/util/widgets/tables/components/table_header.dart';

import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_and_sub_text_item.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';


class ReportsTable extends StatefulWidget {
  const ReportsTable({super.key});

  @override
  State<ReportsTable> createState() => _ReportsTableState();
}

class _ReportsTableState extends State<ReportsTable> {
  // pagination logic

  List<TableRow> inspectorsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in AppBloc.get(context).itemsSubList) {
      // debugPrint('element:::::: ${element.status}');
      tableRows.add(tableItem(
        serviceRequestModel: element,
        isNew: element.status == 'pending',
      ));
    }

    tableRows.insert(
      0,
      TablesHeader.tableHeader(
        context: context,
        centeredIndexes: [
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
        ],
        columnsTitles: [
          'ID',
          'Created At',
          'Type',
          'Status',
          'Payment',
          'Driver',
          'User',
          'Discount',
          'Original Fees',
          'Fees',
          'Package',
          'Created By',
          // 'Actions',
        ],
      ),
    );

    return tableRows;
  }

  @override
  void initState() {
    super.initState();
    // here i clear the list to avoid duplication in pagination
    appBloc.itemsSubList = [];
  }

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PrimaryPadding(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  space20Vertical(),
                  SizedBox(
                    width: appBloc.getWidgetWidth(),
                    child: Row(
                      children: [
                        // Back Button
                        const BackButtonWidget(),
                        Text(
                          'Reports',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // const Spacer(),
                        // SizedBox(
                        //   width: 100,
                        //   child: PrimaryButton(
                        //     text: 'Refresh',
                        //     onPressed: () {
                        //       appBloc.getAllServiceRequest();
                        //     },
                        //   ),
                        // ),
                        // // if (userRoleName == Rules.CallCenter.name) ...{
                        // space10Horizontal(),
                        // SizedBox(
                        //   width: 300,
                        //   child: PrimaryButton(
                        //     text: 'Create New Service Request',
                        //     onPressed: () {
                        //       appBloc.resetServiceRequestSteps();
                        //       // appBloc.originController.clear();
                        //       // appBloc.destinationController.clear();
                        //       appBloc.changeStackNav(
                        //         index: appBloc.currentSideMenuIndex,
                        //         isAdd: true,
                        //         widget: const CreateNewServiceRequest(),
                        //       );
                        //     },
                        //   ),
                        // ),
                        // // },
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    // tableHeaderRow: TablesHeader.tableHeader(
                    //   context: context,
                    //   centeredIndexes: [
                    //     0,
                    //     1,
                    //     2,
                    //     3,
                    //     4,
                    //     5,
                    //     6,
                    //     7,
                    //     8,
                    //     9,
                    //     10,
                    //     // 11,
                    //   ],
                    //   columnsTitles: [
                    //     'ID',
                    //     'Created At',
                    //     'Type',
                    //     'Status',
                    //     'Payment',
                    //     'Driver',
                    //     'User',
                    //     'Discount',
                    //     'Original Fees',
                    //     'Fees',
                    //     'Created By',
                    //     // 'Actions',
                    //   ],
                    // ),

                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 13.5 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 13.5 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      7: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      8: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      9: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      10: FixedColumnWidth(1 / 13.5 * appBloc.widgetWidth),
                      11: FixedColumnWidth(2 / 13.5 * appBloc.widgetWidth),
                      // 11: FixedColumnWidth(1 / 13.5 * 1122),
                    },
                    tableRows: inspectorsTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.isDoneReportsOnly
                          ? appBloc.getAllDoneReportsModel()
                          : appBloc.allReportsModel?.requests ?? [],
                      onCallAnotherPage: (int page) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TableRow tableItem({
    required ServiceRequestModel serviceRequestModel,
    required bool isNew,
  }) {
    return TableRow(
      decoration: BoxDecoration(
          color: isNew ? Colors.red.withOpacity(.2) : null,
          border: const Border(
            bottom: BorderSide(
              color: borderGrey,
            ),
          )),
      children: [
        TableTextItem(
          text: serviceRequestModel.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.createdAt ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: appBloc
              .getRoleNameBasedOnRoleId(serviceRequestModel.user?.roleId ?? 11),
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.status ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.paymentMethod ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.driver?.user?.name ?? '',
          isCentered: true,
        ),
        TableTextWithSubTextItem(
          text: serviceRequestModel.client?.user?.name ?? '',
          subText: serviceRequestModel.client?.user?.phoneNumber ?? '',
          isCentered: true,
        ),
        TableTextItem(
          // text: serviceRequestModel.adminDiscount?.toString() ?? '',
          text: appBloc.getHighestDiscount([
            serviceRequestModel.adminDiscount ?? 0,
            serviceRequestModel.discountPercentage ?? 0,
            // serviceRequestModel.policyAndPackage!.packageDiscountPercentage ?? 0
          ]),
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.originalFees?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.fees?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.clientPackage?.package?.arName ?? '---',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.user?.email != ''
              ? serviceRequestModel.user?.email ?? ''
              : serviceRequestModel.user?.name ?? '',
          isCentered: true,
        ),
        // TableMoreWidget(
        //   onViewTap: () {
        //     // showPrimaryPopUp(
        //     //   context: context,
        //     //   isDismissible: false,
        //     //   title: 'Service Request Details',
        //     //   popUpBody: ServiceRequestDetails(
        //     //     serviceRequestModel: serviceRequestModel,
        //     //   ),
        //     // );
        //
        //     appBloc.changeStackNav(
        //       index: appBloc.currentSideMenuIndex,
        //       isAdd: true,
        //       widget: ServiceRequestDetails(
        //         serviceRequestModel: serviceRequestModel,
        //       ),
        //     );
        //   },
        //   onTripTap: () {
        //     appBloc.setSelectedServiceRequestId(
        //         id: serviceRequestModel.id, isForActiveService: true);
        //   },
        //   onLinkTap: () {
        //     debugPrint('onLinkTap');
        //     // context.pop;
        //     appBloc.setSelectedServiceRequestId(
        //         id: serviceRequestModel.id, isForActiveService: false);
        //     appBloc.discountValueController.text =
        //         serviceRequestModel.adminDiscount.toString();
        //     appBloc.discountApproverController.text =
        //     serviceRequestModel.adminDiscountApprovedBy!;
        //     appBloc.discountReasonController.text =
        //     serviceRequestModel.adminDiscountReason!;
        //     if (serviceRequestModel.adminDiscount != 0) {
        //       appBloc.openDiscountForms = false;
        //     }
        //     showPrimaryPopUp(
        //       context: context,
        //       isDismissible: false,
        //       title: 'Add Discount',
        //       popUpBody: DiscountPopupBody(
        //         isApplied: serviceRequestModel.isAdminDiscountApplied!,
        //         isNew: serviceRequestModel.adminDiscount == 0,
        //       ),
        //     );
        //   },
        //   onWaitingTimeTap: () {
        //     debugPrint('onWaitingTimeTap');
        //     appBloc.setSelectedServiceRequestId(
        //         id: serviceRequestModel.id, isForActiveService: false);
        //     appBloc.waitingFeesController.text =
        //         serviceRequestModel.waitingFees.toString();
        //     appBloc.waitingTimeController.text =
        //         serviceRequestModel.waitingTime.toString();
        //
        //     if (appBloc.waitingFeesController.text != '0' &&
        //         appBloc.waitingTimeController.text != '0') {
        //       appBloc.openWaitingTimeForms = false;
        //     }
        //     // context.pop;
        //     showPrimaryPopUp(
        //       context: context,
        //       isDismissible: false,
        //       title: 'Add Waiting Time',
        //       popUpBody: WaitingTimePopupBody(
        //         isApplied: serviceRequestModel.isWaitingTimeApplied!,
        //         isNew: appBloc.waitingFeesController.text == '0' &&
        //             appBloc.waitingTimeController.text == '0',
        //       ),
        //     );
        //   },
        //   onCommentTap: () {
        //     debugPrint('onCommentTap');
        //     appBloc.setSelectedServiceRequestId(
        //         id: serviceRequestModel.id, isForActiveService: false);
        //     // context.pop;
        //     appBloc.commentOnRequestController.text =
        //         serviceRequestModel.adminComment ?? '';
        //     showPrimaryPopUp(
        //       context: context,
        //       isDismissible: false,
        //       title: 'Add Comment',
        //       popUpBody: const CommentPopupBody(),
        //     );
        //   },
        //   onChangeDriverTap: () {
        //     appBloc.setSelectedServiceRequestId(
        //         id: serviceRequestModel.id, isForActiveService: false);
        //     appBloc.setSelectedServiceRequestModel(model: serviceRequestModel);
        //
        //     showPrimaryPopUp(
        //       context: context,
        //       title: 'Change Driver',
        //       popUpBody: const DriverSelectionBodyPopup(),
        //     );
        //   },
        //   isRunning: appBloc.getRunningStatus(serviceRequestModel.status ?? ''),
        //   onCloseTap: () {
        //     showPrimaryPopUp(
        //         context: context,
        //         popUpBody: SizedBox(
        //           width: 500,
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Text(
        //                 'Are You Sure You Want To Cancel This Service Request?',
        //                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
        //                   color: Colors.black,
        //                 ),
        //               ),
        //               space20Vertical(),
        //               Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   Expanded(
        //                     child: PrimaryButton(
        //                       text: 'Yes',
        //                       isLoading: appBloc.isCancelServiceRequestLoading,
        //                       onPressed: () {
        //                         appBloc.cancelServiceRequest(
        //                             serviceRequestId: serviceRequestModel.id);
        //                         context.pop;
        //                       },
        //                     ),
        //                   ),
        //                   space10Horizontal(),
        //                   Expanded(
        //                     child: PrimaryButton(
        //                       text: 'No',
        //                       backgroundColor: Colors.red,
        //                       onPressed: () {
        //                         context.pop;
        //                       },
        //                     ),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           ),
        //         ));
        //   },
        //   onChangeStatus: () {
        //     appBloc.setSelectedServiceRequestId(
        //         id: serviceRequestModel.id, isForActiveService: false);
        //     showPrimaryPopUp(
        //       context: context,
        //       popUpBody: ChangeStatusPopupBody(
        //         context: context,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
