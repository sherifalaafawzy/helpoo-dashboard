import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/packages_promo_codes_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';

import '../../../core/util/widgets/primary_button.dart';

import '../../../core/util/widgets/show_pop_up.dart';
import '../../client_fnol_and_inspection_req/widgets/my_rich_text.dart';

class PackagesPromoCodesDetailsScreen extends StatefulWidget {
  final Promoes promoCode;
  const PackagesPromoCodesDetailsScreen({
    super.key,
    required this.promoCode,
  });

  @override
  State<PackagesPromoCodesDetailsScreen> createState() =>
      _PackagesPromoCodesDetailsScreenState();
}

class _PackagesPromoCodesDetailsScreenState
    extends State<PackagesPromoCodesDetailsScreen> {
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
                        const Spacer(),
                        Text(
                          'Package Details',
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
                        text: 'Promo Id : ',
                        text2: widget.promoCode.id.toString() ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Promo Name : ',
                        text2: widget.promoCode.name ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Promo Value : ',
                        text2: widget.promoCode.value ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Start Date : ',
                        text2: widget.promoCode.startDate ?? ''),
                    space20Vertical(),
                    MyRichText(
                      text: 'Expiry Date : ',
                      text2: widget.promoCode.expiryDate ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                        text: 'Discount Percentage : ',
                        text2:
                            '${widget.promoCode.percentage.toString() ?? ''} %'),
                    space20Vertical(),
                    MyRichText(
                      text: 'SMS : ',
                      text2: widget.promoCode.sMS ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Created at : ',
                      text2: widget.promoCode.createdAt ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Is Active : ',
                      text2: widget.promoCode.active.toString() ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Is Private : ',
                      text2: widget.promoCode.private.toString() ?? '',
                    ),
                    space20Vertical(),
                    if (widget.promoCode.corporateCompany != null) ...{
                      Text(
                        'Corporate Info',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      ),
                      space20Vertical(),
                      MyRichText(
                        text: 'Corporate Name : ',
                        text2: widget.promoCode.corporateCompany?.enName ?? '',
                      ),
                      space20Vertical(),
                      InkWell(
                        onTap: () {
                          showImageSliderPopUp(
                            context: context,
                            index: 0,
                            images: [
                              widget.promoCode.corporateCompany?.photo ?? ''
                            ],
                          );
                        },
                        child: SizedBox(
                          width: 300,
                          height: 200,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 200,
                                child: MyNetworkImage(
                                  imageUrl: widget
                                          .promoCode.corporateCompany?.photo ??
                                      '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      space20Vertical(),
                    },
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
