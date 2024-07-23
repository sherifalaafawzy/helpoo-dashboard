import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/accident_reports.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/tables/components/table_header.dart';
import '../../../core/util/widgets/tables/components/table_icon_item.dart';
import '../../../core/util/widgets/tables/components/table_pagination_bar.dart';
import '../../../core/util/widgets/tables/components/table_text_item.dart';
import '../../../core/util/widgets/tables/table_widget.dart';
import 'fnol_report_details.dart';

//collection
import 'package:collection/collection.dart';

class FNOLReportsTable extends StatefulWidget {
  final String title;
  final List<AccidentReportModel> accidentReportsList;
  final bool isLoading;
  final int sideMenuIndex;

  const FNOLReportsTable({
    super.key,
    required this.accidentReportsList,
    required this.title,
    required this.sideMenuIndex,
    required this.isLoading,
  });

  @override
  State<FNOLReportsTable> createState() => _FNOLReportsTableState();
}

class _FNOLReportsTableState extends State<FNOLReportsTable> {
  List<TableRow> accidentTableRows() {
    List<TableRow> tableRows = [];

    for (var element in appBloc.itemsSubList) {
      tableRows.add(
        tableItem(
          accidentReportModel: element,
          isNew: (appBloc.unReadList.contains(element.clientId)) ? true : false,
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
        ],
        columnsTitles: [
          'ID',
          'created time',
          'last action time',
          'Company',
          'Name',
          'Phone Number',
          'Status',
          'Action',
        ],
      ),
    );

    return tableRows;
  }

  List<AccidentReportModel> dataList = [];

  @override
  void initState() {
    super.initState();
    // here i clear the list to avoid duplication in pagination
    appBloc.itemsSubList = [];
    dataList.clear();
    dataList = widget.accidentReportsList;
    debugPrint('dataList: ${dataList.length}');
    appBloc.currentFnolRequestPage = 1;
  }

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge,
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
                    //   ],
                    //   columnsTitles: [
                    //     'ID',
                    //     'created time',
                    //     'last action time',
                    //     'Name',
                    //     'Phone Number',
                    //     'Status',
                    //     'Action',
                    //   ],
                    // ),

                    columnWidths: {
                      0: FixedColumnWidth(0.5 / 11.5 * appBloc.widgetWidth),
                      1: FixedColumnWidth(2 / 11.5 * appBloc.widgetWidth),
                      2: FixedColumnWidth(2 / 11.5 * appBloc.widgetWidth),
                      3: FixedColumnWidth(1.4 / 11.5 * appBloc.widgetWidth),
                      4: FixedColumnWidth(1.8 / 11.5 * appBloc.widgetWidth),
                      5: FixedColumnWidth(1.5 / 11.5 * appBloc.widgetWidth),
                      6: FixedColumnWidth(1.5 / 11.5 * appBloc.widgetWidth),
                      7: FixedColumnWidth(1 / 11.5 * appBloc.widgetWidth),
                    },
                    tableRows: accidentTableRows(),
                    paginationWidget: TablePaginationBar(
                      // items: appBloc.accidentReportsMap[
                      //     appBloc.currentAccidentReportsPage]!,
                      items: widget.accidentReportsList,
                      // pages: appBloc.accidentReportModel!.totalPages,
                      // pages: appBloc.currentStep == Steps.created
                      //     ? appBloc.fnolAccidentReports?.totalPages ?? 0
                      //     : appBloc.currentStep == Steps.bRepair
                      //         ? appBloc.bRepairAccidentReports?.totalPages ?? 0
                      //         : appBloc.currentStep == Steps.aRepair
                      //             ? appBloc
                      //                     .aRepairAccidentReports?.totalPages ??
                      //                 0
                      //             : appBloc.accidentReportModel!.totalPages,
                      pages: appBloc.getFnolPagesCountBasedOnCurrentStep(),
                      isLoading: widget.isLoading,
                      onCallAnotherPage: (int page) {
                        // appBloc.currentStep == Steps.created
                        //     ? appBloc.getAccidentReportsByStatus(
                        //         pageNumber: page,
                        //         status: Steps.created.name,
                        //       )
                        //     : appBloc.currentStep == Steps.bRepair
                        //         ? appBloc.getAccidentReportsByStatus(
                        //             pageNumber: page,
                        //             status: Steps.bRepair.name,
                        //           )
                        //         : appBloc.currentStep == Steps.bRepair
                        //             ? appBloc.getAccidentReportsByStatus(
                        //                 pageNumber: page,
                        //                 status: Steps.aRepair.name,
                        //               )
                        //             : appBloc.getAccidentReports(
                        //                 pageNumber: page,
                        //               );
                        appBloc.currentFnolRequestPage = page;
                        appBloc.handleOnCallFnolAnotherPage(
                          page: page,
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
    required AccidentReportModel accidentReportModel,
    required bool isNew,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: isNew && userRoleName == Rules.Insurance.name ? Colors.red.withOpacity(.2) : null,
        border: const Border(
          bottom: BorderSide(
            color: borderGrey,
          ),
        ),
      ),
      children: [
        TableTextItem(
          text: accidentReportModel.id.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: accidentReportModel.createdAt!.utcToLocalFormat,
          isCentered: true,
        ),
        TableTextItem(
          text: accidentReportModel.updatedAt!.utcToLocalFormat,
          isCentered: true,
        ),
        TableTextItem(
          text: accidentReportModel.insuranceCompany != null
              ? accidentReportModel.insuranceCompany!.enName ?? ""
              : accidentReportModel.insuranceCompanyId.toString(),
          isCentered: true,
        ),
        TableTextItem(
          text: accidentReportModel.client ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: accidentReportModel.phoneNumber ?? '',
          isCentered: true,
        ),
        TableTextItem(
          text: Steps.values.firstWhereOrNull((e) => e.name == accidentReportModel.status)?.status ?? '',
          isCentered: true,
        ),
        TableIconItem(
          icon: Icons.remove_red_eye_outlined,
          onTap: () {
            // appBloc.addDataToFirstExistIds(
            //   id: accidentReportModel.id!,
            // );
            debugPrintFullText('************************* ${appBloc.currentStep}');
            appBloc.changeStackNav(
              index: widget.sideMenuIndex,
              // index: appBloc.currentStep == Steps.created
              //     ? 3
              //     : appBloc.currentStep == Steps.bRepair
              //         ? 4
              //         : appBloc.currentStep == Steps.aRepair
              //             ? 5
              //             : appBloc.currentStep == Steps.billing
              //                 ? 6
              //                 : 2,
              isAdd: true,
              widget: const FNOLReportsMainWidget(),
            );
            appBloc.currentAccidentReport = accidentReportModel;
          },
        )
      ],
    );
  }
}
