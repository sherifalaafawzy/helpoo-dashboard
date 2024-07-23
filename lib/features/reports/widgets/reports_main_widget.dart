import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import 'report_column_item.dart';
import 'reports_table_main_widget.dart';
import 'save_columns_popup_body.dart';
import 'select_date_popup_body.dart';
import 'package:hexcolor/hexcolor.dart';

class ReportsMainWidget extends StatefulWidget {
  const ReportsMainWidget({super.key});

  @override
  State<ReportsMainWidget> createState() => _ReportsMainWidgetState();
}

class _ReportsMainWidgetState extends State<ReportsMainWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userRoleName == Rules.Corporate.name) {
      appBloc.selectedReportsFilterOption = 'Specific Corporate';
    }
  }

  final GlobalKey filterDropdownKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (appBloc.isGetServiceRequestReportsLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: 1122,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: borderGrey,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (userRoleName != Rules.Corporate.name) ...{
                            InkWell(
                                key: filterDropdownKey,
                                onTap: () {
                                  showPrimaryMenu(
                                      context: context,
                                      key: filterDropdownKey,
                                      items: [
                                        ...appBloc.reportsFilterOptions.map(
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
                                              appBloc.selectedReportsFilterOption =
                                                  e;
                                            },
                                          ),
                                        )
                                      ]);
                                },
                                child: Container(
                                  height: 45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: HexColor(mainColor),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'Filter By:  ${appBloc.selectedReportsFilterOption}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                )),
                            if (appBloc.isFilterBySpecificCorporate) ...{
                              space10Horizontal(),
                              Expanded(
                                child: SizedBox(
                                  height: 45,
                                  child: PrimaryFormField(
                                    validationError: '',
                                    isValidate: false,
                                    controller:
                                        appBloc.corporateSearchController,
                                    onChange: (value) {
                                      appBloc.emptyStateToRebuild();
                                    },
                                    label: 'Search by Corporate Name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: 150,
                                  height: 45,
                                  child: PrimaryButton(
                                    text: 'Submit',
                                    isLoading: appBloc.isCorporateSearchLoading,
                                    onPressed: () {
                                      appBloc.searchCorporate();
                                    },
                                  ),
                                ),
                              ),
                            },
                            if (appBloc.isFilterBySpecificClient) ...{
                              space10Horizontal(),
                              Expanded(
                                child: PrimaryFormField(
                                  validationError: '',
                                  label: 'Phone Number',
                                  controller: appBloc
                                      .searchForExistingCustomerController,
                                  onChange: (value) {
                                    appBloc.emptyStateToRebuild();
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: 150,
                                  height: 45,
                                  child: PrimaryButton(
                                    text: 'Submit',
                                    isDisabled: appBloc
                                            .searchForExistingCustomerController
                                            .text
                                            .length <
                                        10,
                                    isLoading: State
                                        is SearchForExistingCustomerLoadingState,
                                    onPressed: () {
                                      appBloc.searchForExistingCustomer();
                                    },
                                  ),
                                ),
                              ),
                            },
                            if (appBloc.isFilterOff ||
                                appBloc.isFilterByAllClients ||
                                appBloc.isFilterByAllCorporates)
                              const Spacer(),
                          },
                          if (userRoleName == Rules.Corporate.name) ...{
                            const Spacer(),
                          },
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: PrimaryButton(
                              text: 'Select Dates',
                              onPressed: () {
                                appBloc.getFilterTypeAndValue();
                                showPrimaryPopUp(
                                    context: context,
                                    isDismissible: false,
                                    popUpBody: const SelectDatePopupBody());
                              },
                            ),
                          ),
                        ],
                      ),
                      if (appBloc.customerSearchModel != null ||
                          appBloc.corporateSearchModel != null)
                        space24Vertical(),

                      // client search result
                      if (appBloc.customerSearchModel != null &&
                          appBloc.isFilterBySpecificClient &&
                          appBloc.searchForExistingCustomerController.text
                              .isNotEmpty)
                        Center(
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('User Name: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.black)),
                                    Text(
                                        appBloc
                                            .customerSearchModel!.user!.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      // coprporate search result
                      if (appBloc.corporateSearchModel != null &&
                          appBloc.isFilterBySpecificCorporate &&
                          appBloc.corporateSearchController.text.isNotEmpty)
                        Center(
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: appBloc
                                  .corporateSearchModel!.corporates!
                                  .map(
                                    (e) => Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            debugPrint('e.mainText');
                                            appBloc.selectedCorporate = e;
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: appBloc.selectedCorporate !=
                                                          null &&
                                                      appBloc.selectedCorporate!
                                                              .id ==
                                                          e.id
                                                  ? HexColor(mainColor)
                                                      .withOpacity(0.5)
                                                  : Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.enName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                  Text(
                                                    e.arName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                          fontSize: 12.0,
                                                          color: secondaryGrey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      space10Vertical(),
                      const Divider(
                        color: Colors.grey,
                      ),
                      space10Vertical(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Reports Count: ${appBloc.allReportsModel?.requests?.length ?? 0}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              space5Vertical(),
                              Text(
                                'Done Reports Count: ${appBloc.getAllDoneReportsModel().length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              if (appBloc.allReportsModel != null &&
                                  appBloc.allReportsModel!.requests!
                                      .isNotEmpty) ...[
                                SizedBox(
                                  width: 150,
                                  child: PrimaryButton(
                                    text: 'View All',
                                    isDisabled:
                                        appBloc.allReportsModel == null ||
                                            appBloc.allReportsModel!.requests!
                                                .isEmpty,
                                    onPressed: () {
                                      appBloc.isDoneReportsOnly = false;
                                      appBloc.changeStackNav(
                                        index: appBloc.currentSideMenuIndex,
                                        isAdd: true,
                                        widget: const ReportsTableMainWidget(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              space5Vertical(),
                              if (appBloc
                                  .getAllDoneReportsModel()
                                  .isNotEmpty) ...[
                                SizedBox(
                                  width: 150,
                                  child: PrimaryButton(
                                    text: 'View Done',
                                    isDisabled:
                                        appBloc.allReportsModel == null ||
                                            appBloc.allReportsModel!.requests!
                                                .isEmpty,
                                    onPressed: () {
                                      appBloc.isDoneReportsOnly = true;
                                      appBloc.changeStackNav(
                                        index: appBloc.currentSideMenuIndex,
                                        isAdd: true,
                                        widget: const ReportsTableMainWidget(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      space20Vertical(),
                      Row(
                        children: [
                          Expanded(
                              child: PrimaryButton(
                            text: 'Export All',
                            isDisabled: appBloc.allReportsModel == null || appBloc.allReportsModel!.requests!.isEmpty,
                            onPressed: () {
                              appBloc.allReportsModel!.requests!.sort((a, b) => b.id!.compareTo(a.id!));
                              for (var element in appBloc.allReportsModel!.requests!) {
                                List<String> row = [
                                  if (appBloc.isColumnExist('ID'))
                                    element.id?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Created At'))
                                    element.createdAt ?? '',
                                  if (appBloc.isColumnExist('Client Name'))
                                    element.name ?? '---',
                                  if (appBloc.isColumnExist('Mobile'))
                                    element.phoneNumber ?? '---',
                                  if (appBloc.isColumnExist('Driver Name'))
                                    element.driver?.user?.name ?? '---',
                                  if (appBloc.isColumnExist('Status'))
                                    element.status ?? '---',
                                  if (appBloc.isColumnExist('Type'))
                                    appBloc.getRoleNameBasedOnRoleId(
                                        element.user?.roleId ?? 11),
                                  if (appBloc.isColumnExist('Payment Status'))
                                    element.paymentStatus ?? '---',
                                  if (appBloc.isColumnExist('Payment Method'))
                                    element.paymentMethod ?? '---',
                                  if (appBloc.isColumnExist('Client Type'))
                                    'Client',
                                  if (appBloc.isColumnExist('Original Fees'))
                                    element.originalFees!.toString(),
                                  if (appBloc.isColumnExist('Fees'))
                                    element.fees!.toString(),
                                  if (appBloc.isColumnExist('Discount Cost'))
                                    '${element.originalFees! - element.fees!} EGP',
                                  if (appBloc.isColumnExist('Discount Rate'))
                                    '${appBloc.getHighestDiscount([
                                          element.adminDiscount!,
                                          element.discountPercentage!,
                                        ])} %',
                                  if (appBloc.isColumnExist('From'))
                                    element.clientAddress ?? '---',
                                  if (appBloc.isColumnExist('To'))
                                    element.destinationAddress ??
                                        '---',
                                  if (appBloc.isColumnExist('Discount Reason'))
                                    element.adminDiscountReason ?? '---',
                                  if (appBloc
                                      .isColumnExist('Discount Approver'))
                                    element.adminDiscountApprovedBy ?? '---',
                                  if (appBloc.isColumnExist('Waiting Time'))
                                    element.waitingTime?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Waiting Cost'))
                                    element.waitingFees?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Car Brand'))
                                    appBloc.getCarBrand(
                                        element.car?.manufacturerId ?? 0),
                                  if (appBloc.isColumnExist('Car Model'))
                                    appBloc.getCarModel(
                                        element.car?.carModelId ?? 0),
                                  if (appBloc.isColumnExist('Car Color'))
                                    element.car?.color ?? '---',
                                  if (appBloc.isColumnExist('Car Plate'))
                                    element.car?.plateNumber ?? '---',
                                  if (appBloc.isColumnExist('Car Year'))
                                    element.car?.year?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Corporate Company'))
                                    '${element.corporateCompany?.enName ?? '---'} \n${element.branch?.name ?? ''}',
                                  if (appBloc.isColumnExist('Winch number'))
                                    element.vehicle?.VecPlate ?? '---',
                                    element.vehicle?.VecNum.toString() ?? '---',
                                  if (appBloc.isColumnExist('comment'))
                                    element.adminComment ?? '---',
                                  if (appBloc.isColumnExist('Created By'))
                                    element.user?.name ?? '',
                                  if (appBloc.isColumnExist('Created By Role'))
                                    appBloc.getRoleNameBasedOnRoleId(
                                        element.user?.roleId ?? 5),
                                  if (appBloc.isColumnExist('Package Name'))
                                    element.clientPackage?.package?.arName ??
                                        '---',
                                  if (appBloc.isColumnExist('Vin Number'))
                                    element.car?.vinNumber ?? '---',
                                ];
                                appBloc.addNewExcelData(row);
                              }
                              appBloc.createExcel();
                            },
                          )),
                          space10Horizontal(),
                          Expanded(
                              child: PrimaryButton(
                            text: 'Export Done Requests',
                            isDisabled:
                                appBloc.getAllDoneReportsModel().isEmpty,
                            onPressed: () {
                              for (var element
                                  in appBloc.getAllDoneReportsModel()) {
                                List<String> row = [
                                  if (appBloc.isColumnExist('ID'))
                                    element.id?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Created At'))
                                    element.createdAt ?? '',
                                  if (appBloc.isColumnExist('Client Name'))
                                    element.name ?? '---',
                                  if (appBloc.isColumnExist('Mobile'))
                                    element.phoneNumber ?? '---',
                                  if (appBloc.isColumnExist('Driver Name'))
                                    element.driver?.user?.name ?? '---',
                                  if (appBloc.isColumnExist('Status'))
                                    element.status ?? '---',
                                  if (appBloc.isColumnExist('Type'))
                                    appBloc.getRoleNameBasedOnRoleId(
                                        element.user?.roleId ?? 11),
                                  if (appBloc.isColumnExist('Payment Status'))
                                    element.paymentStatus ?? '---',
                                  if (appBloc.isColumnExist('Payment Method'))
                                    element.paymentMethod ?? '---',
                                  if (appBloc.isColumnExist('Client Type'))
                                    'Client',
                                  if (appBloc.isColumnExist('Original Fees'))
                                    element.originalFees!.toString(),
                                  if (appBloc.isColumnExist('Fees'))
                                    element.fees!.toString(),
                                  if (appBloc.isColumnExist('Discount Cost'))
                                    '${element.originalFees! - element.fees!} EGP',
                                  if (appBloc.isColumnExist('Discount Rate'))
                                    '${appBloc.getHighestDiscount([
                                          element.adminDiscount!,
                                          element.discountPercentage!,
                                        ])} %',
                                  if (appBloc.isColumnExist('From'))
                                    element.location?.clientAddress ?? '---',
                                  if (appBloc.isColumnExist('To'))
                                    element.location?.destinationAddress ??
                                        '---',
                                  if (appBloc.isColumnExist('Discount Reason'))
                                    element.adminDiscountReason ?? '---',
                                  if (appBloc
                                      .isColumnExist('Discount Approver'))
                                    element.adminDiscountApprovedBy ?? '---',
                                  if (appBloc.isColumnExist('Waiting Time'))
                                    element.waitingTime?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Waiting Cost'))
                                    element.waitingFees?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Car Brand'))
                                    appBloc.getCarBrand(
                                        element.car?.manufacturerId ?? 0),
                                  if (appBloc.isColumnExist('Car Model'))
                                    appBloc.getCarModel(
                                        element.car?.carModelId ?? 0),
                                  if (appBloc.isColumnExist('Car Color'))
                                    element.car?.color ?? '---',
                                  if (appBloc.isColumnExist('Car Plate'))
                                    element.car?.plateNumber ?? '---',
                                  if (appBloc.isColumnExist('Car Year'))
                                    element.car?.year?.toString() ?? '---',
                                  if (appBloc.isColumnExist('Corporate Company'))
                                    '${element.corporateCompany?.enName ?? '---'} \n${element.branch?.name ?? ''}',
                                  if (appBloc.isColumnExist('Winch number'))
                                    element.vehicle?.VecNum.toString() ?? '---',
                                  if (appBloc.isColumnExist('comment'))
                                    element.adminComment ?? '---',
                                  if (appBloc.isColumnExist('Created By'))
                                    element.user?.name ?? '',
                                  if (appBloc.isColumnExist('Created By Role'))
                                    appBloc.getRoleNameBasedOnRoleId(
                                        element.user?.roleId ?? 5),
                                  if (appBloc.isColumnExist('Package Name'))
                                    element.clientPackage?.package?.arName ??
                                        '---',
                                ];
                                appBloc.addNewExcelData(row);
                              }
                              appBloc.createExcel();
                            },
                          )),
                        ],
                      ),

                      space20Vertical(),
                      Text('Select Excel Sheet Columns',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                  )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // selected columns
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 3,
                              ),
                              shrinkWrap: true,
                              itemCount: appBloc.reportExistingColumns.length,
                              itemBuilder: (context, index) {
                                return ReportColumnItemWidget(
                                  title: appBloc.reportExistingColumns[index],
                                  isSelected: appBloc.isColumnExist(
                                      appBloc.reportExistingColumns[index]),
                                  onTap: () {
                                    appBloc.addNewExcelColumn(
                                        appBloc.reportExistingColumns[index]);
                                  },
                                );
                              },
                            ),
                          ),
                          space20Horizontal(),
                          // fixed columns list
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Fixed Columns',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black)),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 250,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: appBloc.savedColumnsNames.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        appBloc.savedColumnsNames[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.black),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        space10Vertical(),
                                  ),
                                ),
                                space20Vertical(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryButton(
                                        text: 'Add',
                                        onPressed: () {
                                          showPrimaryPopUp(
                                              context: context,
                                              width: 500,
                                              isDismissible: false,
                                              popUpBody:
                                                  const SaveColumnsPopupBody());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
