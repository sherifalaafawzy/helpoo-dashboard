import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/service_request/get_all.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/loading_popup.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_more_widget.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'service_req_detailes.dart';
import 'steps/location.dart';
import '../create_new_service_request.dart';

import '../../../core/util/widgets/tables/components/table_text_and_sub_text_item.dart';

class ServiceRequestsTable extends StatefulWidget {
  const ServiceRequestsTable({super.key});

  @override
  State<ServiceRequestsTable> createState() => _ServiceRequestsTableState();
}

class _ServiceRequestsTableState extends State<ServiceRequestsTable> {
  // pagination logic

  List<TableRow> inspectorsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in AppBloc.get(context).itemsSubList) {
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
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Date',
          'Payment/Status',
          'Amount',
          'Driver',
          'Status',
          'Corporate/Branch',
          'Created By',
          '',
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

    appBloc.serviceRequestTimer ??= Timer.periodic(
      const Duration(seconds: 15),
      (timer) {
        if (userRoleName == Rules.Corporate.name) {
          appBloc.getCorporateServiceRequests(pageNumber: 1);
        } else {
          appBloc.getAllServiceRequest(pageNumber: 1);
        }
      },
    );
  }

  @override
  void dispose() {
    if (appBloc.serviceRequestTimer != null) {
      appBloc.serviceRequestTimer!.cancel();
      appBloc.serviceRequestTimer = null;
    }
    super.dispose();
  }

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is GetCurrentActiveServiceRequestLoadingState) {
          if (!state.isRefresh) {
            showPrimaryPopUp(
              context: context,
              isDismissible: false,
              title: 'Show Loading',
              popUpBody: const LoadingPopup(),
            );
          }
        }
        if (state is GetCurrentActiveServiceRequestSuccessState) {
          if (!state.isRefresh) {
            Navigator.pop(context);
            if (state.isThereActiveServiceRequest) {
              appBloc.changeStackNav(
                index: appBloc.currentSideMenuIndex,
                isAdd: true,
                widget: const MapsWidget(
                  isOpenFromSteps: false,
                ),
              );
            } else {
              HelpooInAppNotification.showMessage(
                message: "Can't track request with this status",
              );
            }
          }
        }
        if (state is CancelServiceRequestSuccessState) {
          appBloc.getCorporateServiceRequests(pageNumber: 1);
          HelpooInAppNotification.showMessage(
            message: "Service request canceled successfully",
          );
        }
        if (state is GetCorporateServiceRequestsLoadingState) {
          if (state.isRefreshServiceRequest) {
            showPrimaryPopUp(
              context: context,
              isDismissible: false,
              title: 'Show Loading',
              popUpBody: const LoadingPopup(),
            );
          }
        }

        if (state is GetCorporateServiceRequestsSuccessState) {
          if (state.isRefreshServiceRequest) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        if (appBloc.allServicesRequests?.requests?.isEmpty ?? true) {
          return emptyCase();
        }
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
                        Text(
                          appTranslation(context).serviceRequests,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 100,
                          child: PrimaryButton(
                            text: 'Refresh',
                            onPressed: () {
                              if (userRoleName == Rules.Corporate.name) {
                                appBloc.getCorporateServiceRequests(
                                  isRefreshServiceRequest: true,
                                  pageNumber: 1
                                );
                              } else {
                                appBloc.getAllServiceRequest(pageNumber: 1);
                              }
                            },
                          ),
                        ),
                        space20Horizontal(),
                        SizedBox(
                          width: 300,
                          child: PrimaryButton(
                            text: 'Creat New Service Request',
                            onPressed: () {
                              // appBloc.serviceRequestListModel = null;
                              appBloc.resetServiceRequestSteps();
                              // appBloc.originController.clear();
                              // appBloc.destinationController.clear();
                              appBloc.changeStackNav(
                                index: appBloc.currentSideMenuIndex,
                                isAdd: true,
                                widget: const CreateNewServiceRequest(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // space20Vertical(),
                  // SizedBox(
                  //   width: 1122,
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: PrimaryFormField(
                  //           validationError: '',
                  //           label: 'Search by name',
                  //           controller: appBloc.searchByNameController,
                  //           onChange: (value) {
                  //             if (value.length > 3) {
                  //               appBloc.searchServiceRequest();
                  //             }
                  //           },
                  //         ),
                  //       ),
                  //       space10Horizontal(),
                  //       Expanded(
                  //         child: PrimaryFormField(
                  //           validationError: '',
                  //           label: 'Search by ID',
                  //           onChange: (value) {
                  //             if (value.length > 0) {
                  //               Future.delayed(
                  //                   const Duration(milliseconds: 500), () {
                  //                 appBloc.searchServiceRequest();
                  //               });
                  //             } else {}
                  //           },
                  //           controller: appBloc.searchByIDController,
                  //         ),
                  //       ),
                  //       space10Horizontal(),
                  //       Expanded(
                  //         child: PrimaryFormField(
                  //           validationError: '',
                  //           label: 'Search by phone number',
                  //           onChange: (value) {
                  //             if (value.length > 10) {
                  //               appBloc.searchServiceRequest();
                  //             }
                  //           },
                  //           controller: appBloc.searchByPhoneNumberController,
                  //         ),
                  //       ),
                  //       space10Horizontal(),
                  //       InkWell(
                  //         onTap: () {},
                  //         child: Container(
                  //           width: 120,
                  //           decoration: BoxDecoration(
                  //             color: Theme.of(context).primaryColor,
                  //             borderRadius: BorderRadius.circular(5),
                  //           ),
                  //           padding: const EdgeInsets.symmetric(
                  //               vertical: 14, horizontal: 5),
                  //           child: Text(
                  //             'Filter by :',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyMedium!
                  //                 .copyWith(
                  //                   color: Colors.white,
                  //                 ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

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
                    //   ],
                    //   columnsTitles: [
                    //     'ID',
                    //     'Name',
                    //     'Date',
                    //     'Payment/Status',
                    //     'Amount',
                    //     'Driver',
                    //     'Status',
                    //     'Corporate Company',
                    //     '',
                    //     '',
                    //   ],
                    // ),
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 12 * appBloc.widgetWidth),
                      1: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1.5 / 12 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1.5 / 12 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      7: FixedColumnWidth(2 / 12 * appBloc.widgetWidth),
                      8: FixedColumnWidth(2 / 12 * appBloc.widgetWidth),
                      9: FixedColumnWidth(0.5 / 12 * appBloc.widgetWidth),
                    },
                    tableRows: inspectorsTableRows(),
                    paginationWidget: TablePaginationBar(pages: appBloc.allServicesRequests?.totalPages ?? 0,
                    isLoading: appBloc.getServiceRequestsLoadingForPagination,
                      items: appBloc.isSearchingServiceRequest
                          ? appBloc.serviceRequestsSearchResult?.requests ?? []
                          : appBloc.allServicesRequests?.requests ?? [],
 onCallAnotherPage: (int page) {
                          appBloc.currentServiceRequestPage = page;
                          if (!appBloc.isSearchingServiceRequest) {
                            appBloc.getCorporateServiceRequests(pageNumber: page);
                          }
                        }                    ),
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
          text: serviceRequestModel.client?.user?.name ?? '',
          isCentered: true,
        ),
        TableTextWithSubTextItem(
          text: serviceRequestModel.createdAtDate ?? '',
          subText: serviceRequestModel.createdAtTime ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: '${serviceRequestModel.paymentMethod ?? ''}/${serviceRequestModel.paymentStatus ?? ''}',
          isCentered: true,
        ),
        TableTextItem(
          text: '${serviceRequestModel.fees ?? ''}',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.driver?.user?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.status ?? '',
          isCentered: true,
        ),
        TableTextWithSubTextItem(
          text: '${serviceRequestModel.corporateCompany?.enName ?? '---'}',
          subText: '${serviceRequestModel.branch?.name ?? ''}',
          isCentered: true,
        ),
        TableTextWithSubTextItem(
          text: serviceRequestModel.user?.email != '' ? serviceRequestModel.user?.email ?? '--' : serviceRequestModel.user?.name ?? '--',
          subText: appBloc.getRoleNameBasedOnRoleId(serviceRequestModel.user?.roleId ?? 11),
          isCentered: true,
        ),
        // const TableTextItem(
        //   text: '',
        //   isCentered: true,
        // ),
        TableMoreWidget(
          onViewTap: () {
            appBloc.setSelectedServiceRequestId(
              id: serviceRequestModel.id,
              isForActiveService: false,
            );
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: ServiceRequestDetails(
                serviceRequestModel: serviceRequestModel,
              ),
            );
          },
          isPaymentPaid: serviceRequestModel.paymentStatus == 'paid',
          onTripTap: () {
            appBloc.setSelectedServiceRequestModel(model: serviceRequestModel, isForActiveService: true);
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: true);
          },
          onLinkTap: () {},
          onWaitingTimeTap: () {},
          onCommentTap: () {},
          onChangeDriverTap: () {},
          onAutoChangeDriverTap: () {},
          isOpenFromCorporate: true,
          onCloseTap: () {
            showPrimaryPopUp(
                context: context,
                popUpBody: SizedBox(
                  width: 500,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Are You Sure You Want To Cancel This Service Request?',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      space20Vertical(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              text: 'Yes',
                              isLoading: appBloc.isCancelServiceRequestLoading,
                              onPressed: () {
                                appBloc.cancelServiceRequest(serviceRequestModel: serviceRequestModel);
                                context.pop;
                              },
                            ),
                          ),
                          space10Horizontal(),
                          Expanded(
                            child: PrimaryButton(
                              text: 'No',
                              backgroundColor: Colors.red,
                              onPressed: () {
                                context.pop;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
          },
          isRunning: appBloc.getRunningStatus(serviceRequestModel.status ?? ''),
        ),
      ],
    );
  }

  Widget emptyCase() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          space40Vertical(),
          Text(
            'There Is No Service Requests Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space40Vertical(),
          SizedBox(
            width: 300,
            child: PrimaryButton(
              text: 'Creat New Service Request',
              onPressed: () {
                appBloc.changeStackNav(
                  index: appBloc.currentSideMenuIndex,
                  isAdd: true,
                  widget: const CreateNewServiceRequest(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
