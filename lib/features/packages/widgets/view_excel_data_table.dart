import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/package_bulk_user_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';

class ViewExcelDataTable extends StatefulWidget {
  const ViewExcelDataTable({super.key});

  @override
  State<ViewExcelDataTable> createState() => _ViewExcelDataTableState();
}

class _ViewExcelDataTableState extends State<ViewExcelDataTable> {
  List<TableRow> packagesClientsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          user: element,
        ),
      );
    }

    tableRows.insert(
      0,
      TablesHeader.tableHeader(
        context: context,
        // packageCustomizationList all it's indexes are centerd
        centeredIndexes: [],
        columnsTitles: appBloc.packageCustomizationList.first
            .toJson()
            .keys
            .where((element) => element != 'error')
            .toList()
            .map(
              (e) => e.toString().toLowerCase(),
            )
            .toList(),
      ),
    );

    return tableRows;
  }

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    appBloc.itemsSubList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AddUsersToPackageCallDone) {
          AppBloc.get(context).changeStackNav(
            index: appBloc.currentSideMenuIndex,
            isAdd: false,
          );
        }
      },
      builder: (context, state) {
        if (appBloc.packageCustomizationList.isEmpty) {
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
                            text: 'Upload Data',
                            isLoading: appBloc.isAddUsersToPackageLoading,
                            onPressed: () {
                              appBloc.addUsersToPackage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      for (var i = 0;
                          i <
                              appBloc.packageCustomizationList.first
                                  .toJson()
                                  .keys
                                  .where((element) => element != 'error')
                                  .toList()
                                  .length;
                          i++)
                        i: FixedColumnWidth(
                          2 /
                              (appBloc.packageCustomizationList.first
                                      .toJson()
                                      .keys
                                      .where((element) => element != 'error')
                                      .toList()
                                      .length *
                                  2) *
                              appBloc.widgetWidth,
                        ),
                    },
                    tableRows: packagesClientsTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.packageCustomizationList,
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
    required PackageBulkUserModel user,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderGrey,
          ),
        ),
      ),
      children: [
        ...List.generate(
            appBloc.packageCustomizationList.first.toJson().keys.where((element) => element != 'error').toList().length,
            (index) {
          return TableTextItem(
            text: user.toJson().values.toList()[index].toString(),
            isCentered: true,
          );
        }),
        // TableTextItem(
        //   text: user.phoneNumber ?? '',
        //   isCentered: true,
        // ),
        // TableTextItem(
        //   text: user.name ?? '',
        //   isCentered: true,
        // ),
        // TableTextItem(
        //   text: user.carBrand ?? '',
        //   isCentered: true,
        // ),
        // TableTextItem(
        //   text: user.carModel ?? '',
        //   isCentered: true,
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
          space50Vertical(),
          const Spacer(),
          Text(
            'Please Import non empty excel file',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
