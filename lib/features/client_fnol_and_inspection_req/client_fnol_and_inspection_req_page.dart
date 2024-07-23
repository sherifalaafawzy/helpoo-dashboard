import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/enums.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/fnol_reports_main_widget.dart';

class ClientFNOLAndInspectionReqPage extends StatefulWidget {
  const ClientFNOLAndInspectionReqPage({super.key});

  @override
  State<ClientFNOLAndInspectionReqPage> createState() =>
      _ClientFNOLAndInspectionReqPageState();
}

class _ClientFNOLAndInspectionReqPageState
    extends State<ClientFNOLAndInspectionReqPage> {
  @override
  void initState() {
    super.initState();

    appBloc.requestCounter = 1;
    appBloc.currentFnolRequestPage = 1;

    appBloc.getAccidentReports(
      pageNumber: 1,
      isFirstTimeLoading: true,
    );

    // todo time interval
    appBloc.mySecondTimer ??= Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        appBloc.getAccidentReports(
          pageNumber: appBloc.currentFnolRequestPage,
        );
      },
    );
  }

  @override
  void dispose() {
    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: AccidentReportMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
//**********************************************************************************************************************

class FNOLPage extends StatefulWidget {
  const FNOLPage({super.key});

  @override
  State<FNOLPage> createState() => _FNOLPageState();
}

class _FNOLPageState extends State<FNOLPage> {
  @override
  void initState() {
    super.initState();
    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }

    appBloc.requestCounter = 1;
    appBloc.currentFnolRequestPage = 1;
    appBloc.getAccidentReportsByStatus(
      pageNumber: appBloc.currentFnolRequestPage,
      status: Steps.created.name,
      isFirstTime: true,
    );
  }

  @override
  void dispose() {
    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: FNOLMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
//**********************************************************************************************************************

class BeforeRepairPage extends StatefulWidget {
  const BeforeRepairPage({super.key});

  @override
  State<BeforeRepairPage> createState() => _BeforeRepairPageState();
}

class _BeforeRepairPageState extends State<BeforeRepairPage> {
  @override
  void initState() {
    super.initState();

    appBloc.requestCounter = 1;
    appBloc.currentFnolRequestPage = 1;
    appBloc.getAccidentReportsByStatus(
      pageNumber: appBloc.currentFnolRequestPage,
      status: Steps.bRepair.name,
      isFirstTime: true,
    );
  }

  @override
  void dispose() {
    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: BeforeRepairWidget(),
            ),
          ),
        );
      },
    );
  }
}

//**********************************************************************************************************************
class AfterRepairPage extends StatefulWidget {
  const AfterRepairPage({super.key});

  @override
  State<AfterRepairPage> createState() => _AfterRepairPageState();
}

class _AfterRepairPageState extends State<AfterRepairPage> {
  @override
  void initState() {
    super.initState();

    appBloc.requestCounter = 1;
    appBloc.currentFnolRequestPage = 1;
    appBloc.getAccidentReportsByStatus(
      pageNumber: appBloc.currentFnolRequestPage,
      status: Steps.aRepair.name,
      isFirstTime: true,
    );
  }

  @override
  void dispose() {
    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: AfterRepairWidget(),
            ),
          ),
        );
      },
    );
  }
}

//**********************************************************************************************************************
class CollectDataPage extends StatefulWidget {
  const CollectDataPage({super.key});

  @override
  State<CollectDataPage> createState() => _CollectDataPageState();
}

class _CollectDataPageState extends State<CollectDataPage> {
  @override
  void initState() {
    super.initState();

    appBloc.requestCounter = 1;
    appBloc.currentFnolRequestPage = 1;
    appBloc.getAccidentReportsByStatus(
      pageNumber: appBloc.currentFnolRequestPage,
      status: Steps.billing.name,
      isFirstTime: true,
    );
  }

  @override
  void dispose() {
    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: CollectDataWidget(),
            ),
          ),
        );
      },
    );
  }
}
