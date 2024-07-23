import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/vehicles/vehicles_model.dart';
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
import 'create_new_vehicle.dart';

class VehiclesTable extends StatefulWidget {
  const VehiclesTable({super.key});

  @override
  State<VehiclesTable> createState() => _VehiclesTableState();
}

class _VehiclesTableState extends State<VehiclesTable> {
  // pagination logic

  List<TableRow> vehiclesTableRows() {
    List<TableRow> tableRows = [];
    for (var element in AppBloc.get(context).itemsSubList) {
      tableRows.add(tableItem(
        vehicle: element,
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
        ],
        columnsTitles: [
          'ID',
          'Vehicle Plate',
          'Vehicle Number',
          'Phone Number',
          'Available',
          'Vehicle Type',
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
        if (appBloc.vehiclesModel?.vehicles?.isEmpty ?? true) {
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
                          'Vehicles',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 300,
                          child: PrimaryButton(
                            text: 'Creat New Vehicle',
                            onPressed: () {
                              showPrimaryPopUp(
                                context: context,
                                isDismissible: false,
                                title: 'Create New Vehicle',
                                popUpBody: const CreateNewVehicleBodyPopup(),
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
                    //     5,
                    //   ],
                    //   columnsTitles: [
                    //     'ID',
                    //     'Vehicle Plate',
                    //     'Vehicle Number',
                    //     'Phone Number',
                    //     'Available',
                    //     'Vehicle Type',
                    //   ],
                    // ),
                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 7.5 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 7.5 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1 / 7.5 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1.5 / 7.5 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1.5 / 7.5 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 7.5 * appBloc.widgetWidth),
                    },
                    tableRows: vehiclesTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.vehiclesModel?.vehicles ?? [],
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
    required Vehicles vehicle,
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
          text: vehicle.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: vehicle.vecPlate ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: vehicle.vecNum?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: vehicle.phoneNumber?.toString() ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: vehicle.available?.toString() ?? 'false',
          isCentered: true,
        ),
        TableTextItem(
          text: vehicle.vecType == 5 ? 'European' : 'Normal',
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
          space40Vertical(),
          Text(
            'There Is No Vehicles',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space40Vertical(),
          SizedBox(
            width: 300,
            child: PrimaryButton(
              text: 'Create New Vehicle',
              onPressed: () {
                showPrimaryPopUp(
                  context: context,
                  isDismissible: false,
                  title: 'Create New Vehicle',
                  popUpBody: const CreateNewVehicleBodyPopup(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
