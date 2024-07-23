import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import 'widgets/busy_drivers_statistics_main_widget.dart';

class BusyDriversStatisticsScreen extends StatefulWidget {
  const BusyDriversStatisticsScreen({super.key});

  @override
  State<BusyDriversStatisticsScreen> createState() =>
      _BusyDriversStatisticsScreenState();
}

class _BusyDriversStatisticsScreenState
    extends State<BusyDriversStatisticsScreen> {
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
              child: BusyDriversStatisticsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
