import 'package:flutter/material.dart';

import '../../../../core/models/stats/promo_stats_response_model.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';

class PromoUsageStatsChart extends StatelessWidget {
  const PromoUsageStatsChart({super.key});

  @override
  Widget build(BuildContext context) {

    List<PromoCodesUsageThisMonth>? promoCodesUsageThisMonth = appBloc.promoStatsResponseModel?.stats?.promoCodesUsageThisMonth;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Promo Codes Usage', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          space20Vertical(),
          ...promoCodesUsageThisMonth?.map(
                  (e) => _buildElement(title: e.name.toString(), val: e.usageCount.toString()),
          ).toList() ?? [],
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
