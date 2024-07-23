import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/remote/api_endpoints.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/shared_widgets/empty_text.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../audio_player/my_audio.dart';
import '../widgets/my_rich_text.dart';
import 'package:url_launcher/url_launcher.dart';

// collection package

class FNOLStep extends StatefulWidget {
  const FNOLStep({
    super.key,
  });

  @override
  State<FNOLStep> createState() => _FNOLStepState();
}

class _FNOLStepState extends State<FNOLStep> {
  var imagesController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.extractVoiceController.text = appBloc.accidentDetailsModel?.report?.audioCommentWritten ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        List<String> pdfs = appBloc.accidentDetailsModel?.report?.carAccidentReports
                ?.where((element) => element.report.contains('FNOLWithAi') || element.report.contains('AiCalc'))
                .map((e) => e.report)
                .toList() ??
            [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //********************************* PDF File *********************************
            const MyRichText(
              text: 'PDF File : ',
              text2: '',
              isHeader: true,
            ),
            space15Vertical(),

            (pdfs.isNotEmpty)
                ? Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      pdfs.length,
                      (index) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (!await launchUrl(
                                Uri.parse('$imagesBaseUrl${pdfs[index]}'),
                              )) {
                                throw Exception(
                                  'Could not launch',
                                );
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  size: 50,
                                  color: mainColorHex,
                                ),
                                space5Vertical(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Click to Open File',
                                      style: TextStyle(
                                        color: mainColorHex,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      pdfs[index].contains('AiCalc') ? 'تقرير التلفيات بالذكاء الاصطناعي' : 'تقرير الحادث',
                                      style: TextStyle(
                                        color: mainColorHex,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const EmptyText(emptyText: 'No Files Uploaded'),
            space30Vertical(),
            //********************************* Docs Images *********************************
            const MyRichText(
              text: 'Docs Images : ',
              text2: '',
              isHeader: true,
            ),
            space15Vertical(),

            appBloc.accidentDetailsModel?.mainImages?.isNotEmpty ?? false
                ? Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      appBloc.docsImages?.length ?? 0,
                      (index) {
                        return InkWell(
                          onTap: () {
                            showImageSliderPopUp(
                              context: context,
                              index: index,
                              images: appBloc.docsImages!.map((e) => e.imagePath!).toList(),
                            );
                          },
                          child: SizedBox(
                            width: 380,
                            height: 200,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                SizedBox(
                                  width: 380,
                                  height: 200,
                                  child: MyNetworkImage(
                                    imageUrl: '${appBloc.docsImages?[index].imagePath}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 380,
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          appBloc.imagesInstructions[appBloc.docsImages?[index].imageName ?? ''.toLowerCase()] ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      space10Horizontal(),
                                      Text(
                                        DateTime.parse(appBloc.docsImages![index].createdAt!).utcToLocalFormat ?? '',
                                        // DateTime.parse(appBloc.docsImages![index].createdAt!).timedayMonthYearFormat ??
                                        //     '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const EmptyText(),
            space30Vertical(),
            //********************************* Accident Images *********************************
            const MyRichText(
              text: 'Accident Images : ',
              text2: '',
              isHeader: true,
            ),
            space15Vertical(),

            appBloc.accidentDetailsModel?.mainImages?.isNotEmpty ?? false
                ? Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      appBloc.accidentImages?.length ?? 0,
                      (index) {
                        return InkWell(
                          onTap: () {
                            showImageSliderPopUp(
                              context: context,
                              index: index,
                              images: appBloc.accidentImages!.map((e) => e.imagePath!).toList(),
                            );
                          },
                          child: SizedBox(
                            width: 380,
                            height: 200,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                SizedBox(
                                  width: 380,
                                  height: 200,
                                  child: MyNetworkImage(
                                    imageUrl: '${appBloc.accidentImages?[index].imagePath}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 380,
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          appBloc.imagesInstructions['img${appBloc.accidentImages?[index].imageName ?? ''.toLowerCase()}'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      space10Horizontal(),
                                      Text(
                                        DateTime.parse(appBloc.accidentImages![index].createdAt!).utcToLocalFormat ?? '',
                                        // DateTime.parse(appBloc.accidentImages![index].createdAt!).timedayMonthYearFormat ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const EmptyText(),
            space30Vertical(),
            //********************************* Extra Images *********************************
            const MyRichText(
              text: 'Extra Images : ',
              text2: '',
              isHeader: true,
            ),
            space15Vertical(),
            appBloc.accidentDetailsModel?.additional?.isNotEmpty ?? false
                ? Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      appBloc.accidentDetailsModel?.additional?.length ?? 0,
                      (index) {
                        return InkWell(
                          onTap: () {
                            showImageSliderPopUp(
                              context: context,
                              index: index,
                              images: appBloc.accidentDetailsModel!.additional!.map((e) => e.imagePath!).toList(),
                            );
                          },
                          child: SizedBox(
                            width: 380,
                            height: 200,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                SizedBox(
                                  width: 380,
                                  height: 200,
                                  child: MyNetworkImage(
                                    imageUrl: appBloc.accidentDetailsModel?.additional?[index].imagePath ?? '',
                                  ),
                                ),
                                // Container(
                                //   height: 30,
                                //   width: double.infinity,
                                //   color: Colors.black.withOpacity(0.5),
                                //   child: Center(
                                //     child: Text(
                                //       appBloc.imagesInstructions[appBloc
                                //                   .accidentDetailsModel
                                //                   ?.additional?[index]
                                //                   .imageName ??
                                //               ''.toLowerCase()] ??
                                //           '',
                                //       style: const TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 30,
                                  width: 380,
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          appBloc.imagesInstructions[
                                                  appBloc.accidentDetailsModel?.additional?[index].imageName ?? ''.toLowerCase()] ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      space10Horizontal(),
                                      Text(
                                        DateTime.parse(appBloc.accidentDetailsModel?.additional?[index].createdAt ?? '').utcToLocalFormat ?? '',
                                        // DateTime.parse(appBloc.accidentDetailsModel?.additional?[index].createdAt ?? '').timedayMonthYearFormat ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const EmptyText(),
            space30Vertical(),
            const MyRichText(
              text: 'Description : ',
              text2: '',
              isHeader: true,
            ),
            space10Vertical(),
            if ((appBloc.accidentDetailsModel?.report?.comment == null || appBloc.accidentDetailsModel?.report?.comment == '') &&
                (appBloc.accidentDetailsModel?.report?.commentUser == null || appBloc.accidentDetailsModel?.report?.commentUser == '')) ...{
              const EmptyText(emptyText: 'No Description'),
            },
            Text(
              appBloc.accidentDetailsModel?.report?.comment ?? '',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            space10Vertical(),
            appBloc.accidentDetailsModel?.report?.commentUser != null && appBloc.accidentDetailsModel?.report?.commentUser != ''
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 400,
                        child: MyAudioPlayer(
                          url: '$imagesBaseUrl${appBloc.accidentDetailsModel?.report?.commentUser ?? ''}',
                        ),
                      ),
                      PrimaryButton(
                        text: 'Extract Voice',
                        width: 200,
                        onPressed: () {
                          appBloc.showExtractVoiceFailed = true;
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),

            if (appBloc.extractVoiceController.text.isNotEmpty || appBloc.showExtractVoiceFailed) ...[
              space20Vertical(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryFormField(
                      controller: appBloc.extractVoiceController,
                      validationError: '',
                      label: 'Extract Voice',
                      infiniteLines: true,
                    ),
                  ),
                  space10Horizontal(),
                  PrimaryButton(
                    text: 'Done',
                    width: 150,
                    isLoading: appBloc.isUpdateFnolLoading,
                    onPressed: () {
                      appBloc.updateFnol();
                    },
                  ),
                ],
              ),
            ],
            space30Vertical(),
          ],
        );
      },
    );
  }
}
