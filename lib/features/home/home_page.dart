// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpoo_insurance_dashboard/core/util/constants.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/cubit.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/state.dart';
import 'package:helpoo_insurance_dashboard/core/util/enums.dart';
import 'package:helpoo_insurance_dashboard/core/util/widgets/main_scaffold.dart';
import 'package:helpoo_insurance_dashboard/features/home/widgets/home_main_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // if(token.isEmpty) {
    //   appBloc.logout();
    // }

    /// Get Corp Branches

    debugPrint('userRoleName 888888 >>> $userRoleName');
    debugPrint('userRoleName 888888 >>> ${Rules.Corporate.name}');

    // if (userRoleName == Rules.Corporate.name) {
      appBloc.getAllCorpBranches();
    // }

    if ((userRoleName != Rules.Inspector.name &&
        userRoleName != Rules.Corporate.name &&
        userRoleName != Rules.CallCenter.name &&
        userRoleName != Rules.Super.name)) {
      appBloc.getMyInspectors();
    }

    if (userRoleName == Rules.Insurance.name || userRoleName == Rules.Super.name) {
      appBloc.getMyInspectionCompaniesAsInsuranceCompany();
      appBloc.getAllInspections(status: InspectionsStatus.pending.name);
    } else if (userRoleName == Rules.Inspector.name || userRoleName == Rules.Super.name) {
      appBloc.getInspectionsAsInspector(status: InspectionsStatus.pending.name);
    }

    /// Get Fnols
    if (userRoleName == Rules.Insurance.name ||
        userRoleName == Rules.Super.name ||
        userRoleName == Rules.Broker.name ||
        userRoleName == Rules.SuperVisor.name) {
      getAccidentReports();
    }
    // messageListener(context);
  }

  Future<void> getAccidentReports() async {
    appBloc.requestCounter = 1;
    await appBloc.getAccidentReports(pageNumber: 1, isFirstTimeLoading: true);
    appBloc.requestCounter = 1;
    await appBloc.getAccidentReportsByStatus(
      status: Steps.created.name,
      pageNumber: 1,
      isFirstTime: true,
    );
    appBloc.requestCounter = 1;
    await appBloc.getAccidentReportsByStatus(
      status: Steps.bRepair.name,
      pageNumber: 1,
      isFirstTime: true,
    );
    appBloc.requestCounter = 1;
    await appBloc.getAccidentReportsByStatus(
      status: Steps.aRepair.name,
      pageNumber: 1,
      isFirstTime: true,
    );
    appBloc.requestCounter = 1;
    await appBloc.getAccidentReportsByStatus(
      status: Steps.billing.name,
      pageNumber: 1,
      isFirstTime: true,
    );

    debugPrint('accidentReportModel!.unread: ${appBloc.accidentReportModel!.unread}');
    debugPrint('fnolTotalUnread: ${appBloc.fnolTotalUnread}');
    debugPrint('bRepairTotalUnread: ${appBloc.bRepairTotalUnread}');
    debugPrint('aRepairTotalUnread: ${appBloc.aRepairTotalUnread}');
    debugPrint('billingTotalUnread: ${appBloc.billingTotalUnread}');
  }

  // void messageListener(BuildContext context) {
  //   FirebaseMessaging.onMessage.listen(
  //     (RemoteMessage message) {
  //       debugPrint('Got a message whilst in the foreground!');
  //       debugPrint('Message data: ${message.data}');
  //       debugPrint('Message data: ${message.data['type']}');
  //
  //       if (message.notification != null) {
  //         debugPrint(
  //             'Message also contained a notification: ${message.notification!.body}');
  //
  //         if (message.data['type'] == 'FNOL_DETAILS') {
  //           if (appBloc.currentAccidentReport != null) {
  //             appBloc.getAccidentDetails(
  //               accidentId: appBloc.currentAccidentReport!.id,
  //               forceRefresh: false,
  //             );
  //           }
  //         }
  //
  //         // showDialog(
  //         //   context: context,
  //         //   builder: ((BuildContext context) {
  //         //     return DynamicDialog(
  //         //       title: message.notification!.title,
  //         //       body: message.notification!.body,
  //         //     );
  //         //   }),
  //         // );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            body: SafeArea(
              child: HomeMainWidget(),
            ),
          ),
        );
      },
    );
  }
}

//push notification dialog for foreground
class DynamicDialog extends StatefulWidget {
  final title;
  final body;

  const DynamicDialog({super.key, this.title, this.body});

  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Text(widget.body),
    );
  }
}
