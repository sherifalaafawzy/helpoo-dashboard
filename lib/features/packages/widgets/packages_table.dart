import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/package_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/loading_popup.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/package_table_more_widget.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'create_package_screen.dart';
import 'package_details_screen.dart';
import 'packages_users/packages_clients_table.dart';
import 'packages_users/packages_promo_codes_clients_table.dart';

class PackagesTable extends StatefulWidget {
  const PackagesTable({super.key});

  @override
  State<PackagesTable> createState() => _PackagesTableState();
}

class _PackagesTableState extends State<PackagesTable> {
  // pagination logic

  List<TableRow> packagesTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          packageModel: element,
        ),
      );
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
        ],
        columnsTitles: [
          'ID',
          'Name',
          'fees',
          'number of cars',
          'number of days',
          'active',
          'Created At',
          'Corporate',
          'Insurance',
          'Broker',
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
      listener: (context, state) {
        if (state is GetPackageUsersSuccessState) {
          context.pop;
          appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex, isAdd: true, widget: const PackagesClientsTable());
        }
        if (state is GetPackageUsersLoadingState) {
          showPrimaryPopUp(
            context: context,
            isDismissible: false,
            title: 'Show Loading',
            popUpBody: const LoadingPopup(),
          );
        }

        if (state is GetPackageUsersErrorState) {
          context.pop;
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }

        if (state is GetPromoCodeUsersSuccessState) {
          context.pop;
          appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex, isAdd: true, widget: const PackagesPromoCodesClientsTable());
        }

        if (state is GetPromoCodeUsersLoadingState) {
          showPrimaryPopUp(
            context: context,
            isDismissible: false,
            title: 'Show Loading',
            popUpBody: const LoadingPopup(),
          );
        }

        if (state is GetPromoCodeUsersErrorState) {
          context.pop;
          HelpooInAppNotification.showErrorMessage(message: state.error);
        }
      },
      builder: (context, state) {
        if (appBloc.allPackages.isEmpty) {
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
                          'Packages',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 300,
                          child: PrimaryButton(
                            text: 'Create New Package',
                            onPressed: () {
                              appBloc.changeStackNav(
                                index: appBloc.currentSideMenuIndex,
                                isAdd: true,
                                widget: const CreatePackageScreen(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 16 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 16 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1 / 16 * appBloc.widgetWidth),
                      3: FixedColumnWidth(2 / 16 * appBloc.widgetWidth),
                      4: FixedColumnWidth(2 / 16 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 16 * appBloc.widgetWidth),
                      6: FixedColumnWidth(2 / 16 * appBloc.widgetWidth),
                      7: FixedColumnWidth(1.5 / 16 * appBloc.widgetWidth),
                      8: FixedColumnWidth(1.5 / 16 * appBloc.widgetWidth),
                      9: FixedColumnWidth(1.5 / 16 * appBloc.widgetWidth),
                      10: FixedColumnWidth(1 / 16 * appBloc.widgetWidth),
                    },
                    tableRows: packagesTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.allPackages,
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
    required PackageModel packageModel,
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
          text: packageModel.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.enName ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.fees?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.numberOfCars?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.numberOfDays?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: (packageModel.active ?? false) ? 'Active' : 'Not Active',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.createdAt ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.corporateCompany?.enName ?? '---',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.insuranceCompany?.enName ?? '---',
          isCentered: true,
        ),
        TableTextItem(
          text: packageModel.broker?.user?.name ?? '---',
          isCentered: true,
        ),
        PackageTableMoreWidget(
          onViewTap: () {
            appBloc.changeStackNav(
                index: appBloc.currentSideMenuIndex,
                isAdd: true,
                widget: PackageDetailsScreen(
                  packageModel: packageModel,
                ));
          },
          onUsersTap: () {
            appBloc.selectedPackageId = packageModel.id!;
            appBloc.getPackageUsers();
          },
          onPromoCodesUsersTap: () {
            appBloc.selectedPackageId = packageModel.id!;
            appBloc.selectedPromoName = null;
            appBloc.getPromoCodeUsers();
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
          const Spacer(),
          Text(
            'There is no packages yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space20Vertical(),
          SizedBox(
            width: 300,
            child: PrimaryButton(
              text: 'Create New Package',
              onPressed: () {
                appBloc.changeStackNav(
                  index: appBloc.currentSideMenuIndex,
                  isAdd: true,
                  widget: const CreatePackageScreen(),
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
