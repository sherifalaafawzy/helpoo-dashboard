import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/models/vehicles/vehicles_statistics_model.dart';
import '../../../../../core/util/constants.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/cubit/state.dart';
import '../../../../../core/util/widgets/primary_padding.dart';
import '../../../../../core/util/widgets/tables/components/table_header.dart';
import '../../../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../../../core/util/widgets/tables/table_widget.dart';

class OnlineVehiclesStatisticsTable extends StatefulWidget {
  const OnlineVehiclesStatisticsTable({super.key});

  @override
  State<OnlineVehiclesStatisticsTable> createState() =>
      _OnlineVehiclesStatisticsTableState();
}

class _OnlineVehiclesStatisticsTableState
    extends State<OnlineVehiclesStatisticsTable> {
  // pagination logic

  List<TableRow> vehiclesTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          vehiclesRows: element,
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
        columnsTitles: [
          'ID',
          'Vehicle Number',
          'Phone Number',
          'Available',
          'Created At',
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
        if (appBloc.onlineVehicles?.rows?.isEmpty ?? true) {
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
                          'Online Vehicles Statistics',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  PrimaryTableWidget(
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 7.5 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                      2: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1 / 7.5 * appBloc.widgetWidth),
                      4: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                    },
                    tableRows: vehiclesTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.onlineVehicles?.rows ?? [],
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
    required VehiclesRows vehiclesRows,
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
          text: vehiclesRows.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: vehiclesRows.vecNum?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: vehiclesRows.phoneNumber?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: vehiclesRows.available?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: vehiclesRows.createdAt ?? '',
          isCentered: true,
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
            'There is no Vehicles yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
