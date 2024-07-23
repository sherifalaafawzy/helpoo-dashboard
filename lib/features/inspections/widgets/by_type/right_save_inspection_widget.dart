import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/enums.dart';
import '../inspections_table_widget.dart';
import 'package:hexcolor/hexcolor.dart';
class RightSaveInspectionWidget extends StatelessWidget {
  const RightSaveInspectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (appBloc.getAllInspectionsLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }

        return InspectionsTableWidget(
          inspectionType: InspectionType.rightSave,
          inspections: appBloc.rightSaveInspections,
          title: 'Right Save Inspections',
        );
      },
    );
  }
}