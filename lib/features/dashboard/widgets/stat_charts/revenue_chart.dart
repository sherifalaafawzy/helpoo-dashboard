import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:helpoo_insurance_dashboard/core/util/constants.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/cubit.dart';

class RevenueChart extends StatefulWidget {
  const RevenueChart({super.key});

  @override
  State<StatefulWidget> createState() => PieChart1State();
}

class PieChart1State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Revenue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          space20Vertical(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'Last Month',
              ),
              space20Horizontal(),
              Indicator(
                color: Colors.green,
                text: 'This Month',
              ),
            ],
          ),
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse
                          .touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 10,
                sections: showingSections(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 80.0 : 70.0;
      // const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: _calcPercentage(appBloc.allStatsResponseModel?.stats?.lastMonthRevenue ?? 50),
            // title: '2000 EGP',
            title: '${appBloc.allStatsResponseModel?.stats?.lastMonthRevenue ?? 'N/A'}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: _calcPercentage(appBloc.allStatsResponseModel?.stats?.thisMonthRevenue ?? 50),
            // title: '3000 EGP',
            title: '${appBloc.allStatsResponseModel?.stats?.thisMonthRevenue ?? 'N/A'}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  _calcPercentage(int val) {
    int thisMonth = appBloc.allStatsResponseModel?.stats?.thisMonthRevenue ?? 50;
    int prevMonth = appBloc.allStatsResponseModel?.stats?.lastMonthRevenue ?? 50;
    int total = thisMonth + prevMonth;
    double percentage = (val / total) * 100;
    return double.parse(percentage.toStringAsFixed(2));
  }
}

///*

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  
  const Indicator({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 25,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        space10Horizontal(),
        Text(text),
      ],
    );
  }
}


