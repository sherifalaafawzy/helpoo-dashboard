import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import 'fnol_reports_table.dart';
import 'package:hexcolor/hexcolor.dart';

class AccidentReportMainWidget extends StatelessWidget {
  const AccidentReportMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.isAccidentReportsLoadingFirstTime) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return FNOLReportsTable(
          sideMenuIndex: 2,
          accidentReportsList: appBloc.accidentReportModel?.accidentReports ?? [],
          isLoading: appBloc.getAccidentReportsByStatusLoadingForPagination,
          title: 'Client FNOL and inspection requests',
          // appBloc.accidentReportsMap[appBloc.currentAccidentReportsPage]!,
        );
      },
    );
  }
}

//**************************************************************************
class FNOLMainWidget extends StatelessWidget {
  const FNOLMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.getAccidentReportsByStatusLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return FNOLReportsTable(
          sideMenuIndex: 3,
          isLoading: appBloc.getAccidentReportsByStatusLoadingForPagination,
          accidentReportsList: appBloc.fnolAccidentReports?.accidentReports ?? [],
          title: 'FNOL Requests',
          // appBloc.accidentReportsMap[appBloc.currentAccidentReportsPage]!,
          // appBloc.fnolAccidentReports?.accidentReports ?? [],
        );
      },
    );
  }
}

//**************************************************************************
class BeforeRepairWidget extends StatelessWidget {
  const BeforeRepairWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.getAccidentReportsByStatusLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return FNOLReportsTable(
          sideMenuIndex: 4,
          isLoading: appBloc.getAccidentReportsByStatusLoadingForPagination,
          accidentReportsList: appBloc.bRepairAccidentReports?.accidentReports ?? [],
          title: 'Before Repair Requests',
          // appBloc.accidentReportsMap[appBloc.currentAccidentReportsPage]!,
          // appBloc.bRepairAccidentReports?.accidentReports ?? [],
        );
      },
    );
  }
}

//**************************************************************************
class AfterRepairWidget extends StatelessWidget {
  const AfterRepairWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.getAccidentReportsByStatusLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return FNOLReportsTable(
          sideMenuIndex: 5,
          isLoading: appBloc.getAccidentReportsByStatusLoadingForPagination,
          accidentReportsList: appBloc.aRepairAccidentReports?.accidentReports ?? [],
          title: 'After Repair Requests',
          // appBloc.aRepairAccidentReports?.accidentReports ?? [],
        );
      },
    );
  }
}

//**************************************************************************
class CollectDataWidget extends StatelessWidget {
  const CollectDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.getAccidentReportsByStatusLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return FNOLReportsTable(
          sideMenuIndex: 6,
          isLoading: appBloc.getAccidentReportsByStatusLoadingForPagination,
          accidentReportsList: appBloc.billingReports?.accidentReports ?? [],
          title: 'Collect Data Requests',
          // appBloc.aRepairAccidentReports?.accidentReports ?? [],
        );
      },
    );
  }
}
