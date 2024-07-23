
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/service_request/get_all.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/loading_popup.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_more_widget.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import '../../service_requests/widgets/service_req_detailes.dart';
import '../../service_requests/widgets/steps/location.dart';
import '../../service_requests/create_new_service_request.dart';

class CorporateSrTable extends StatefulWidget {
  const CorporateSrTable({super.key});

  @override
  State<CorporateSrTable> createState() => _CorporateSrTableState();
}

class _CorporateSrTableState extends State<CorporateSrTable> {
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
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Date',
          'Payment/Status',
          'Amount',
          'Driver',
          'Status',
          'Corporate Company',
          '',
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
  }

  @override
  void dispose() {
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
        if (appBloc.corporateSr?.requests?.isEmpty ?? true) {
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
                        const BackButtonWidget(),
                        space10Horizontal(),
                        Text(
                          appTranslation(context).serviceRequests,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  space40Vertical(),Text("total pages "+appBloc.corporateSr!.totalPages.toString()),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 12 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 12 * appBloc.widgetWidth),
                      2: FixedColumnWidth(2 / 12 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1.5 / 12 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1 / 12 * appBloc.widgetWidth),
                      7: FixedColumnWidth(2 / 12 * appBloc.widgetWidth),
                      8: FixedColumnWidth(0.5 / 12 * appBloc.widgetWidth),
                      9: FixedColumnWidth(0.5 / 12 * appBloc.widgetWidth),
                    },
                    tableRows: inspectorsTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.corporateSr?.requests ?? [],
                      pages: appBloc.corporateSr!.totalPages ?? 1,
                        // isLoading: appBloc.getServiceRequestsLoadingForPagination,
                        onCallAnotherPage: (int page) {
                          appBloc.currentServiceRequestPage = page;
                          if (!appBloc.isSearchingServiceRequest) {
                            appBloc.getCorporateServiceRequests(pageNumber: page);
                          }
                        }
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
          text: serviceRequestModel.client?.user?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: serviceRequestModel.createdAt ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text:
              '${serviceRequestModel.paymentMethod ?? ''}/${serviceRequestModel.paymentStatus ?? ''}',
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
        TableTextItem(
          text: '${serviceRequestModel.corporateCompany?.enName ?? '---'} \n${serviceRequestModel.branch?.name ?? ''}',
          isCentered: true,
          maxLines: 2,
        ),
        const TableTextItem(
          text: '',
          isCentered: true,
        ),
        TableMoreWidget(
          shareTrackingLinkTabVisible: false,
          trackTabVisible: false,
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
          onTripTap: () {},
          onLinkTap: () {},
          onWaitingTimeTap: () {},
          onCommentTap: () {},
          onChangeDriverTap: () {},
          onAutoChangeDriverTap: () {},
          isOpenFromCorporate: true,
          onCloseTap: () {},
          isRunning: false,
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
