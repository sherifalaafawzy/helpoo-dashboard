import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../widgets/my_rich_text.dart';

class AfterRepair extends StatelessWidget {
  const AfterRepair({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyRichText(
              text: 'Name: ',
              text2: appBloc.accidentDetailsModel?.report
                      ?.afterRepairLocation?[0].name ??
                  '',
            ),
            space15Vertical(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'After Repair Location: ',
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
                              ?.afterRepairLocation?[0].lat ??
                          0,
                      longitude: appBloc.accidentDetailsModel?.report
                              ?.afterRepairLocation?[0].lng ??
                          0,
                    );
                  },
                  child: Text(
                    appBloc.accidentDetailsModel?.report
                            ?.afterRepairLocation?[0].address ??
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
          ],
        );
      },
    );
  }
}
