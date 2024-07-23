import 'package:flutter/material.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';

class TopCompaniesChart extends StatelessWidget {
  const TopCompaniesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Top Corporate Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          space20Vertical(),
          ListTile(
            leading: Card(
              color: Colors.grey.withOpacity(0.2),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(' 1st ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            title: Text('${appBloc.allStatsResponseModel?.stats?.mostCorporate?.enName ?? ''}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
            trailing: Card(
              elevation: 0,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${appBloc.allStatsResponseModel?.stats?.mostCorporateCount}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
          space10Vertical(),
          ListTile(
            leading: Card(
              color: Colors.grey.withOpacity(0.2),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('2nd', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            title: Text('${appBloc.allStatsResponseModel?.stats?.secondCorporate?.enName ?? ''}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
            trailing: Card(
              elevation: 0,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${appBloc.allStatsResponseModel?.stats?.secondCorporateCount}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
          space10Vertical(),
          ListTile(
            leading: Card(
              color: Colors.grey.withOpacity(0.2),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('3rd ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            title: Text('${appBloc.allStatsResponseModel?.stats?.thirdCorporate?.enName ?? ''}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
            trailing: Card(
              elevation: 0,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${appBloc.allStatsResponseModel?.stats?.thirdCorporateCount}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
