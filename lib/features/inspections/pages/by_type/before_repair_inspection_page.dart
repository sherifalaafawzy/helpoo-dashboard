import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import '../../widgets/by_type/before_repair_inspection_widget.dart';

class BeforeRepairInspectionsPage extends StatefulWidget {
  const BeforeRepairInspectionsPage({super.key});

  @override
  State<BeforeRepairInspectionsPage> createState() =>
      _BeforeRepairInspectionsPageState();
}

class _BeforeRepairInspectionsPageState
    extends State<BeforeRepairInspectionsPage> {
  @override
  void initState() {
    super.initState();

    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(
          type: InspectionType.beforeRepair.apiName);
    } else {
      appBloc.getAllInspections(type: InspectionType.beforeRepair.apiName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return const MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: BeforeRepairInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
