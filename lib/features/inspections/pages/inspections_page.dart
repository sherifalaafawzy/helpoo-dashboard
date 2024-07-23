import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/widgets/main_scaffold.dart';
import '../widgets/inspections_main_widget.dart';

class InspectionsPage extends StatefulWidget {
  const InspectionsPage({super.key});

  @override
  State<InspectionsPage> createState() => _InspectionsPageState();
}

class _InspectionsPageState extends State<InspectionsPage> {
  @override
  void initState() {
    super.initState();
    // appBloc.getAllInspections(status: InspectionsStatus.all.name);
    if (userRoleName == Rules.Inspector.name) {
      appBloc.getInspectionsAsInspector(status: InspectionsStatus.all.name);
    } else {
      appBloc.getAllInspections(status: InspectionsStatus.all.name);
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
              child: InspectionsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
