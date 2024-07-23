import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/util/enums.dart';

class StepperInspection extends StatelessWidget {
  const StepperInspection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return EasyStepper(
          // fitWidth: true,
          // steppingEnabled: true,
          // showScrollbar: true,
          // enableStepTapping: true,
          alignment: Alignment.bottomCenter,
          direction: Axis.horizontal,
          activeStep: appBloc.activeStepIndex,
          lineStyle: LineStyle(
            lineLength: 100,
            lineType: LineType.normal,
            lineThickness: 3,
            lineSpace: 1,
            lineWidth: 10,
            defaultLineColor: Colors.grey,
            activeLineColor: HexColor(mainColor),
            finishedLineColor: HexColor(mainColor),
            unreachedLineType: LineType.normal,
          ),
          activeStepTextColor: Colors.black87,
          finishedStepTextColor: Colors.black87,
          showLoadingAnimation: false,
          stepRadius: 8,
          showStepBorder: false,
          onStepReached: (index) => appBloc.activeStepIndex = index,
          steps: [
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: appBloc.activeStepIndex >= 0 ? HexColor(mainColor) : Colors.grey,
                ),
              ),
              title: 'Client Data',
              topTitle: true,
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: appBloc.activeStepIndex >= 1 ? HexColor(mainColor) : Colors.grey,
                ),
              ),
              title: 'Car Data',
              topTitle: true,
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: appBloc.activeStepIndex >= 2 ? HexColor(mainColor) : Colors.grey,
                ),
              ),
              title: 'Inspection Data',
              topTitle: true,
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: appBloc.activeStepIndex >= 3 ? HexColor(mainColor) : Colors.grey,
                ),
              ),
              title: 'Attachments',
              topTitle: true,
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: appBloc.activeStepIndex >= 4 ? HexColor(mainColor) : Colors.grey,
                ),
              ),
              title: 'Additional',
              topTitle: true,
            ),
            if (appBloc.selectedInspection != null && appBloc.selectedInspection!.inspectionStatus != InspectionsStatus.pending)
              EasyStep(
                customStep: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: appBloc.activeStepIndex >= 5 ? HexColor(mainColor) : Colors.grey,
                  ),
                ),
                title: 'Inspection Process',
                topTitle: true,
              ),
            if (userRoleName == Rules.InspectionManager.name  && appBloc.selectedInspection != null && appBloc.selectedInspection!.inspectionStatus != InspectionsStatus.pending)
              EasyStep(
                customStep: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: appBloc.activeStepIndex >= 6 ? HexColor(mainColor) : Colors.grey,
                  ),
                ),
                title: 'Expert Actions',
                topTitle: true,
              ),
          ],
        );
      },
    );
  }
}
