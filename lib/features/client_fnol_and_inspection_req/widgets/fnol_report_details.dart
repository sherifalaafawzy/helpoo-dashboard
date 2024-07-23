import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/main_scaffold.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/shared_widgets/error_imge_holder.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import 'my_rich_text.dart';
import 'selecr_email_popup_body.dart';
import 'step_widget.dart';
import '../../inspections/widgets/create_inspection.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:collection/collection.dart';

class FNOLReportsMainWidget extends StatefulWidget {
  const FNOLReportsMainWidget({
    super.key,
  });

  @override
  State<FNOLReportsMainWidget> createState() => _FNOLReportsMainWidgetState();
}

class _FNOLReportsMainWidgetState extends State<FNOLReportsMainWidget> {
  @override
  void initState() {
    super.initState();
    appBloc.selectedPdfPath = '';
    if (appBloc.currentAccidentReport != null) {
      appBloc.getAccidentDetails(accidentId: appBloc.currentAccidentReport!.id, isFirstTime: true);
    }

    if (appBloc.mySecondTimer != null) {
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }

    // todo time interval

    appBloc.myTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (appBloc.mySecondTimer != null) {
          appBloc.mySecondTimer!.cancel();
          appBloc.mySecondTimer = null;
        }

        appBloc.getAccidentDetails(
          accidentId: appBloc.currentAccidentReport!.id,
          forceRefresh: false,
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (appBloc.myTimer != null) {
      appBloc.myTimer!.cancel();
      appBloc.myTimer = null;
    }
    if (appBloc.mySecondTimer != null) {
      debugPrint('timer disposed');
      appBloc.mySecondTimer!.cancel();
      appBloc.mySecondTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AccidentDetailsError) {
          HelpooInAppNotification.showErrorMessage(
            message: state.error,
          );
        }
        if (state is AccidentDetailsSuccess) {
          if (appBloc.fnolDetailsLastIndex != (appBloc.accidentDetailsModel?.report?.statusList?.length ?? 1) - 1) {
            appBloc.fnolDetailsLastIndex = (appBloc.accidentDetailsModel?.report?.statusList?.length ?? 1) - 1;
            appBloc.setFnolCurrentIndex = (appBloc.accidentDetailsModel?.report?.statusList?.length ?? 1) - 1;
          }
          // if (state.isFirstTime) {
          //   appBloc.setFnolCurrentIndex =
          //       (appBloc.accidentDetailsModel?.report?.statusList?.length ??
          //               1) -
          //           1;
          // }
        }

        if (state is GetInsuranceSuccessState) {
          Navigator.of(context).pop();
          showPrimaryPopUp(
            context: context,
            title: 'Select Email',
            popUpBody: const SelectEmailPopUpBody(),
          );
        }

        if (state is UploadFnolPdfSuccessState) {
          appBloc.getInsurance(
            id: appBloc.accidentDetailsModel!.report!.insuranceCompanyId!,
          );
        }
      },
      builder: (context, state) {
        return MainScaffold(
          scaffold: Scaffold(
            backgroundColor: backgroundColor,
            body: appBloc.isGetAccidentDetailsLoading
                ? Center(
                    child: CupertinoActivityIndicator(
                      radius: 14,
                      color: HexColor(mainColor),
                    ),
                  )
                : state is AccidentDetailsError
                    ? const ErrorImageHolder()
                    : PrimaryPadding(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const BackButtonWidget(),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: 10.br,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(14),
                                        child: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            MyRichText(
                                              text: 'Case Id : ',
                                              text2: '${appBloc.accidentDetailsModel?.report?.id ?? ''}',
                                            ),
                                            Container(height: 15, width: 2, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                            MyRichText(
                                              text: 'Car Details : ',
                                              text2:
                                              '${appBloc.accidentDetailsModel?.report?.car?.manufacturer?.enName ?? ''} ${appBloc.accidentDetailsModel?.report?.car?.carModel?.enName ?? ''} ${appBloc.accidentDetailsModel?.report?.car?.year ?? ''}',
                                            ),
                                            Container(height: 15, width: 2, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                            MyRichText(
                                              text: 'Policy : ',
                                              text2: appBloc.accidentDetailsModel?.report?.car?.policyNumber ?? '',
                                            ),
                                            Container(height: 15, width: 2, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                            MyRichText(
                                              text: 'Created At : ',
                                              text2: DateTime.parse(appBloc.accidentDetailsModel?.report?.createdAt ?? '').utcToLocalFormat,
                                            ),
                                            Container(height: 15, width: 2, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Case Type : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Wrap(
                                                  children: List.generate(
                                                    appBloc.accidentDetailsModel?.report?.accidentTypes?.length ?? 0,
                                                        (index) => Padding(
                                                      padding: const EdgeInsetsDirectional.only(end: 5),
                                                      child: Text(
                                                          '${appBloc.accidentDetailsModel?.report?.accidentTypes?[index].enName} ${index != appBloc.accidentDetailsModel!.report!.accidentTypes!.length - 1 ? '-' : ''}'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(height: 15, width: 2, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Address : ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launchMap(
                                                          latitude: appBloc.accidentDetailsModel?.report?.location?.lat ?? 0,
                                                          longitude: appBloc.accidentDetailsModel?.report?.location?.lng ?? 0,
                                                        );
                                                      },
                                                      child: Text(
                                                        appBloc.accidentDetailsModel?.report?.location?.address ?? '',
                                                        style: const TextStyle(
                                                          color: Colors.transparent,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          shadows: [Shadow(color: Colors.blueAccent, offset: Offset(0, -3))],
                                                          decoration: TextDecoration.underline,
                                                          decorationStyle: TextDecorationStyle.solid,
                                                          decorationColor: Colors.blueAccent,
                                                          decorationThickness: 3,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                ///*************** Create Inspection Button ***************
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              space10Vertical(),
                              const Divider(),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ...List.generate(appBloc.accidentDetailsModel?.report?.statusList?.length ?? 0, (index) {
                                                    return Column(
                                                      children: [
                                                        StepWidget(
                                                          onTap: () {
                                                            appBloc.changeFnolCurrentIndex(index);
                                                          },
                                                          isCurrent: appBloc.fnolCurrentIndex > index,
                                                          isNext: false,
                                                          // index <
                                                          //     appBloc
                                                          //         .fnolCurrentIndex,
                                                          isPrevious: index == appBloc.fnolCurrentIndex,
                                                          title: Steps.values
                                                              .firstWhere((e) => e.name == appBloc.accidentDetailsModel?.report?.statusList?[index])
                                                              .title,
                                                          subtitle: Steps.values
                                                              .firstWhere((e) => e.name == appBloc.accidentDetailsModel?.report?.statusList?[index])
                                                              .subtitle,
                                                        ),
                                                        if (index != (appBloc.accidentDetailsModel?.report?.statusList?.length ?? 0 - 1)) ...{
                                                          const MyDivider(),
                                                          space10Vertical(),
                                                        }
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (userRoleName != Rules.Broker.name) ...[
                                            Visibility(
                                              visible: appBloc.isCreateInspectionButtonShown,
                                              child: PrimaryButton(
                                                text: appTranslation(context).createInspection,
                                                onPressed: () {
                                                  AppBloc.get(context).clearControllers();

                                                  AppBloc.get(context).setInspectionControllers(accidentDetailsModel: appBloc.accidentDetailsModel!);
                                                  //TODO Fix Index ********
                                                  appBloc.changeStackNav(
                                                    index: appBloc.currentSideMenuIndex,
                                                    // index: appBloc.currentStep ==
                                                    //         Steps.created
                                                    //     ? 3
                                                    //     : appBloc.currentStep ==
                                                    //             Steps.bRepair
                                                    //         ? 4
                                                    //         : appBloc.currentStep ==
                                                    //                 Steps.aRepair
                                                    //             ? 5
                                                    //             : appBloc.currentStep ==
                                                    //                     Steps.billing
                                                    //                 ? 6
                                                    //                 : 2,
                                                    isAdd: true,
                                                    widget: CreateInspectionWidget(
                                                      isOpenFromFNOL: true,
                                                      sideMenuPageIndex: appBloc.currentSideMenuIndex,
                                                      // sideMenuPageIndex: appBloc
                                                      //             .currentStep ==
                                                      //         Steps.created
                                                      //     ? 3
                                                      //     : appBloc.currentStep ==
                                                      //             Steps.bRepair
                                                      //         ? 4
                                                      //         : appBloc.currentStep ==
                                                      //                 Steps.aRepair
                                                      //             ? 5
                                                      //             : appBloc.currentStep ==
                                                      //                     Steps.billing
                                                      //                 ? 6
                                                      //                 : 2,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            space10Vertical(),
                                            if (!(appBloc.accidentDetailsModel?.report?.sentToInsurance ?? false)) ...[
                                              // PrimaryButton(
                                              //   text: 'Export Pdf',
                                              //   onPressed: () async {
                                              //     PdfController.exportPdf(
                                              //       pdf: await PdfController.generateFnolPdf(
                                              //         context: context,
                                              //         accidentDetails: appBloc.accidentDetailsModel!,
                                              //         accentedImages: appBloc.accidentImages ?? [],
                                              //         docsImages: appBloc.docsImages ?? [],
                                              //       ),
                                              //     );
                                              //   },
                                              // ),
                                              // space10Vertical(),
                                              PrimaryButton(
                                                text: 'Send Pdf',
                                                isLoading: state is GetInsuranceLoadingState || state is UploadFnolPdfLoadingState,
                                                onPressed: () async {
                                                  appBloc.removeSelectedEmails();
                                                  // Utils.showAlertLoadingIndicator();

                                                  ///* if there is pdf path
                                                  // 1- get Insurance to get Emails
                                                  // 2- select Email and Send Email with this path
                                                  if (appBloc.accidentDetailsModel!.report!.carAccidentReports != null ||
                                                      appBloc.accidentDetailsModel!.report!.carAccidentReports!.isNotEmpty) {
                                                    String? path = appBloc.accidentDetailsModel!.report!.carAccidentReports!
                                                        .firstWhereOrNull((element) => element.report.contains('FNOLWithAi'))
                                                        ?.report;
                                                    if (path != null) {
                                                      appBloc.selectedPdfPath = path;
                                                      appBloc.getInsurance(
                                                        id: appBloc.accidentDetailsModel!.report!.insuranceCompanyId!,
                                                      );
                                                    }
                                                  }

                                                  ///* else
                                                  // call extract voice api without text
                                                  appBloc.extractVoiceController.text = ".";
                                                  appBloc.accidentDetailsModel!.report!.audioCommentWritten = appBloc.extractVoiceController.text;

                                                  // appBloc.updateFnol();

                                                  ///* else
                                                  // 1- create pdf
                                                  // 2- get base 46
                                                  // 3- upload pdf and get the path
                                                  // 4- get Insurance to get Emails
                                                  // 5- select Email and Send Email with this path

                                                  // if (appBloc.selectedPdfPath.isEmpty) {
                                                  //   String firstPagePdfBase64 = await PdfController.getPdfBase64(
                                                  //     pdf: await PdfController.generateFirstPageFnolPdfAndDocsImages(
                                                  //       context: context,
                                                  //       accidentDetails: appBloc.accidentDetailsModel!,
                                                  //       docsImages: appBloc.docsImages ?? [],
                                                  //     ),
                                                  //   );

                                                  //   String secondPagePdfBase64 = await PdfController.getPdfBase64(
                                                  //     // ignore: use_build_context_synchronously
                                                  //     pdf: await PdfController.createFnolpdfAccedentImages(
                                                  //       context: context,
                                                  //       accidentDetails: appBloc.accidentDetailsModel!,
                                                  //       accentedImages: appBloc.accidentImages ?? [],
                                                  //     ),
                                                  //   );
                                                  //   appBloc.uploadFnolPdf(
                                                  //     pdfReportOne: firstPagePdfBase64,
                                                  //     pdfReportTwo: secondPagePdfBase64,
                                                  //   );
                                                  // }
                                                },
                                              ),
                                            ],
                                          ],
                                        ],
                                      ),
                                    ),
                                    space30Horizontal(),
                                    const VerticalDivider(
                                      endIndent: 0,
                                      thickness: 1,
                                      color: borderGrey,
                                      indent: 0,
                                    ),
                                    space10Horizontal(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    appBloc.stepsScreens[Steps.values
                                                        .firstWhere(
                                                          (e) =>
                                                              e.name ==
                                                              appBloc.accidentDetailsModel?.report?.statusList?[appBloc.fnolCurrentIndex],
                                                        )
                                                        .name]!,
                                                    space10Vertical(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                PrimaryButton(
                                                  text: 'Previous',
                                                  width: 120,
                                                  isDisabled: appBloc.fnolCurrentIndex == 0,
                                                  onPressed: () {
                                                    if (appBloc.fnolCurrentIndex != 0) {
                                                      appBloc.goToPreviousStep();
                                                    }
                                                  },
                                                  backgroundColor: Colors.grey,
                                                ),
                                                PrimaryButton(
                                                  text: 'Next',
                                                  width: 120,
                                                  isDisabled:
                                                      appBloc.fnolCurrentIndex == (appBloc.accidentDetailsModel?.report?.statusList?.length ?? 0 - 1),
                                                  onPressed: () {
                                                    if (appBloc.fnolCurrentIndex != appBloc.accidentDetailsModel!.report!.statusList!.length - 1) {
                                                      appBloc.goToNextStep();
                                                    }
                                                  },
                                                  backgroundColor:
                                                      appBloc.fnolCurrentIndex != (appBloc.accidentDetailsModel!.report!.statusList!.length - 1)
                                                          ? Colors.green
                                                          : Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }
}
