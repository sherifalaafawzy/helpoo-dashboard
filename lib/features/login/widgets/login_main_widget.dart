import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/remote/api_endpoints.dart';
import '../../../core/util/assets_images.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/build_context_extension.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/routes.dart';
import '../../../core/util/widgets/load_image.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../main.dart';

class LoginMainWidget extends StatefulWidget {
  const LoginMainWidget({super.key});

  @override
  State<LoginMainWidget> createState() => _LoginMainWidgetState();
}

class _LoginMainWidgetState extends State<LoginMainWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          context.pushNamedAndRemoveUntil(Routes.home);
        }

        if (state is LoginError) {
          HelpooInAppNotification.showMessage(
            message: state.error,
            color: chooseColor(TOAST.error),
            iconPath: chooseIcon(TOAST.error),
          );
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Container(
                color: backgroundColor,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Image.asset(
                        AssetsImages.loginBK2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
                      child: Image.asset(
                        AssetsImages.loginBK,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        appBloc.ENV_CONFIG_CLICKS++;
                        if (appBloc.ENV_CONFIG_CLICKS == 10) {
                          appBloc.ENV_CONFIG_CLICKS = 0;
                          showModalBottomSheet(context: context, builder: (_) {
                            return ListView(
                              children: [
                                ListTile(
                                  title: const Text('PRODUCTION'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    appBloc.ENV_CONFIG_SELECTED = production;
                                    showAdminPassDialog();
                                  },
                                ),
                                ListTile(
                                  title: const Text('STAGING'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    appBloc.ENV_CONFIG_SELECTED = staging;
                                    showAdminPassDialog();
                                  },
                                ),
                                ListTile(
                                  title: const Text('DEV'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    appBloc.ENV_CONFIG_SELECTED = dev;
                                    showAdminPassDialog();
                                  },
                                ),
                              ],
                            );
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: LoadImage(
                            image: 'helpoo_logo',
                            width: 160,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: PrimaryPadding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome to Helpoo! 👋',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            space5Vertical(),
                            const Text(
                              'please sign-in to your account and start the adventure',
                              style: TextStyle(
                                color: textGrayColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            space15Vertical(),
                            PrimaryFormField(
                              validationError: 'please Enter your user name',
                              label: 'UserName',
                              controller: appBloc.usernameController,
                              onFieldSubmitted: (v) {
                                if (formKey.currentState!.validate()) {
                                  appBloc.companyLogin();
                                }
                              },
                            ),
                            space15Vertical(),
                            PrimaryFormField(
                              validationError: 'please Enter your password',
                              label: 'Password',
                              onFieldSubmitted: (v) {
                                if (formKey.currentState!.validate()) {
                                  appBloc.companyLogin();
                                }
                              },
                              suffixIcon: InkWell(
                                onTap: () {
                                  appBloc.changePasswordVisibility();
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Icon(
                                  appBloc.isPasswordShown ? Icons.visibility_off : Icons.visibility,
                                ),
                              ),
                              controller: appBloc.passwordController,
                              isPassword: appBloc.isPasswordShown,
                            ),
                            space20Vertical(),
                            PrimaryButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  appBloc.companyLogin();
                                }
                              },
                              text: appTranslation(context).login,
                              isLoading: state is LoginLoading,
                            ),
                            // space20Vertical(),
                            // PrimaryButton(
                            //   onPressed: () {
                            //     PdfController.createInspectionPdf(context: context, images: [
                            //       'https://th.bing.com/th/id/OIP.bpJTixcJ9eRwEFjKsApJ8QHaEo?pid=ImgDet&rs=1',
                            //     ]);
                            //   },
                            //   text: 'Export',
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void showAdminPassDialog() {
  TextEditingController passCtrl = TextEditingController();
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: const Text('Warning!'),
      content: Column(
        children: [
          const ListTile(
            title: Text('Admin Configuration!'),
            subtitle: Text('You are about to edit on the app configuration! Please make sure to contact Helpoo Administration Team.'),
          ),
          PrimaryFormField(
            validationError: 'Wrong Password',
            label: 'ADMIN PASS',
            controller: passCtrl,
            enabled: true,
          ),
        ],
      ),
      actions: [
        PrimaryButton(
          text: 'PROCEED!',
          backgroundColor: Colors.red,
          onPressed: () {
            if (passCtrl.text == appBloc.ENV_CONFIG_PASS) {
              ENVIRONMENT = appBloc.ENV_CONFIG_SELECTED;
              baseUrl = 'https://$ENVIRONMENT.helpooapp.net/api/';
              imagesBaseUrl = 'https://$ENVIRONMENT.helpooapp.net';
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    ),
  );
}
