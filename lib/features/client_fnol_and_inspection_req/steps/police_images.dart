import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/widgets/show_pop_up.dart';

class PoliceImages extends StatelessWidget {
  const PoliceImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: List.generate(
              appBloc.accidentDetailsModel?.policeImages?.length ?? 0,
              (index) {
                return InkWell(
                  onTap: () {
                    showImageSliderPopUp(
                      context: context,
                      index: index,
                      images: appBloc.accidentDetailsModel?.policeImages
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
                                    ?.policeImages?[index].imagePath ??
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
                        //                   ?.policeImages?[index]
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
                                              ?.policeImages?[index]
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
                                                ?.policeImages?[index]
                                                .createdAt ??
                                            '')
                                        .utcToLocalFormat ??
                                    '',
                                // DateTime.parse(appBloc
                                //                 .accidentDetailsModel
                                //                 ?.policeImages?[index]
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
        ],
      );
    });
  }
}
