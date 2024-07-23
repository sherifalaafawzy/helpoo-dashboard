import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/util/constants.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';
import '../../core/util/enums.dart';
import '../../core/util/widgets/main_scaffold.dart';
import 'widgets/steps/steps_screen.dart';

class CreateNewServiceRequest extends StatefulWidget {
  final bool isForCorporate;
  const CreateNewServiceRequest({super.key, this.isForCorporate = false});

  @override
  State<CreateNewServiceRequest> createState() =>
      _CreateNewServiceRequestState();
}

class _CreateNewServiceRequestState extends State<CreateNewServiceRequest> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (userRoleName == Rules.Corporate.name || widget.isForCorporate) {
              return SafeArea(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: StepsScreen(
                    currentStep: appBloc.serviceRequestStep,
                    isForCorporate: widget.isForCorporate,
                  ),
                )),
              );
            }
            return SafeArea(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
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
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  appBloc.resetServiceRequestSteps();
                                  appBloc.setIsNewCustomer(true);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        'New Customer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: appBloc.isNewCustomer
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      width: 561,
                                      height: 2,
                                      color: appBloc.isNewCustomer
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  appBloc.resetServiceRequestSteps();
                                  appBloc.setIsNewCustomer(false);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        'Existing Customer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: !appBloc.isNewCustomer
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.grey,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: 561,
                                      height: 2,
                                      color: !appBloc.isNewCustomer
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          StepsScreen(currentStep: appBloc.serviceRequestStep),
                        ],
                      ),
                    )),
              )),
            );
          },
        ),
      ),
    );
  }
}
