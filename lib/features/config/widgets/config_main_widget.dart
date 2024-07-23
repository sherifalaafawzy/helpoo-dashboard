import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import 'package:hexcolor/hexcolor.dart';

class ConfigMainWidget extends StatefulWidget {
  const ConfigMainWidget({super.key});

  @override
  State<ConfigMainWidget> createState() => _ConfigMainWidgetState();
}

class _ConfigMainWidgetState extends State<ConfigMainWidget> {
  GlobalKey clientUnderMaintainingKey = GlobalKey();
  GlobalKey inspectorUnderMaintainingKey = GlobalKey();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is UpdateConfigSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
            message: 'Config updated Successfully',
          );
        }
      },
      builder: (context, state) {
        if (appBloc.isGetAllConfigLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 14,
              color: HexColor(mainColor),
            ),
          );
        }
        return Center(
          child: SizedBox(
            width: 1122,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// client app config
                      Text(
                        'Client App Config',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      space20Vertical(),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Minimum Ios Version',
                              controller: appBloc.iosVersionController,
                            ),
                          ),
                          space20Horizontal(),
                          Expanded(
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Minimum Android Version',
                              controller: appBloc.androidVersionController,
                            ),
                          ),
                        ],
                      ),
                      space20Vertical(),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Distance Limit',
                              controller: appBloc.limitDistanceController,
                            ),
                          ),
                          space20Horizontal(),
                          Expanded(
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Duration Limit',
                              controller: appBloc.limitDurationController,
                            ),
                          ),
                        ],
                      ),
                      space20Vertical(),
                      Row(
                        children: [
                          Expanded(
                            key: clientUnderMaintainingKey,
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Under Maintenance',
                              controller: appBloc.underMaintainingController,
                              onTap: () {
                                showPrimaryMenu(context: context, key: clientUnderMaintainingKey, items: [
                                  ...appBloc.underMaintainingOptions.map(
                                    (e) => PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        e,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontSize: 16.0,
                                              color: secondaryGrey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      onTap: () {
                                        appBloc.selectedUnderMaintainingOption = e;
                                      },
                                    ),
                                  )
                                ]);
                              },
                            ),
                          ),
                        ],
                      ),
                      space40Vertical(),


                      /// inspector app config
                      Text(
                        'Inspector App Config',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      space20Vertical(),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Minimum Ios Version',
                              controller: appBloc.inspectorIosVersionController,
                            ),
                          ),
                          space20Horizontal(),
                          Expanded(
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Minimum Android Version',
                              controller: appBloc.inspectorAndroidVersionController,
                            ),
                          ),
                        ],
                      ),
                      space20Vertical(),
                      Row(
                        children: [
                          Expanded(
                            key: inspectorUnderMaintainingKey,
                            child: PrimaryFormField(
                              validationError: '',
                              label: 'Under Maintenance',
                              controller: appBloc.inspectorUnderMaintainingController,
                              onTap: () {
                                showPrimaryMenu(context: context, key: inspectorUnderMaintainingKey, items: [
                                  ...appBloc.underMaintainingOptions.map(
                                        (e) => PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        e,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                          fontSize: 16.0,
                                          color: secondaryGrey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onTap: () {
                                        appBloc.inspectorSelectedUnderMaintainingOption = e;
                                      },
                                    ),
                                  )
                                ]);
                              },
                            ),
                          ),
                        ],
                      ),
                      space40Vertical(),

                      Text(
                        'English Terms And Conditions',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      space20Vertical(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor('E5E5E5'),
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: quill.QuillProvider(
                          configurations: quill.QuillConfigurations(controller: appBloc.englishTermsController,),
                          child: const quill.QuillToolbar(
                           configurations: quill.QuillToolbarConfigurations(  showDirection: true,),

                          ),
                        ),
                      ),
                      space10Vertical(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor('E5E5E5'),
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        padding: const EdgeInsets.all(14),
                        height: 300,
                        child: quill.QuillProvider(
                          configurations: quill.QuillConfigurations(controller: appBloc.englishTermsController,),
                          child: quill.QuillEditor.basic(
                            configurations: const quill.QuillEditorConfigurations(   readOnly: false,),

                          ),
                        ),
                      ),
                      space40Vertical(),
                      Text(
                        'Arabic Terms And Conditions',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      space20Vertical(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor('E5E5E5'),
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: quill.QuillProvider(
                          configurations: quill.QuillConfigurations( controller: appBloc.arabicTermsController,),
                          child: const quill.QuillToolbar(configurations: quill.QuillToolbarConfigurations(  showDirection: true,),


                          ),
                        ),
                      ),
                      space10Vertical(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor('E5E5E5'),
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        padding: const EdgeInsets.all(14),
                        height: 300,
                        child: quill.QuillProvider(
                          configurations: quill.QuillConfigurations(controller: appBloc.arabicTermsController,),
                          child: quill.QuillEditor.basic(
                            configurations: const quill.QuillEditorConfigurations(  readOnly: false,),

                          ),
                        ),
                      ),

                      space40Vertical(),
                      Row(
                        children: [
                          Expanded(
                              child: PrimaryButton(
                            text: 'Update',
                            isLoading: state is UpdateConfigLoadingState,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                appBloc.updateConfig();
                              }
                            },
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
