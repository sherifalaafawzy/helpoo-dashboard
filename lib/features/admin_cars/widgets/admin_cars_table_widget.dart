import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/all_admin_cars.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'package:intl/intl.dart';

class AdminCarsTableWidget extends StatefulWidget {
  final bool isLoading;
  const AdminCarsTableWidget({super.key, required this.isLoading});

  @override
  State<AdminCarsTableWidget> createState() => _AdminCarsTableWidgetState();
}

class _AdminCarsTableWidgetState extends State<AdminCarsTableWidget> {
  // pagination logic

  List<TableRow> adminCarsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(tableItem(adminCarModel: element));
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
          'Date',
          'Plate Number',
          'Car Model',
          'Name',
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.isGetAllAdminCarsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
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
                          'Cars',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 200,
                          child: PrimaryButton(
                            text: appTranslation(context).createNew,
                            onPressed: () {
                              appBloc.clearCreatePolicyData();
                              appBloc.getManufacturers();
                              appBloc.getCarsModels();
                              appBloc.getAllInsuranceCompanies();

                              showCreatePolicyPopUp(
                                context: context,
                                isDismissible: false,
                              );
                            },
                          ),
                        ),
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
                    //   ],
                    //   columnsTitles: [
                    //     'ID',
                    //     'Date',
                    //     'Plate Number',
                    //     'Car Model',
                    //     'Name',
                    //   ],
                    // ),
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 7 * appBloc.widgetWidth),
                      1: FixedColumnWidth(1.5 / 7 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1.5 / 7 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1.5 / 7 * appBloc.widgetWidth),
                      4: FixedColumnWidth(2 / 7 * appBloc.widgetWidth),
                    },
                    tableRows: adminCarsTableRows(),
                    paginationWidget: TablePaginationBar(
                      isLoading: widget.isLoading,
                      items: appBloc.allAdminCarsModel?.cars ?? [],
                      pages: appBloc.allAdminCarsModel!.totalPages!,
                      onCallAnotherPage: (int page) {
                        appBloc.getAllAdminCars(
                          isFirstCall: false,
                          page: page.toString(),
                        );
                      },
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
    required AdminCarModel adminCarModel,
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
        TableTextItem(
          text: adminCarModel.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: DateFormat('dd MMM yyyy')
              .format(DateTime.parse(adminCarModel.createdAt!)),
          isCentered: true,
        ),
        TableTextItem(
          text: adminCarModel.plateNumber!,
          isCentered: true,
        ),
        TableTextItem(
          text: adminCarModel.carModel?.arName ?? '',
          isCentered: true,
        ),
        const TableTextItem(
          text: '',
          isCentered: true,
        ),
      ],
    );
  }

//
}
