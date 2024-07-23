import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';

class EditSettingPopupBody extends StatelessWidget {
  const EditSettingPopupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is EditSettingTypeSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
              message: 'Setting Edited Successfully');
          appBloc.getSettingTypes();
          context.pop;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Setting',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ),
              space20Vertical(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryFormField(
                      validationError: 'Base cost is required',
                      label: 'Base cost',
                      controller: appBloc.baseCostController,
                    ),
                  ),
                  space10Horizontal(),
                  Expanded(
                    child: PrimaryFormField(
                      validationError: 'Cost Per Km is required',
                      label: 'Cost Per Km',
                      controller: appBloc.costPerKmController,
                    ),
                  ),
                ],
              ),
              space10Vertical(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Apply',
                      isLoading: appBloc.isEditingSettingTypeLoading,
                      onPressed: () {
                        appBloc.editSettingType();
                      },
                    ),
                  ),
                  space10Horizontal(),
                  Expanded(
                    child: PrimaryButton(
                        text: 'Cancel',
                        backgroundColor: Colors.red,
                        onPressed: () {
                          appBloc.baseCostController.clear();
                          appBloc.costPerKmController.clear();
                          context.pop;
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
