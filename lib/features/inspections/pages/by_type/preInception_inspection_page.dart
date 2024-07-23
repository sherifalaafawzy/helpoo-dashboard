import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import '../../widgets/by_type/preInception_inspection_widget.dart';

class PreInceptionInspectionsPage extends StatefulWidget {
  const PreInceptionInspectionsPage({super.key});

  @override
  State<PreInceptionInspectionsPage> createState() =>
      _PreInceptionInspectionsPageState();
}

class _PreInceptionInspectionsPageState
    extends State<PreInceptionInspectionsPage> {
  @override
  void initState() {
    super.initState();

    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(
          type: InspectionType.preInception.apiName);
    } else {
      appBloc.getAllInspections(type: InspectionType.preInception.apiName);
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
              child: PreInceptionInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
