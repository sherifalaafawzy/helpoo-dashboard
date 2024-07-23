import 'package:flutter/material.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';

class WinchStatsChart extends StatelessWidget {
  const WinchStatsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Winch status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        space20Vertical(),
        Wrap(
          children: [
            _buildWinchStatCard(color: Colors.black, title: 'Total Winches', val: '${appBloc.vehiclesStatsResponseModel?.stats?.allVehicles?.count ?? '-'}'),
            _buildWinchStatCard(color: Colors.red, title: 'Busy Winches', val: '${appBloc.vehiclesStatsResponseModel?.stats?.busyVehicles?.count ?? '-'}'),
            _buildWinchStatCard(color: Colors.green, title: 'Free Winches', val: '${appBloc.vehiclesStatsResponseModel?.stats?.availableVehicles?.count ?? '-'}'),
            _buildWinchStatCard(color: Colors.black, title: 'Online Winches', val: '${appBloc.vehiclesStatsResponseModel?.stats?.onlineVehicles?.count ?? '-'}'),
            _buildWinchStatCard(color: Colors.grey, title: 'Offline Winches', val: '${appBloc.vehiclesStatsResponseModel?.stats?.offlineVehicles?.count ?? '-'}'),
          ],
        ),
      ],
    );
  }

  Container _buildWinchStatCard({required String title, required String val, required Color color}) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold),),
          space10Vertical(),
          Text(val, style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
