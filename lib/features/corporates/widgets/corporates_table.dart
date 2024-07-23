import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/corporates/corporates_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import '../../corporate_users/corporate_users_screen.dart';
import '../corporate_service_req_page.dart';
import 'corporate_action_widget.dart';
import 'corporate_details_widget.dart';
import 'create_new_corporate_popup_body.dart';
import '../../service_requests/create_new_service_request.dart';

class CorporatesTable extends StatefulWidget {
  const CorporatesTable({super.key});

  @override
  State<CorporatesTable> createState() => _CorporatesTableState();
}

class _CorporatesTableState extends State<CorporatesTable> {
  // pagination logic

  List<TableRow> usersTableRows() {
    List<TableRow> tableRows = [];
    for (var element in AppBloc.get(context).itemsSubList) {
      tableRows.add(tableItem(
        corporateModel: element,
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
        ],
        columnsTitles: [
          'ID',
          'Name',
          'Discount',
          'Created At',
          'Actions',
        ],
      ),
    );

    return tableRows;
  }

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.itemsSubList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (appBloc.corporatesModel?.rows?.isEmpty ?? true) {
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
                          'Corporates',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        if (userRoleName == Rules.Admin.name ||
                            userRoleName == Rules.Super.name) ...[
                          SizedBox(
                            width: 300,
                            child: PrimaryButton(
                              text: 'Create New Corporate',
                              onPressed: () {
                                showPrimaryPopUp(
                                  context: context,
                                  isDismissible: false,
                                  title: 'Create New Corporate',
                                  popUpBody:
                                      const CreateNewCorporateBodyPopup(),
                                );
                              },
                            ),
                          ),
                        ] else ...[
                          const SizedBox.shrink(),
                        ],
                      ],
                    ),
                  ),
                  space20Vertical(),
                  SizedBox(
                    width: appBloc.getWidgetWidth(),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryFormField(
                            validationError: '',
                            label: 'Search by Name',
                            controller: appBloc.searchCorporatesController,
                          ),
                        ),
                        space10Horizontal(),
                        InkWell(
                          onTap: () {
                            appBloc.searchCorporates(
                              appBloc.searchCorporatesController.text,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 10),
                            child: Text(
                              'Search',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        space10Horizontal(),
                        InkWell(
                          onTap: () {
                            appBloc.searchCorporatesController.clear();
                            appBloc.searchCorporates('');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 10),
                            child: Text(
                              'Clear',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 6 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 6 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1 / 6 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1.6 / 6 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 6 * appBloc.widgetWidth),
                    },
                    tableRows: usersTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.isSearchingCorporates
                          ? appBloc.searchedCorporatesList
                          : appBloc.corporatesModel?.rows ?? [],
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
    required Rows corporateModel,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: borderGrey,
        ),
      )),
      children: [
        TableTextItem(
          text: corporateModel.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: corporateModel.enName ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: corporateModel.discountRatio?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: corporateModel.createdAt ?? '',
          isCentered: true,
        ),
        CorporateTableMoreWidget(
          onViewTap: () {
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: CorporateDetails(
                corporateModel: corporateModel,
              ),
            );
          },
          onEditTap: () {
            appBloc.selectedCorporateId = corporateModel.id!;
            appBloc.resetServiceRequestSteps();
            appBloc.setIsNewCustomer(true);
            appBloc.setAvailablePaymentsForCorporates(
              isCash: true,
              isDeferredPayment: true,
              isCardToDriver: true,
              isOnline: false,
              isOnlineLink: false,
            );

            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: const CreateNewServiceRequest(
                isForCorporate: true,
              ),
            );
          },
          onRequestsTap: () {
            appBloc.selectedCorporateId = corporateModel.id!;
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: const CorporateServiceRequestPage(),
            );
          },
          onUsersTap: () {
            appBloc.selectedCorporateId = corporateModel.id!;
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: const CorporateUsersScreen(),
            );
          },
        ),
        // TableIconItem(
        //   onTap: () {
        //     appBloc.selectedCorporateId = corporateModel.id!;
        //     appBloc.resetServiceRequestSteps();
        //     appBloc.setIsNewCustomer(true);
        //     appBloc.setAvailablePaymentsForCorporates(
        //       isCash: true,
        //       isDeferredPayment: true,
        //       isCardToDriver: true,
        //       isOnline: false,
        //     );

        //     appBloc.changeStackNav(
        //       index: appBloc.currentSideMenuIndex,
        //       isAdd: true,
        //       widget: const CreateNewServiceRequest(
        //         isForCorporate: true,
        //       ),
        //     );
        //   },
        //   icon: Icons.create,
        // ),
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
          const Spacer(),
          Text(
            'There Is No Corporates Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space20Vertical(),
          SizedBox(
            width: 300,
            child: PrimaryButton(
              text: 'Create New User',
              onPressed: () {
                showPrimaryPopUp(
                  context: context,
                  isDismissible: false,
                  title: 'Create New User',
                  popUpBody: const CreateNewCorporateBodyPopup(),
                );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
