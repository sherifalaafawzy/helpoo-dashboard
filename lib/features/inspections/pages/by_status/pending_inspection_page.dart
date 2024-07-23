import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import '../../widgets/by_status/pending_inspection_widget.dart';

class PendingInspectionsPage extends StatefulWidget {
  const PendingInspectionsPage({super.key});

  @override
  State<PendingInspectionsPage> createState() => _PendingInspectionsPageState();
}

class _PendingInspectionsPageState extends State<PendingInspectionsPage> {
  @override
  void initState() {
    super.initState();

    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(status: InspectionsStatus.pending.name);
    } else {
      appBloc.getAllInspections(status: InspectionsStatus.pending.name);
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
              child: PendingInspectionWidget(),
            ),
          ),
        );
      },
    );
  }
}
