import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';

import '../../widgets/by_type/supplement_inspection_widget.dart';

class SupplementInspectionsPage extends StatefulWidget {
  const SupplementInspectionsPage({super.key});

  @override
  State<SupplementInspectionsPage> createState() =>
      _SupplementInspectionsPageState();
}

class _SupplementInspectionsPageState extends State<SupplementInspectionsPage> {
  @override
  void initState() {
    super.initState();
    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(
          type: InspectionType.supplement.apiName);
    } else {
      appBloc.getAllInspections(type: InspectionType.supplement.apiName);
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
              child: SupplementInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
