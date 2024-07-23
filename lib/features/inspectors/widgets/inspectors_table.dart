import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/inspections/inspectors_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'package:hexcolor/hexcolor.dart';

class InspectorsTable extends StatefulWidget {
  const InspectorsTable({super.key});

  @override
  State<InspectorsTable> createState() => _InspectorsTableState();
}

class _InspectorsTableState extends State<InspectorsTable> {
  // pagination logic

  List<TableRow> inspectorsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(tableItem(inspector: element));
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
          'Phone Number',
          'Email',
          // 'Insurance Company',
        ],
      ),
    );

    return tableRows;
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();
    // here i clear the list to avoid duplication in pagination
    appBloc.itemsSubList = [];
    Future.delayed(const Duration(milliseconds: 300), () {}).then(
      (value) => setState(
        () {
          loading = false;
        },
      ),
    );
  }

  GlobalKey itemsPerPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (appBloc.inspectors.isEmpty && !loading) {
      return emptyCase();
    }
    return loading
        ? Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          )
        : BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return PrimaryPadding(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          //     'Name',
                          //     'Phone Number',
                          //     'Email',
                          //     // 'Insurance Company',
                          //   ],
                          // ),

                          columnWidths: {
                            0: FixedColumnWidth(0.5 / 5 * appBloc.widgetWidth),
                            1: FixedColumnWidth(1.5 / 5 * appBloc.widgetWidth),
                            2: FixedColumnWidth(1.5 / 5 * appBloc.widgetWidth),
                            3: FixedColumnWidth(1.5 / 5 * appBloc.widgetWidth),
                          },
                          tableRows: inspectorsTableRows(),
                          paginationWidget: TablePaginationBar(
                            items: appBloc.inspectors,
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
    required Inspector inspector,
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
          text: inspector.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: inspector.user?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: inspector.phoneNumbers?[0] ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: inspector.emails?[0] ?? '',
          isCentered: true,
        ),
        // TableTextItem(
        //   text: inspector.insuranceCompany?.arName ?? '',
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
          space40Vertical(),
          Text(
            'There is no Inspectors yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space40Vertical(),
        ],
      ),
    );
  }
}
