import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';

class TableIconItem extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;

  // final AccidentReportModel accidentReportModel;

  const TableIconItem({
    super.key,
    // required this.accidentReportModel,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: IconButton(
            onPressed: onTap,
            // onPressed: () {
            //   appBloc.addDataToFirstExistIds(
            //     id: accidentReportModel.id!,
            //   );
            //
            //   appBloc.changeStackNav(
            //     index: 2,
            //     isAdd: true,
            //     widget: const AccidentReportsMainWidget(),
            //   );
            //
            //   appBloc.currentAccidentReport = accidentReportModel;
            // },
            icon: Icon(
              // Icons.remove_red_eye_outlined,
              icon,
              color: mainColorHex,
            ),
          ),
        );
      },
    );
  }
}
