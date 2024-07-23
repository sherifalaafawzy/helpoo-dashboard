import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/main_scaffold.dart';
import 'widgets/offline_vehicles_statistics_main_widget.dart';

class OfflineVehiclesStatisticsScreen extends StatefulWidget {
  const OfflineVehiclesStatisticsScreen({super.key});

  @override
  State<OfflineVehiclesStatisticsScreen> createState() =>
      _OfflineVehiclesStatisticsScreenState();
}

class _OfflineVehiclesStatisticsScreenState
    extends State<OfflineVehiclesStatisticsScreen> {
  @override
  void initState() {
    super.initState();
    if (appBloc.vehiclesStatisticsModel == null) {
      appBloc.getVehiclesStatistics();
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
              child: OfflineVehiclesStatisticsMainWidget(),
            ),
          ),
        );
      },
    );
  }
}
