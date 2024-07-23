import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpoo_insurance_dashboard/core/util/constants.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/cubit.dart';

class RequestsChart extends StatefulWidget {
  RequestsChart({super.key});

  final Color barBackgroundColor = Colors.grey.withOpacity(0.2);
  final Color barColor = Colors.green;
  final Color touchedBarColor = Colors.lightGreen;

  @override
  State<StatefulWidget> createState() => RequestsChartState();
}

class RequestsChartState extends State<RequestsChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'This month requests',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          space20Vertical(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RotatedBox(
                quarterTurns: 1,
                child: BarChart(
                  mainBarData(),
                  swapAnimationDuration: animDuration,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color? barColor,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.black, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: appBloc.allStatsResponseModel?.stats?.thisMonthServiceRequests?.toDouble(),
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, appBloc.allStatsResponseModel?.stats?.thisMonthAppRequests?.toDouble() ?? 0.0, isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, appBloc.allStatsResponseModel?.stats?.thisMonthCallCenterRequests?.toDouble() ?? 0.0, isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, appBloc.allStatsResponseModel?.stats?.thisMonthCorporateRequests?.toDouble() ?? 0.0, isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, appBloc.allStatsResponseModel?.stats?.canceledRequestsThisMonth?.toDouble() ?? 0.0, isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, appBloc.allStatsResponseModel?.stats?.thisMonthServiceRequests?.toDouble() ?? 0.0, isTouched: i == touchedIndex);
      default:
        return throw Error();
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          rotateAngle: 270,
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String source;
            switch (group.x) {
              case 0:
                source = 'Application';
                break;
              case 1:
                source = 'Call Center';
                break;
              case 2:
                source = 'Corporates';
                break;
              case 3:
                source = 'Cancelled';
                break;
              case 4:
                source = 'Completed';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$source\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 90,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = RotatedBox(quarterTurns: 3, child: const Text('Application', style: style));
        break;
      case 1:
        text = RotatedBox(quarterTurns: 3, child: const Text('Call Center', style: style));
        break;
      case 2:
        text = RotatedBox(quarterTurns: 3, child: const Text('Corporates', style: style));
        break;
      case 3:
        text = RotatedBox(quarterTurns: 3, child: const Text('Cancelled', style: style));
        break;
      case 4:
        text = RotatedBox(quarterTurns: 3, child: const Text('Completed', style: style));
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

}