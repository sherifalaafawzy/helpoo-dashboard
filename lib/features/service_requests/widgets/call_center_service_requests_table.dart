import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_more_widget.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_and_sub_text_item.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'service_req_detailes.dart';
import 'steps/all_drivers_popup_body.dart';
import 'steps/cancel_with_payment_popup_body.dart';
import 'steps/change_payment_popup_body.dart';
import 'steps/change_status_popup_body.dart';
import 'steps/comment_popup_body.dart';
import 'steps/discount_popup_body.dart';
import 'steps/waiting_time_popup_body.dart';
import '../create_new_service_request.dart';

class CallCenterServiceRequestsTable extends StatefulWidget {
  const CallCenterServiceRequestsTable({super.key});

  @override
  State<CallCenterServiceRequestsTable> createState() => _CallCenterServiceRequestsTableState();
}

class _CallCenterServiceRequestsTableState extends State<CallCenterServiceRequestsTable> {
  // pagination logic

  List<TableRow> requestsTableRows() {
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
        isWithSort: [
          true,
          true,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          true,
          false,
          false,
        ],
        onSort: [
          () {
            appBloc.selectedSortingBy = 'id';
            appBloc.changeSortingType(isSortById: true);
            appBloc.sortServiceRequests();
            appBloc.getAllServiceRequest(pageNumber: 1);
          },
          () {
            appBloc.selectedSortingBy = 'createdAt';
            appBloc.changeSortingType(isSortByDate: true);
            appBloc.sortServiceRequests();
            appBloc.getAllServiceRequest(pageNumber: 1);
          },
          () {},
          () {},
          () {},
          () {},
          () {},
          () {},
          () {},
          () {
            appBloc.selectedSortingBy = 'fees';
            appBloc.changeSortingType(isSortByFees: true);
            appBloc.sortServiceRequests();
            appBloc.getAllServiceRequest(pageNumber: 1);
          },
          () {},
          () {},
        ],
        columnsTitles: [
          'ID',
          'Created At',
          'Type',
          'Wench',
          'Status',
          'Payment',
          'Driver',
          'User',
          // 'Discount',
          'Fees',
          'Corporate',
          'Created By',
          'Actions',
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
    appBloc.currentServiceRequestPage = 1;

    appBloc.serviceRequestTimer = Timer.periodic(
      const Duration(seconds: 15),
      (timer) {
        appBloc.getAllServiceRequest(isRefresh: false, pageNumber: appBloc.currentServiceRequestPage);

        appBloc.getServiceRequestTypes();
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
  GlobalKey filterTypesKey = GlobalKey();
  GlobalKey statusFilterKey = GlobalKey();
  GlobalKey serviceTypeFilterKey = GlobalKey();
  GlobalKey clientTypeFilterKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        // if (state is AssignDriverToServiceRequestSuccessState) {
        //   printWarning('newFees: ${state.assignDriverResponse.newFees}');
        //   if ((state.assignDriverResponse.newFees != null && state.assignDriverResponse.newFees! > 0) ||
        //       (appBloc.driverAlreadyInReq != null)) {
        //     Navigator.pop(context);
        //     showPrimaryPopUp(
        //       context: context,
        //       popUpBody: NewFeesAlertBody(
        //         newFees: state.assignDriverResponse.newFees!,
        //         diff: state.assignDriverResponse.differenceFees!,
        //         driverInReq: appBloc.driverAlreadyInReq,
        //       ),
        //     ).then(
        //           (value) {
        //         HelpooInAppNotification.showSuccessMessage(message: 'Driver changed successfully');
        //         appBloc.driverAlreadyInReq = null;
        //         appBloc.getAllServiceRequest();
        //       },
        //     );
        //   } else {
        //     HelpooInAppNotification.showSuccessMessage(message: 'Driver changed successfully');
        //     Navigator.pop(context);
        //     appBloc.getAllServiceRequest();
        //   }
        // }
        // if (state is AssignDriverToServiceRequestErrorState) {
        //   HelpooInAppNotification.showErrorMessage(message: state.error);
        //   Navigator.pop(context);
        // }
        //
        if (state is GetCurrentActiveServiceRequestLoadingState) {
          showPrimaryPopUp(
            context: context,
            isDismissible: false,
            title: 'Show Loading',
            popUpBody: const LoadingPopup(),
          );
        }
        if (state is CancelServiceRequestLoadingState) {
          showPrimaryPopUp(
            context: context,
            isDismissible: false,
            title: 'Show Loading',
            popUpBody: const LoadingPopup(),
          );
        }
        if (state is GetCurrentActiveServiceRequestSuccessState) {
          Navigator.pop(context);
          if (state.isThereActiveServiceRequest) {
            // html.window.open('/tracking', '_blank');
            // appBloc.openNewTab(Routes.tracking);
            appBloc.openGoogleMapsTab();

            // appBloc.changeStackNav(
            //   index: appBloc.currentSideMenuIndex,
            //   isAdd: true,
            //   widget: const MapsWidget(
            //     isOpenFromSteps: false,
            //   ),
            // );
          } else {
            HelpooInAppNotification.showMessage(
              message: "Can't track request with this status",
            );
          }
        }
        if (state is GetCurrentActiveServiceRequestErrorState) {
          Navigator.pop(context);
          if (kReleaseMode) {
            debugPrint('error occurred in production >> ${state.error}');
          }
        }
        if (state is CancelServiceRequestSuccessState) {
          Navigator.pop(context);
          appBloc.getAllServiceRequest(pageNumber: 1);

          HelpooInAppNotification.showMessage(
            message: "Service request canceled successfully",
          );
        }
        if (state is AutoAssignDriverToServiceRequestSuccessState) {
          HelpooInAppNotification.showMessage(
            message: state.message ?? '',
          );
        }

        if (state is CancelServiceRequestErrorState) {
          Navigator.pop(context);
          HelpooInAppNotification.showMessage(
            message: state.error,
            color: Colors.red,
          );
        }
        if (state is SearchServiceRequestLoadingState) {
          if (appBloc.serviceRequestTimer != null) {
            appBloc.serviceRequestTimer!.cancel();
            appBloc.serviceRequestTimer = null;
          }
          showPrimaryPopUp(
            context: context,
            isDismissible: false,
            title: 'Show Loading',
            popUpBody: const LoadingPopup(),
          );
        }
        if (state is SearchServiceRequestSuccessState) {
          Navigator.pop(context);
        }
        if (state is GetAllServiceRequestLoadingState) {
          if (state.isRefreshServiceRequest) {
            showPrimaryPopUp(
              context: context,
              isDismissible: false,
              title: 'Show Loading',
              popUpBody: const LoadingPopup(),
            );
          }
        }
        if (state is GetAllServiceRequestSuccessState) {
          if (state.isRefreshServiceRequest) {
            Navigator.pop(context);
          }
        }
        if (state is RefuseRequestRejectSuccess || state is ApproveReqCancelSuccess) {
          appBloc.getAllServiceRequest(pageNumber: 1);
        }
      },
      builder: (context, state) {
        if (appBloc.allServicesRequests!.requests!.isEmpty && !appBloc.isFilterServiceRequest) {
          return emptyCase();
        }
        // if (appBloc.serviceRequestsSearchResult?.requests?.isEmpty ?? false) {
        //   return emptyCase();
        // }
        return PrimaryPadding(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  space20Vertical(),
                  SizedBox(
                    width: appBloc.sideMenuCollapsed ? appBloc.getWidgetWidth() : 1122,
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
                              appBloc.currentServiceRequestPage = 1;

                              appBloc.getAllServiceRequest(pageNumber: 1, isRefresh: true);
                            },
                          ),
                        ),
                        // if (userRoleName == Rules.CallCenter.name) ...{
                        space10Horizontal(),
                        SizedBox(
                          width: 300,
                          child: PrimaryButton(
                            text: 'Create New Service Request',
                            onPressed: () {
                              appBloc.resetServiceRequestSteps();
                              appBloc.setAvailablePaymentsForCorporates(
                                isCash: true,
                                isDeferredPayment: true,
                                isCardToDriver: true,
                                isOnline: false,
                                isOnlineLink: true,
                              );
                              appBloc.changeStackNav(
                                index: appBloc.currentSideMenuIndex,
                                isAdd: true,
                                widget: const CreateNewServiceRequest(),
                              );
                            },
                          ),
                        ),
                        // },
                      ],
                    ),
                  ),
                  space20Vertical(),
                  SizedBox(
                    width: appBloc.sideMenuCollapsed ? appBloc.getWidgetWidth() : 1122,
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryFormField(
                            validationError: '',
                            label: 'Search by name',
                            controller: appBloc.searchByNameController,
                          ),
                        ),
                        space10Horizontal(),
                        Expanded(
                          child: PrimaryFormField(
                            validationError: '',
                            label: 'Search by ID',
                            controller: appBloc.searchByIDController,
                          ),
                        ),
                        space10Horizontal(),
                        Expanded(
                          child: PrimaryFormField(
                            validationError: '',
                            label: 'Search by phone number',
                            controller: appBloc.searchByPhoneNumberController,
                          ),
                        ),
                        space10Horizontal(),
                        InkWell(
                          onTap: () {
                            appBloc.searchServiceRequest();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                            child: Text(
                              'Search',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        space10Horizontal(),
                        InkWell(
                          key: filterTypesKey,
                          onTap: () {
                            showPrimaryMenu(
                              context: context,
                              key: filterTypesKey,
                              items: [
                                ...FilterTypes.values.map(
                                  (e) => PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      e.name,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                            fontSize: 16.0,
                                            color: secondaryGrey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    onTap: () {
                                      appBloc.selectedFilterType = e;
                                      // appBloc.getAllServiceRequest();
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                            child: Text(
                              'Filter by : ${appBloc.selectedFilterType.name}',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        space10Horizontal(),
                        InkWell(
                          onTap: () {
                            appBloc.serviceRequestTimer ??= Timer.periodic(
                              const Duration(seconds: 15),
                              (timer) {
                                appBloc.getAllServiceRequest(isRefresh: false, pageNumber: 1);
                                appBloc.getServiceRequestTypes();
                              },
                            );
                            appBloc.clearFilters();
                            appBloc.getAllServiceRequest(pageNumber: 1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                            child: Text(
                              'Clear',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (appBloc.selectedFilterType == FilterTypes.clientType ||
                      appBloc.selectedFilterType == FilterTypes.serviceType ||
                      appBloc.selectedFilterType == FilterTypes.status)
                    space20Vertical(),

                  // status filter
                  if (appBloc.selectedFilterType == FilterTypes.status)
                    SizedBox(
                      width: appBloc.sideMenuCollapsed ? appBloc.getWidgetWidth() : 1122,
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              key: statusFilterKey,
                              label: 'Select ${appBloc.selectedFilterType.name}',
                              validationError: '',
                              controller: appBloc.statusFilterController,
                              onTap: () {
                                showPrimaryMenu(
                                  context: context,
                                  key: statusFilterKey,
                                  items: [
                                    ...ServiceStatus.values.map(
                                      (e) => PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          e.name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                fontSize: 16.0,
                                                color: secondaryGrey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        onTap: () {
                                          appBloc.selectedServiceStatus = e;
                                          // appBloc.getAllServiceRequest();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          space10Horizontal(),
                          SizedBox(
                            height: 48.5,
                            width: 120,
                            child: PrimaryButton(
                              text: 'Submit',
                              isLoading: state is GetAllServiceRequestLoadingState,
                              onPressed: () {
                                appBloc.getAllServiceRequest(pageNumber: 1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  // service type filter
                  if (appBloc.selectedFilterType == FilterTypes.serviceType && appBloc.serviceRequestTypes!.isNotEmpty)
                    SizedBox(
                      width: appBloc.sideMenuCollapsed ? appBloc.getWidgetWidth() : 1122,
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              key: serviceTypeFilterKey,
                              label: 'Select ${appBloc.selectedFilterType.name}',
                              validationError: '',
                              controller: appBloc.serviceTypeFilterController,
                              onTap: () {
                                showPrimaryMenu(
                                  context: context,
                                  key: serviceTypeFilterKey,
                                  items: [
                                    ...appBloc.serviceRequestTypes!.map(
                                      (e) => PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          e.enName ?? '',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                fontSize: 16.0,
                                                color: secondaryGrey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        onTap: () {
                                          appBloc.selectedServiceRequestType = e;
                                          // appBloc.getAllServiceRequest();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          space10Horizontal(),
                          SizedBox(
                            height: 48.5,
                            width: 120,
                            child: PrimaryButton(
                              text: 'Submit',
                              isLoading: state is GetAllServiceRequestLoadingState,
                              onPressed: () {
                                appBloc.getAllServiceRequest(pageNumber: 1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  // client type filter
                  if (appBloc.selectedFilterType == FilterTypes.clientType)
                    SizedBox(
                      width: appBloc.sideMenuCollapsed ? appBloc.getWidgetWidth() : 1122,
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              key: clientTypeFilterKey,
                              label: 'Select ${appBloc.selectedFilterType.name}',
                              validationError: '',
                              controller: appBloc.clientTypeFilterController,
                              onTap: () {
                                showPrimaryMenu(
                                  context: context,
                                  key: clientTypeFilterKey,
                                  items: [
                                    ...appBloc.clientTypesList.map(
                                      (e) => PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          e.name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                fontSize: 16.0,
                                                color: secondaryGrey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                        onTap: () {
                                          appBloc.setSelectedFilterClientType(e);
                                          // appBloc.getAllServiceRequest();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          space10Horizontal(),
                          SizedBox(
                            height: 48.5,
                            width: 120,
                            child: PrimaryButton(
                              text: 'Submit',
                              isLoading: state is GetAllServiceRequestLoadingState,
                              onPressed: () {
                                appBloc.getAllServiceRequest(pageNumber: 1);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  space40Vertical(),
                  if (appBloc.allServicesRequests!.requests!.isNotEmpty)
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
                      //     11,
                      //   ],
                      //   isWithSort: [
                      //     true,
                      //     true,
                      //     false,
                      //     false,
                      //     false,
                      //     false,
                      //     false,
                      //     false,
                      //     false,
                      //     true,
                      //     false,
                      //     false,
                      //   ],
                      //   onSort: [
                      //     () {
                      //       appBloc.selectedSortingBy = 'id';
                      //       appBloc.changeSortingType(isSortById: true);
                      //       appBloc.sortServiceRequests();
                      //       appBloc.getAllServiceRequest();
                      //     },
                      //     () {
                      //       appBloc.selectedSortingBy = 'createdAt';
                      //       appBloc.changeSortingType(isSortByDate: true);
                      //       appBloc.sortServiceRequests();
                      //       appBloc.getAllServiceRequest();
                      //     },
                      //     () {},
                      //     () {},
                      //     () {},
                      //     () {},
                      //     () {},
                      //     () {},
                      //     () {},
                      //     () {
                      //       appBloc.selectedSortingBy = 'fees';
                      //       appBloc.changeSortingType(isSortByFees: true);
                      //       appBloc.sortServiceRequests();
                      //       appBloc.getAllServiceRequest();
                      //     },
                      //     () {},
                      //     () {},
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
                      //     'Actions',
                      //   ],
                      // ),

                      columnWidths: {
                        0: FixedColumnWidth(0.7 / 15 * appBloc.widgetWidth),
                        1: FixedColumnWidth(1.9 / 15 * appBloc.widgetWidth),
                        2: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),

                        3: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),
                        4: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),
                        5: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),
                        6: FixedColumnWidth(1.5 / 15 * appBloc.widgetWidth),
                        7: FixedColumnWidth(1.5 / 15 * appBloc.widgetWidth),
                        // 7: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),
                        8: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),
                        9: FixedColumnWidth(1.5 / 15 * appBloc.widgetWidth),
                        10: FixedColumnWidth(2 / 15 * appBloc.widgetWidth),
                        11: FixedColumnWidth(1 / 15 * appBloc.widgetWidth),
                      },
                      tableRows: requestsTableRows(),
                      paginationWidget: TablePaginationBar(
                        items: appBloc.isSearchingServiceRequest
                            ? appBloc.serviceRequestsSearchResult?.requests ?? []
                            : appBloc.allServicesRequests?.requests ?? [],
                        pages: appBloc.allServicesRequests!.totalPages ?? 1,
                        isLoading: appBloc.getServiceRequestsLoadingForPagination,
                        onCallAnotherPage: (int page) {
                          appBloc.currentServiceRequestPage = page;
                          if (!appBloc.isSearchingServiceRequest) {
                            appBloc.getAllServiceRequest(pageNumber: page);
                          }
                        },
                      ),
                    ),
                  if (appBloc.allServicesRequests!.requests!.isEmpty && appBloc.isFilterServiceRequest) emptyCase(),
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
          color: isNew
              ? Colors.red.withOpacity(.2)
              : ((serviceRequestModel.reject ?? false) && serviceRequestModel.isRequestActive)
                  ? Colors.orangeAccent
                  : null,
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
        TableTextWithSubTextItem(
          text: serviceRequestModel.createdAtDate ?? '',
          subText: serviceRequestModel.createdAtTime ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: (serviceRequestModel.carServiceTypes?.isNotEmpty ?? false)
              // ? serviceRequestModel.carServiceTypes!.map((e) => CarServiceType.values.firstWhere((element) => element.id == e.id).nameEn).join('\n')
              ? serviceRequestModel.carServiceTypes!.map((e) => appBloc.serviceRequestTypes?.firstWhere((element) => element.id == e.id).enName).join('\n')
              : '',
          maxLines: 4,
          isCentered: true,
        ),
        TableTextWithSubTextItem(
          text: serviceRequestModel.vehicle?.vehicleType?.typeName == 'europeanTowTruck'
              ? 'European'
              : serviceRequestModel.vehicle?.vehicleType?.typeName == 'normal'
                  ? 'Normal'
                  : '-',
          subText: '${serviceRequestModel.vehicle?.VecName ?? '-'}-${serviceRequestModel.vehicle?.VecNum ?? '-'}',
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
        TableTextWithSubTextItem(
          text: serviceRequestModel.driver?.user?.name ?? '',
          subText: serviceRequestModel.driver?.user?.phoneNumber ?? '',
          isCentered: true,
        ),
        TableTextWithSubTextItem(
          text: serviceRequestModel.client?.user?.name ?? '',
          subText: serviceRequestModel.client?.user?.phoneNumber ?? '',
          isCentered: true,
        ),
        //* TODO : Remove
        // TableTextItem(
        //   // text: serviceRequestModel.adminDiscount?.toString() ?? '',
        //   text: appBloc.getHighestDiscount([
        //     serviceRequestModel.adminDiscount ?? 0,
        //     serviceRequestModel.discountPercentage ?? 0,
        //     // serviceRequestModel.policyAndPackage!.packageDiscountPercentage ?? 0
        //   ]),
        //   isCentered: true,
        // ),
        TableTextItem(
          text: serviceRequestModel.fees?.toString() ?? '',
          isCentered: true,
        ),
        //* TODO : Remove
        TableTextItem(
          text: '${serviceRequestModel.corporateCompany?.enName ?? '---'} \n${serviceRequestModel.branch?.name ?? ''}',
          // text: serviceRequestModel.corporateCompany != null ? serviceRequestModel.corporateCompany!.enName ?? '' : '--',
          isCentered: true,
        ),

        TableTextWithSubTextItem(
          text: serviceRequestModel.user?.email != '' ? serviceRequestModel.user?.email ?? '' : serviceRequestModel.user?.name ?? '',
          subText: appBloc.getRoleNameBasedOnRoleId(serviceRequestModel.user?.roleId ?? 11),
          isCentered: true,
        ),
        TableMoreWidget(
          onClick: () {
            appBloc.setSelectedServiceRequestModel(model: serviceRequestModel, isForActiveService: false);
          },
          onLiveStreamTap: () {
            appBloc.openNewTab(serviceRequestModel.camUrl ?? '');
          },
          onShareTrackingTap: () {
            Clipboard.setData(
              ClipboardData(
                text: 'https://tracking.helpooapp.net/tracking/?id=${serviceRequestModel.id}',
              ),
            );

            HelpooInAppNotification.showSuccessMessage(
              duration: const Duration(seconds: 2),
              message: 'Tracking link copied to clipboard',
            );
          },
          onViewTap: () {
            // showPrimaryPopUp(
            //   context: context,
            //   isDismissible: false,
            //   title: 'Service Request Details',
            //   popUpBody: ServiceRequestDetails(
            //     serviceRequestModel: serviceRequestModel,
            //   ),
            // );
            appBloc.setSelectedServiceRequestId(
              id: serviceRequestModel.id,
              isForActiveService: false,
            );
            debugPrint('onViewTap');
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
            debugPrint('onTripTap');
            appBloc.setSelectedServiceRequestModel(model: serviceRequestModel, isForActiveService: true);
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: true);
          },
          onLinkTap: () {
            debugPrint('onLinkTap');
            // context.pop;

            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            appBloc.discountValueController.text = serviceRequestModel.adminDiscount.toString();
            appBloc.discountApproverController.text = serviceRequestModel.adminDiscountApprovedBy!;
            appBloc.discountReasonController.text = serviceRequestModel.adminDiscountReason!;
            if (serviceRequestModel.adminDiscount != 0) {
              appBloc.openDiscountForms = false;
            }
            appBloc.setSelectedServiceRequestModel(model: serviceRequestModel);
            showPrimaryPopUp(
              context: context,
              isDismissible: false,
              title: 'Add Discount',
              popUpBody: DiscountPopupBody(
                isApplied: serviceRequestModel.isAdminDiscountApplied!,
                isNew: serviceRequestModel.adminDiscount == 0,
              ),
            );
          },
          onWaitingTimeTap: () {
            debugPrint('onWaitingTimeTap');
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            appBloc.waitingFeesController.text = serviceRequestModel.waitingFees.toString();
            appBloc.waitingTimeController.text = serviceRequestModel.waitingTime.toString();

            if (appBloc.waitingFeesController.text != '0' && appBloc.waitingTimeController.text != '0') {
              appBloc.openWaitingTimeForms = false;
            }
            // context.pop;
            showPrimaryPopUp(
              context: context,
              isDismissible: false,
              title: 'Add Waiting Time',
              popUpBody: WaitingTimePopupBody(
                isApplied: serviceRequestModel.isWaitingTimeApplied!,
                isNew: appBloc.waitingFeesController.text == '0' && appBloc.waitingTimeController.text == '0',
              ),
            );
          },
          onCommentTap: () {
            debugPrint('onCommentTap');
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            // context.pop;
            appBloc.commentOnRequestController.text = serviceRequestModel.adminComment ?? '';
            showPrimaryPopUp(
              context: context,
              isDismissible: false,
              title: 'Add Comment',
              popUpBody: const CommentPopupBody(),
            );
          },
          onAutoChangeDriverTap: () {
            debugPrint('onAutoChangeDriverTap');

            appBloc.autoAssignDriverToServiceRequest(
              driverId: serviceRequestModel.driverId.toString(),
              serviceRequestId: serviceRequestModel.id.toString(),
              token: serviceRequestModel.driver?.fcmtoken ?? '',
            );
          },
          onChangeDriverTap: () {
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            appBloc.setSelectedServiceRequestModel(model: serviceRequestModel);

            showPrimaryPopUp(
              context: context,
              title: 'Force Change Driver',
              popUpBody: DriverSelectionBodyPopup(
                carServiceTypes: serviceRequestModel.carServiceTypes?.map((e) => e.carType!).toList() ?? [],
              ),
            );
          },
          isRunning: appBloc.getRunningStatus(serviceRequestModel.status ?? ''),
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
          onCloseWithPaymentTap: () {
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            showPrimaryPopUp(
              context: context,
              popUpBody: CancelWithPaymentPopupBody(
                context: context,
              ),
            );
          },
          onChangeStatus: () {
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            showPrimaryPopUp(
              context: context,
              popUpBody: ChangeStatusPopupBody(
                context: context,
              ),
            );
          },
          showRefuseCancelReq: ((serviceRequestModel.reject ?? false) && serviceRequestModel.isRequestActive),
          onRefuseCancelReq: () {
            appBloc.refuseRequestReject(requestId: serviceRequestModel.id.toString());
          },
          showApproveCancelReq: ((serviceRequestModel.reject ?? false) && serviceRequestModel.isRequestActive),
          onApproveCancelReq: () {
            appBloc.approveReqCancel(requestId: serviceRequestModel.id.toString());
          },
          onChangePayment: () {
            appBloc.setSelectedServiceRequestId(id: serviceRequestModel.id, isForActiveService: false);
            appBloc.setAvailablePaymentsForCorporates(
              isCash: true,
              isDeferredPayment: true,
              isCardToDriver: true,
              isOnline: false,
              isOnlineLink: true,
            );
            showPrimaryPopUp(
              context: context,
              popUpBody: ChangePaymentPopupBody(
                context: context,
              ),
            );
          },
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
