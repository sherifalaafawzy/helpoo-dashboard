import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/package_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';

import '../../../core/util/widgets/primary_button.dart';

import '../../../core/util/widgets/show_pop_up.dart';
import '../../client_fnol_and_inspection_req/widgets/my_rich_text.dart';

class PackageDetailsScreen extends StatefulWidget {
  final PackageModel packageModel;
  const PackageDetailsScreen({
    super.key,
    required this.packageModel,
  });

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
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
                        text: 'Package Id : ',
                        text2: widget.packageModel.id.toString() ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Package Name : ',
                        text2: widget.packageModel.enName ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Package Description : ',
                        text2: widget.packageModel.enDescription ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Package Fees : ',
                        text2: widget.packageModel.fees.toString() ?? ''),
                    space20Vertical(),
                    MyRichText(
                      text: 'Original Fees : ',
                      text2: widget.packageModel.originalFees.toString() ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                        text: 'Discount Percentage : ',
                        text2:
                            widget.packageModel.discountPercentage.toString() ??
                                ''),
                    space20Vertical(),
                    MyRichText(
                      text: 'Discount after max times : ',
                      text2: widget.packageModel.discountAfterMaxTimes
                              .toString() ??
                          '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Created at : ',
                      text2: widget.packageModel.createdAt ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Is Active : ',
                      text2: widget.packageModel.active.toString() ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Is Private : ',
                      text2: widget.packageModel.private.toString() ?? '',
                    ),
                    space20Vertical(),
                    if (widget.packageModel.corporateCompany != null) ...{
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
                        text2:
                            widget.packageModel.corporateCompany?.enName ?? '',
                      ),
                      space20Vertical(),
                      InkWell(
                        onTap: () {
                          showImageSliderPopUp(
                            context: context,
                            index: 0,
                            images: [
                              widget.packageModel.corporateCompany?.photo ?? ''
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
                                  imageUrl: widget.packageModel.corporateCompany
                                          ?.photo ??
                                      '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      space20Vertical(),
                    },
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
