import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/package_users_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_icon_item.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import '../../packages/view_excel_data_screen.dart';
import '../../packages/widgets/user_details_screen.dart';

class CorporatePackagesTable extends StatefulWidget {
  const CorporatePackagesTable({super.key});

  @override
  State<CorporatePackagesTable> createState() => _CorporatePackagesTableState();
}

class _CorporatePackagesTableState extends State<CorporatePackagesTable> {
  // pagination logic

  List<TableRow> packagesClientsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          client: element,
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
        ],
        columnsTitles: ['ID', 'Name', 'Phone number', 'Created at', 'Details'],
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
        if (state is GetPackageCustomizationSuccessState) {
          if (state.exportSheetAfterSuccess) {
            appBloc.exportExcelTemplate();
          }
        }
        if (state is ImportExcelFileSuccessState) {
          if (appBloc.packageCustomizationList.isEmpty) {
            HelpooInAppNotification.showErrorMessage(message: 'Please export non empty excel file');
          } else {
            ///* navigate to View Excel Data Screen to show the imported data then upload it
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: const ViewExcelDataScreen(),
            );
          }

          // appBloc.selectedPackageId = appBloc.allPackages[0].id!;
          // appBloc.addUsersToPackage();
        }
      },
      builder: (context, state) {
        if (appBloc.packageUsersModel?.clients?.isEmpty ?? true) {
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
                        Text(
                          'Package Users',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 300,
                          child: PrimaryButton(
                            text: 'Export Excel Template',
                            onPressed: () {
                              // appBloc.selectedPackageId = appBloc.allPackages[0].id!;
                              appBloc.getPackageCustomization();
                            },
                          ),
                        ),
                        space10Horizontal(),
                        SizedBox(
                          width: 300,
                          child: PrimaryButton(
                            text: 'Import Excel Template',
                            onPressed: () {
                              appBloc.importExcelFile();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 7.5 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                      2: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                      3: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 7.5 * appBloc.widgetWidth),
                    },
                    tableRows: packagesClientsTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.packageUsersModel?.clients ?? [],
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
    required Clients client,
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
          text: client.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: client.client?.user?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: client.client?.user?.phoneNumber ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: client.createdAt ?? '',
          isCentered: true,
        ),
        TableIconItem(
          onTap: () {
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              isAdd: true,
              widget: UserDetailsScreen(client: client),
            );
          },
          icon: Icons.remove_red_eye_outlined,
        )
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
          space50Vertical(),
          if (appBloc.allPackages.isNotEmpty)
            SizedBox(
              width: appBloc.getWidgetWidth(),
              child: Row(
                children: [
                  Text(
                    'Package Users',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 300,
                    child: PrimaryButton(
                      text: 'Export Excel Template',
                      onPressed: () {
                        // appBloc.selectedPackageId = appBloc.allPackages[0].id!;
                        appBloc.getPackageCustomization();
                      },
                    ),
                  ),
                  space10Horizontal(),
                  SizedBox(
                    width: 300,
                    child: PrimaryButton(
                      text: 'Import Excel Template',
                      onPressed: () {
                        appBloc.importExcelFile();
                      },
                    ),
                  ),
                ],
              ),
            ),
          const Spacer(),
          Text(
            appBloc.allPackages.isNotEmpty ? 'There is no users yet' : 'There is no packages yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
