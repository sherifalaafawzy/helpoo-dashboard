import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import 'widgets/free_drivers_statistics_main_widget.dart';

class FreeDriversStatisticsScreen extends StatefulWidget {
  const FreeDriversStatisticsScreen({super.key});

  @override
  State<FreeDriversStatisticsScreen> createState() =>
      _FreeDriversStatisticsScreenState();
}

class _FreeDriversStatisticsScreenState
    extends State<FreeDriversStatisticsScreen> {
  @override
  void initState() {
    super.initState();
    if (appBloc.driversStatisticsModel == null) {
      appBloc.getDriversStatistics();
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
              child: FreeDriversStatisticsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
