import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../components/step_component.dart';

class StepsScreen extends StatefulWidget {
  final int currentStep;
  final bool isForCorporate;

  const StepsScreen(
      {super.key, required this.currentStep, this.isForCorporate = false});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          width: 1122,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: borderGrey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                space24Vertical(),

                // header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepComponent(
                        isDone: appBloc.isServiceRequestFirstStepDone,
                        isCurrentStep: appBloc.serviceRequestStep == 0,
                        isFirstStep: true,
                        stepNumber: '01',
                        stepTitle: appBloc.isNewCustomer
                            ? 'User Details'
                            : 'Account Details',
                        stepSubtitle: appBloc.isNewCustomer
                            ? 'Enter the account details'
                            : 'Search for account',
                      ),
                      StepComponent(
                        isDone: appBloc.isServiceRequestSecondStepDone,
                        isCurrentStep: appBloc.serviceRequestStep == 1,
                        stepNumber: '02',
                        stepTitle: 'Services',
                        stepSubtitle: 'Choose your service',
                      ),
                      StepComponent(
                        isDone: appBloc.isServiceRequestThirdStepDone,
                        isCurrentStep: appBloc.serviceRequestStep == 2,
                        stepNumber: '03',
                        stepTitle: 'Location',
                        stepSubtitle: 'Choose your location',
                      ),
                      StepComponent(
                        isDone: appBloc.isServiceRequestFourthStepDone,
                        isCurrentStep: appBloc.serviceRequestStep == 3,
                        stepNumber: '04',
                        stepTitle: 'Confirm',
                        stepSubtitle: 'Choose your trip',
                      ),
                    ],
                  ),
                ),
                space24Vertical(),
                const Divider(
                  color: borderGrey,
                  thickness: 1,
                ),
                space24Vertical(),

                // body
                // const Services(),
                appBloc.isNewCustomer
                    ? appBloc.serviceRequestSteps[appBloc.serviceRequestStep]
                    : appBloc.existCustomerServiceRequestSteps[
                        appBloc.serviceRequestStep],
                space24Vertical(),
                // footer
                if (appBloc.serviceRequestStep != 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        if (appBloc.serviceRequestStep !=
                            appBloc.serviceRequestSteps.length - 1)
                          TextButton(
                            onPressed: () {
                              // appBloc.changeServiceRequestStep(
                              //     step: appBloc.serviceRequestStep > 0
                              //         ? appBloc.serviceRequestStep--
                              //         : appBloc.serviceRequestStep);
                              // debugPrint(
                              //     'currentServiceRequestStep: ${appBloc.serviceRequestStep}');
                              appBloc.backServiceRequestStep();
                            },
                            child: const Text('Back'),
                          ),
                        const Spacer(),
                        if (appBloc.serviceRequestStep !=
                            appBloc.serviceRequestSteps.length - 2)
                          TextButton(
                            onPressed: () {
                              if (appBloc.serviceRequestStep <
                                  appBloc.serviceRequestSteps.length - 1) {
                                appBloc.changeServiceRequestStep(
                                    step: appBloc.serviceRequestStep <
                                            appBloc.serviceRequestSteps.length -
                                                1
                                        ? appBloc.serviceRequestStep + 1
                                        : appBloc.serviceRequestStep);
                              }
                              if (appBloc.serviceRequestStep ==
                                  appBloc.serviceRequestSteps.length - 1) {
                                if (appBloc.stepValidation(step: 4)) {
                                  // appBloc.assignDriverToServiceRequest();
                                  appBloc.createNewRequest(
                                      isForCorporate: widget.isForCorporate);
                                }
                              }
                            },
                            child:
                                state is AssignDriverToServiceRequestLoadingState ||
                                        state is CreateNewRequestLoadingState
                                    ? const CupertinoActivityIndicator()
                                    : Text(appBloc.serviceRequestStep ==
                                            appBloc.serviceRequestSteps.length -
                                                1
                                        ? 'Submit'
                                        : 'Next'),
                          ),
                      ],
                    ),
                  ),
                if (appBloc.serviceRequestStep != 0) space24Vertical(),
              ],
            ),
          ),
        );
      },
    );
  }
}
