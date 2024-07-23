import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/reports_main_widget.dart';
// ignore: unused_import
import 'package:helpoo_insurance_dashboard/features/service_requests/widgets/service_requests_main_widget.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.getSavedFixedColumns();
    appBloc.corporateSearchModel = null;
    appBloc.customerSearchModel = null;
    appBloc.getManufacturers();
    appBloc.getCarsModels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: ReportsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
