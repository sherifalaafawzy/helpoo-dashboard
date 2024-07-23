import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../cubit/state.dart';
import '../extensions/build_context_extension.dart';
import 'primary_button.dart';
import 'primary_form_field.dart';

import '../cubit/cubit.dart';

class ExtractRecoToTextPopUp extends StatelessWidget {
  bool isSupplementImage;

  ExtractRecoToTextPopUp({super.key, this.isSupplementImage = true});

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
                    'Extract record data',
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
                        label: 'Extracted text',
                        controller: appBloc.extractedRecoTextController,
                      ),
                    ],
                  ),
                ),
              ),
              space40Vertical(),
              PrimaryButton(
                text: 'Done',
                isLoading: appBloc.isRecoExtractionLoading,
                onPressed: () {
                  if (isSupplementImage) {
                    appBloc.saveSupplementExtractedRecoText();
                  } else {
                    appBloc.saveNotesExtractedRecoText();
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
