import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/drivers_statistics_main_widget.dart';

class DriversStatisticsScreen extends StatefulWidget {
  const DriversStatisticsScreen({super.key});

  @override
  State<DriversStatisticsScreen> createState() =>
      _DriversStatisticsScreenState();
}

class _DriversStatisticsScreenState extends State<DriversStatisticsScreen> {
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
              child: DriversStatisticsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
