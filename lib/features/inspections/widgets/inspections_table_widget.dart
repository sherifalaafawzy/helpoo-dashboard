import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/inspections/inspections.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_icon_item.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'create_inspection.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class InspectionsTableWidget extends StatefulWidget {
  final String title;
  final List<Inspection> inspections;
  final InspectionType inspectionType;

  const InspectionsTableWidget({
    super.key,
    required this.inspections,
    required this.title,
    required this.inspectionType,
  });

  @override
  State<InspectionsTableWidget> createState() => _InspectionsTableWidgetState();
}

class _InspectionsTableWidgetState extends State<InspectionsTableWidget> {
  List<TableRow> inspectionsTableRows() {
    List<TableRow> tableRows = [];
    for (var element in appBloc.itemsSubList) {
      tableRows.add(tableItem(inspection: element));
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
          '#',
          'client Name',
          'Type',
          'Inspector',
          'Governorate',
          'City',
          'Created At',
          'Updated At',
          'Status',
          '',
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (widget.inspections.isEmpty && widget.inspections == appBloc.inspections) {
          return emptyCase(status: InspectionsStatus.all);
        } else if ((widget.inspections.isEmpty &&
            widget.inspections != appBloc.inspections)) {
          return emptyCase(status: InspectionsStatus.pending);
        }

        return PrimaryPadding(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  space20Vertical(),
                  SizedBox(
                    width: appBloc.getWidgetWidth(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 26),
                        ),
                        if (userRoleName != Rules.Inspector.name)
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: PrimaryButton(
                                  text: 'Refresh',
                                  onPressed: () {
                                    if (userRoleName == Rules.Inspector.name) {
                                      appBloc.getInspectionsAsInspector(status: InspectionsStatus.all.name);
                                    } else {
                                      appBloc.getAllInspections(status: InspectionsStatus.all.name);
                                    }
                                  },
                                ),
                              ),
                              space20Horizontal(),
                              SizedBox(
                                width: 200,
                                child: PrimaryButton(
                                  text: appTranslation(context).createInspection,
                                  onPressed: () {
                                    appBloc.clearControllers();
                                    appBloc.inspectionType = widget.inspectionType;
                                    appBloc.changeStackNav(
                                      index: appBloc.currentSideMenuIndex,
                                      isAdd: true,
                                      widget: CreateInspectionWidget(
                                          isUpdate: false,
                                          sideMenuPageIndex:
                                          appBloc.currentSideMenuIndex),
                                    );
                                  },
                                ),
                              ),
                            ],
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
                    //     6,
                    //     7,
                    //   ],
                    //   columnsTitles: [
                    //     '#',
                    //     'client Name',
                    //     'Type',
                    //     'Inspector',
                    //     'Governorate',
                    //     'City',
                    //     'Date',
                    //     'Status',
                    //     '',
                    //   ],
                    // ),

                    columnWidths: {
                      0: FixedColumnWidth(0.3 / 9 * appBloc.widgetWidth),
                      1: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      2: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      7: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      8: FixedColumnWidth(1 / 9 * appBloc.widgetWidth),
                      9: FixedColumnWidth(0.5 / 9 * appBloc.widgetWidth),
                    },
                    tableRows: inspectionsTableRows(),
                    paginationWidget: TablePaginationBar(
                      items: widget.inspections,
                      onCallAnotherPage: (value) {},
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
    required Inspection inspection,
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
          // text: (widget.inspections.indexOf(inspection) + 1).toString(),
          text: (inspection.id).toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: inspection.clientName ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: InspectionType.values
                  .firstWhereOrNull(
                      (element) => element.apiName == inspection.type)
                  ?.arName ??
              '',
          isCentered: true,
        ),
        TableTextItem(
          text: appBloc.inspectors.firstWhereOrNull((element) => element.id == inspection.inspectorId)?.user?.name ?? inspection.inspectionCompany?.name ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: inspection.government ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: inspection.city ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: DateFormat('dd MMM yyyy hh:mm a')
              .format(DateTime.parse(inspection.createdAt!)),
          isCentered: true,
        ),
        TableTextItem(
          text: DateFormat('dd MMM yyyy hh:mm a')
              .format(DateTime.parse(inspection.updatedAt!)),
          isCentered: true,
        ),
        TableTextItem(
          text: inspection.status ?? '',
          isCentered: true,
        ),
        TableIconItem(
          icon: Icons.edit,
          onTap: () {
            appBloc.selectedInspection = inspection;
            appBloc.changeStackNav(
              index: appBloc.currentSideMenuIndex,
              // index: widget.inspections == appBloc.inspections
              //     ? 8
              //     : widget.inspections == appBloc.pendingInspections
              //         ? 9
              //         : 10,
              isAdd: true,
              widget: CreateInspectionWidget(
                isUpdate: true,
                sideMenuPageIndex: appBloc.currentSideMenuIndex,
                // sideMenuPageIndex: widget.inspections == appBloc.inspections
                //     ? 8
                //     : widget.inspections == appBloc.pendingInspections
                //         ? 9
                //         : 10,
              ),
            );
          },
        ),
      ],
    );
  }

  // empty Case

  Widget emptyCase({required InspectionsStatus status}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          space40Vertical(),
          Text(
            'There Is No ${widget.title} Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          space40Vertical(),
          if (userRoleName != Rules.Inspector.name)
            SizedBox(
              width: 200,
              child: PrimaryButton(
                text: appTranslation(context).createInspection,
                onPressed: () {
                  appBloc.clearControllers();
                  appBloc.inspectionType = widget.inspectionType;
                  appBloc.changeStackNav(
                    index: appBloc.currentSideMenuIndex,
                    isAdd: true,
                    widget: CreateInspectionWidget(
                        isUpdate: true,
                        sideMenuPageIndex: appBloc.currentSideMenuIndex),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
