import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/widgets/primary_padding.dart';
import 'main_card.dart';


class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PrimaryPadding(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    appTranslation(context).inGeneral,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 34,
                        ),
                  ),
                  space10Horizontal(),
                  Text(
                    'تحت التطوير',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: secondaryGrey,
                        ),
                  ),
                ],
              ),
              space20Vertical(),
              Wrap(
                runAlignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 20,
                children: [
                  MainCard(
                    title: appTranslation(context).totalInspections,
                    value: '100',
                    color: Colors.blueGrey,
                  ),
                  MainCard(
                    title: appTranslation(context).totalCompletedInspections,
                    value: '100',
                    color: Colors.green,
                  ),
                ],
              ),
              space40Vertical(),
              const MyDivider(),
              space40Vertical(),
              Row(
                children: [
                  Text(
                    appTranslation(context).inToday,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 34,
                        ),
                  ),
                  space10Horizontal(),
                  Text(
                    'تحت التطوير',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: secondaryGrey,
                    ),
                  ),
                ],
              ),
              space20Vertical(),
              Wrap(
                runAlignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 20,
                children: [
                  MainCard(
                    title: appTranslation(context).totalTodayInspections,
                    value: '100',
                    color: Colors.blueGrey,
                  ),
                  MainCard(
                    title: appTranslation(context).totalPendingTodayInspections,
                    value: '100',
                    color: Colors.red,
                  ),
                  MainCard(
                    title:
                        appTranslation(context).totalAcceptedTodayInspections,
                    value: '100',
                    color: Colors.orange,
                  ),
                  MainCard(
                    title:
                        appTranslation(context).totalCompletedTodayInspections,
                    value: '100',
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
