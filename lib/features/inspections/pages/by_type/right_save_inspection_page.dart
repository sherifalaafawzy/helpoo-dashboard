import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';

import '../../widgets/by_type/right_save_inspection_widget.dart';

class RightSaveInspectionsPage extends StatefulWidget {
  const RightSaveInspectionsPage({super.key});

  @override
  State<RightSaveInspectionsPage> createState() =>
      _RightSaveInspectionsPageState();
}

class _RightSaveInspectionsPageState extends State<RightSaveInspectionsPage> {
  @override
  void initState() {
    super.initState();

    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(type: InspectionType.rightSave.apiName);
    } else {
      appBloc.getAllInspections(type: InspectionType.rightSave.apiName);
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
              child: RightSaveInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
