import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../cubit/state.dart';
import '../extensions/build_context_extension.dart';
import 'primary_button.dart';
import 'primary_form_field.dart';

import '../../models/inspections/accident_model.dart';
import '../cubit/cubit.dart';

class AccidentDetailsPopUp extends StatelessWidget {


  AccidentModel? accident;

  AccidentDetailsPopUp({super.key, this.accident});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SizedBox(
          width: 500,
          height: 300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enter accident data',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              space40Vertical(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryFormField(
                        enabled: true,
                        infiniteLines: true,
                        validationError: '',
                        label: 'Accident description',
                        controller: appBloc.accidentDescController,
                      ),
                      space20Vertical(),
                      PrimaryFormField(
                        enabled: true,
                        infiniteLines: true,
                        validationError: '',
                        label: 'Opinions',
                        controller: appBloc.accidentOpinionController,
                      ),
                    ],
                  ),
                ),
              ),
              space40Vertical(),
              PrimaryButton(
                text: 'done',
                isLoading: appBloc.isAddingAccidentLoading,
                onPressed: () {
                  if (appBloc.accidentDescController.text.isNotEmpty && appBloc.accidentOpinionController.text.isNotEmpty) {
                    appBloc.addAccidentToAccsList();
                  }
                  context.pop();
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
