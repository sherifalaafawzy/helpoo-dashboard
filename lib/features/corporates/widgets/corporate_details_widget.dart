import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/corporates/corporates_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../client_fnol_and_inspection_req/widgets/my_rich_text.dart';

class CorporateDetails extends StatefulWidget {
  final Rows corporateModel;

  const CorporateDetails({
    super.key,
    required this.corporateModel,
  });

  @override
  State<CorporateDetails> createState() => _CorporateDetailsState();
}

class _CorporateDetailsState extends State<CorporateDetails> {
  @override
  void initState() {
    // if (!widget.isFromDriversMap) {
    //   appBloc.getCurrentActiveServiceRequest(isRefresh: false);
    // }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose ==========');
    // appBloc.serviceRequestListModel = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 1000,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    space10Vertical(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonWidget(
                          onTap: () {
                            debugPrint('************* pop');
                            appBloc.changeStackNav(
                                index: appBloc.currentSideMenuIndex,
                                isAdd: false);
                          },
                        ),
                        // const Spacer(),
                        Text(
                          'Corporate Details',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                      ],
                    ),
                    space20Vertical(),
                    MyRichText(
                        text: 'ID : ',
                        text2: widget.corporateModel.id.toString() ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'English Name : ',
                        text2: widget.corporateModel.enName ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Arabic Name : ',
                        text2: widget.corporateModel.arName ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Discount Ratio : ',
                        text2:
                            widget.corporateModel.discountRatio?.toString() ??
                                ''),
                    space20Vertical(),
                    MyRichText(
                      text: 'Start Date : ',
                      text2: widget.corporateModel.startDate ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                        text: 'End Dat : ',
                        text2: widget.corporateModel.endDate ?? ''),
                    space20Vertical(),
                    MyRichText(
                      text: 'Cash : ',
                      text2: widget.corporateModel.cash?.toString() ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Card To Driver : ',
                      text2:
                          widget.corporateModel.cardToDriver?.toString() ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Online : ',
                      text2: widget.corporateModel.online?.toString() ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Created At : ',
                      text2: '${widget.corporateModel.createdAt}',
                    ),
                    space20Vertical(),
                    PrimaryButton(
                      text: 'Done',
                      onPressed: () {
                        appBloc.changeStackNav(
                          index: appBloc.currentSideMenuIndex,
                          isAdd: false,
                        );
                      },
                    ),
                    space20Vertical(),
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
