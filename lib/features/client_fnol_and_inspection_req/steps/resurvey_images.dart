import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/days_extensions.dart';

import '../../../core/util/widgets/show_pop_up.dart';
import '../widgets/my_rich_text.dart';

class ResurveyImages extends StatelessWidget {
  const ResurveyImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyRichText(
            text: 'Name: ',
            text2: appBloc
                    .accidentDetailsModel?.report?.resurveyLocation?[0].name ??
                '',
          ),
          space15Vertical(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resurvey Location: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    launchMap(
                      latitude: appBloc.accidentDetailsModel?.report
                              ?.resurveyLocation?.last.lat ??
                          0,
                      longitude: appBloc.accidentDetailsModel?.report
                              ?.resurveyLocation?.last.lng ??
                          0,
                    );
                  },
                  child: Text(
                    appBloc.accidentDetailsModel?.report?.resurveyLocation?.last
                            .address ??
                        ''.toLowerCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(color: Colors.blueAccent, offset: Offset(0, -3))
                      ],
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blueAccent,
                      decorationThickness: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          space30Vertical(),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: List.generate(
              appBloc.accidentDetailsModel?.resurveyImages?.length ?? 0,
              (index) {
                return InkWell(
                  onTap: () {
                    showImageSliderPopUp(
                      context: context,
                      index: index,
                      images: appBloc.accidentDetailsModel?.resurveyImages
                              ?.map((e) => e.imagePath ?? '')
                              .toList() ??
                          [],
                    );
                  },
                  child: SizedBox(
                    width: 250,
                    height: 400,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 400,
                          child: MyNetworkImage(
                            imageUrl: appBloc.accidentDetailsModel
                                    ?.resurveyImages?[index].imagePath ??
                                '',
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
                        //                   ?.resurveyImages?[index]
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
                            children: [
                              Expanded(
                                child: Text(
                                  appBloc.imagesInstructions[appBloc
                                              .accidentDetailsModel
                                              ?.resurveyImages?[index]
                                              .imageName ??
                                          ''.toLowerCase()] ??
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
                                DateTime.parse(appBloc
                                                .accidentDetailsModel
                                                ?.resurveyImages?[index]
                                                .createdAt ??
                                            '')
                                        .utcToLocalFormat ??
                                    '',
                                // DateTime.parse(appBloc
                                //                 .accidentDetailsModel
                                //                 ?.resurveyImages?[index]
                                //                 .createdAt ??
                                //             '')
                                //         .timedayMonthYearFormat ??
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
          ),
          space30Vertical(),
          //********************************* PDF File *********************************
          // const MyRichText(
          //   text: 'PDF File : ',
          //   text2: '',
          //   isHeader: true,
          // ),
          // space15Vertical(),
          // false ?? false
          //     ? Wrap(
          //         spacing: 20,
          //         runSpacing: 20,
          //         crossAxisAlignment: WrapCrossAlignment.start,
          //         alignment: WrapAlignment.start,
          //         runAlignment: WrapAlignment.start,
          //         children: List.generate(
          //           appBloc.accidentDetailsModel?.report?.carAccidentReports
          //                   ?.length ??
          //               0,
          //           (index) {
          //             return Container(
          //               padding: const EdgeInsets.all(20),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 border: Border.all(
          //                   width: 1,
          //                   color: Colors.grey,
          //                 ),
          //               ),
          //               child: InkWell(
          //                 onTap: () async {
          //                   if (!await launchUrl(
          //                     Uri.parse(
          //                         //TODO : add pdf file url
          //                         '$imagesBaseUrl'),
          //                   )) {
          //                     throw Exception(
          //                       'Could not launch',
          //                     );
          //                   }
          //                 },
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Icon(
          //                       Icons.picture_as_pdf,
          //                       size: 50,
          //                       color: mainColorHex,
          //                     ),
          //                     space5Vertical(),
          //                     Text(
          //                       'Click to Open File',
          //                       style: TextStyle(
          //                         color: mainColorHex,
          //                         fontSize: 16,
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       )
          //     : const EmptyText(emptyText: 'No Files Uploaded'),
          // space30Vertical(),
        ],
      );
    });
  }
}
