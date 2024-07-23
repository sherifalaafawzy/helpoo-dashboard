import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/policy_model.dart';
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

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  // pagination logic

  List<TableRow> insuranceTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(tableItem(
        policyModel: element,
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
                          'Policies',
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
                    tableRows: insuranceTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: appBloc.policiesModel!.cars,
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
    PolicyModel? policyModel,
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
          text: policyModel!.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: DateFormat('dd MMM yyyy').format(policyModel.createdAt),
          isCentered: true,
        ),
        TableTextItem(
          text: policyModel.plateNumber,
          isCentered: true,
        ),
        TableTextItem(
          text: policyModel.carModel?.arName ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: policyModel.client?.user?.name ?? '',
          isCentered: true,
        ),
      ],
    );
  }

//
}

// Expanded(
//   child: Container(
//     width: 1122,
//     height: double.infinity,
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(
//         color: borderGrey,
//       ),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           color: borderGrey,
//           child: PrimaryPadding(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Id',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     'Date',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     'Plate Number',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     'Car Model',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     'Name',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ...appBloc.policiesModel!.cars
//                     .map((e) => Column(
//                           children: [
//                             PrimaryPadding(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       e.id.toString(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleMedium,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       DateFormat('dd MMM yyyy')
//                                           .format(e.createdAt),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleMedium,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       e.plateNumber,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleMedium,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       '${e.manufacturer != null ? e.manufacturer!.enName : ''} ${e.carModel != null ? e.carModel!.enName : ''} ${e.year}',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleMedium,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       e.client != null
//                                           ? e.client!.user!.name
//                                           : '',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleMedium,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // if (appBloc.policiesModel!.cars
//                             //         .indexOf(e) !=
//                             //     appBloc.policiesModel!.cars
//                             //             .length -
//                             //         1)
//                             //   const MyDivider(),
//                           ],
//                         ))
//                     .toList(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
