import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import '../../widgets/by_type/after_repair_inspection_widget.dart';


class AfterRepairInspectionsPage extends StatefulWidget {
  const AfterRepairInspectionsPage({super.key});

  @override
  State<AfterRepairInspectionsPage> createState() =>
      _AfterRepairInspectionsPageState();
}

class _AfterRepairInspectionsPageState
    extends State<AfterRepairInspectionsPage> {
  @override
  void initState() {
    super.initState();

    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(
          type: InspectionType.afterRepair.apiName);
    } else {
      appBloc.getAllInspections(type: InspectionType.afterRepair.apiName);
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
              child: AfterRepairInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
