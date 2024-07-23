import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/inspectors_main_widget.dart';

class InspectorsScreen extends StatefulWidget {
  const InspectorsScreen({super.key});

  @override
  State<InspectorsScreen> createState() => _InspectorsScreenState();
}

class _InspectorsScreenState extends State<InspectorsScreen> {
  @override
  void initState() {
    super.initState();
    appBloc.getMyInspectionCompaniesAsInsuranceCompany();
    appBloc.getAllInsuranceCompanies();
    // appBloc.getAllInspectors();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: InspectorsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
