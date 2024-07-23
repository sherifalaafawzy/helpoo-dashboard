import 'package:flutter/material.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';

class NumberInsightsChart extends StatelessWidget {
  const NumberInsightsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Number Insights This Month', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          space20Vertical(),
          _buildElement(title: 'Registrations', val: appBloc.allStatsResponseModel?.stats?.registrationThisMonth?.toString() ?? '-'),
          _buildElement(title: 'Packages Income', val: appBloc.allStatsResponseModel?.stats?.packageIncomeThisMonth?.totalFees?.toString() ?? '-'),
          _buildElement(title: 'FNOL Created', val: appBloc.allStatsResponseModel?.stats?.fNOLCreated?.toString() ?? '-'),
          _buildElement(title: 'Package Subscriptions', val: appBloc.allStatsResponseModel?.stats?.thisMonthSubscribers?.toString() ?? '-'),
        ],
      ),
    );
  }

  Padding _buildElement({required String title, required String val}) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListTile(
            trailing: Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            title: Card(
              elevation: 0,
              color: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        );
  }
}
