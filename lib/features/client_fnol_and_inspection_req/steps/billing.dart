import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../widgets/my_rich_text.dart';


class BillingStep extends StatelessWidget {
  const BillingStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MyRichText(
            text: 'Bill Delivery Date : ',
            text2:
                '${DateTime.parse(appBloc.accidentDetailsModel?.report?.billDeliveryDate?[0] ?? '')}',
          ),
          space30Vertical(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bill Delivery Location : ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  launchMap(
                    latitude: appBloc.accidentDetailsModel?.report
                            ?.billDeliveryLocation?[0].lat ??
                        0,
                    longitude: appBloc.accidentDetailsModel?.report
                            ?.billDeliveryLocation?[0].lng ??
                        0,
                  );
                },
                child: Text(
                  appBloc.accidentDetailsModel?.report?.billDeliveryLocation?[0]
                          .address ??
                      '',
                  style: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(color: Colors.blueAccent, offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blueAccent,
                    decorationThickness: 3,
                  ),
                ),
              ),
            ],
          ),
          space30Vertical(),
          MyRichText(
            text: 'Bill Delivery Notes : ',
            text2:
                appBloc.accidentDetailsModel?.report?.billDeliveryNotes?[0] ??
                    '',
          ),
          space30Vertical(),
          MyRichText(
            text: 'Bill Delivery Time Range : ',
            text2: appBloc
                    .accidentDetailsModel?.report?.billDeliveryTimeRange?[0] ??
                '',
          ),
          space30Vertical(),
        ],
      );
    });
  }
}
