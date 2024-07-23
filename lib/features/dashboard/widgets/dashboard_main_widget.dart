import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpoo_insurance_dashboard/core/util/cubit/state.dart';
import 'package:helpoo_insurance_dashboard/core/util/widgets/primary_divider_text.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/number_insights_chart.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/promo_corp_stats_chart.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/promo_usage_stats_chart.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/requests_chart.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/revenue_chart.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/top_companies_chart.dart';
import 'package:helpoo_insurance_dashboard/features/dashboard/widgets/stat_charts/winch_stats_chart.dart';
import '../../../core/util/assets_images.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/widgets/primary_padding.dart';
import 'clock.dart';

class DashBoardMainWidget extends StatefulWidget {
  const DashBoardMainWidget({super.key});

  @override
  State<DashBoardMainWidget> createState() => _DashBoardMainWidgetState();
}

class _DashBoardMainWidgetState extends State<DashBoardMainWidget> {
  @override
  void initState() {

    appBloc.getAllStats();
    appBloc.getVehiclesStats();
    appBloc.getPromoStats();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PrimaryPadding(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryPadding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, $userName',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black87,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              '$userRoleName - $userName',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.grey.withOpacity(0.5),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            space15Vertical(),
                            const MyClock(),
                            Text(
                              DateTime.now().dayMonthYearFormat,
                              style:
                                  Theme.of(context).textTheme.displayLarge!.copyWith(
                                        color: Colors.grey.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, right: 20),
                        child: Image.asset(
                          AssetsImages.dashboard,
                          height: 220,
                        ),
                      ),
                    ],
                  ),
                ),

                ///******************** stats *********************

                if (userRoleName == Rules.Super.name)...[
                  space30Vertical(),
                  const PrimaryDividerText(text: 'Helpoo Statistics', textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),),
                  space40Vertical(),

                  /// all stats
                  !(appBloc.isGetAllStatsLoading || appBloc.isGetPromoStatsLoading) ?
                    Wrap(
                      runSpacing: 50,
                      children: [
                        Container(
                          height: 300,
                          width: 350,
                          child: const RevenueChart(),
                        ),
                        Container(height: 300, width: 1, color: Colors.grey),
                        Container(
                          height: 300,
                          width: 350,
                          child: PromoCorpStatsChart(),
                        ),
                        Container(height: 300, width: 1, color: Colors.grey),
                        Container(
                          height: 300,
                          width: 350,
                          child: PromoUsageStatsChart(),
                        ),
                        Container(height: 300, width: 1, color: Colors.grey),
                        Container(
                          height: 300,
                          width: 350,
                          child: RequestsChart(),
                        ),
                        Container(height: 300, width: 1, color: Colors.grey),
                        Container(
                          height: 300,
                          width: 350,
                          child: const NumberInsightsChart(),
                        ),
                        Container(height: 300, width: 1, color: Colors.grey),
                        Container(
                          height: 300,
                          width: 350,
                          child: const TopCompaniesChart(),
                        ),
                      ],
                    )
                      : const CupertinoActivityIndicator(),

                  space30Vertical(),
                  const Divider(),
                  space30Vertical(),
                ],

                if (userRoleName == Rules.Super.name || userRoleName == Rules.CallCenter.name)...[
                  /// wench stats
                  !appBloc.isGetVehiclesStatsLoading ?
                  const WinchStatsChart()
                      : const CupertinoActivityIndicator(),
                ],
              ],
            ),
          ),
        );
      }
    );
  }
}
