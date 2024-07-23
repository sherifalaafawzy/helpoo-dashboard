import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import '../../widgets/by_status/done_inspection_widget.dart';

class DoneInspectionsPage extends StatefulWidget {
  const DoneInspectionsPage({super.key});

  @override
  State<DoneInspectionsPage> createState() => _DoneInspectionsPageState();
}

class _DoneInspectionsPageState extends State<DoneInspectionsPage> {
  @override
  void initState() {
    super.initState();
    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(
          status: InspectionsStatus.finished.name);
    } else {
      appBloc.getAllInspections(status: InspectionsStatus.finished.name);
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
              child: FinishedInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
