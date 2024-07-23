import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/service_request/get_all.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/shared_widgets/empty_text.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../client_fnol_and_inspection_req/widgets/my_rich_text.dart';
import '../../../main.dart';


class ServiceRequestDetails extends StatefulWidget {
  final ServiceRequestModel serviceRequestModel;
  final bool isFromDriversMap;

  const ServiceRequestDetails({
    super.key,
    required this.serviceRequestModel,
    this.isFromDriversMap = false,
  });

  @override
  State<ServiceRequestDetails> createState() => _ServiceRequestDetailsState();
}

class _ServiceRequestDetailsState extends State<ServiceRequestDetails> {
  @override
  void initState() {
    // if (!widget.isFromDriversMap) {
    //   appBloc.getCurrentActiveServiceRequest(isRefresh: false);
    // }
    appBloc.getRequestTimeAndDistance(req: widget.serviceRequestModel);
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
      listener: (context, state) {
        if (widget.isFromDriversMap) {
          if (state is GetCurrentActiveServiceRequestSuccessState) {
            if (state.isThereActiveServiceRequest) {
              // appBloc.openNewTab(Routes.tracking);
              appBloc.openGoogleMapsTab();
            } else {
              HelpooInAppNotification.showMessage(
                message: "Can't track request with this status",
              );
            }
          }
        }
      },
      builder: (context, state) {
        // if (appBloc.isGetOneServiceReqLoading) {
        //   return Center(
        //     child: CupertinoActivityIndicator(
        //       radius: 14,
        //       color: HexColor(mainColor),
        //     ),
        //   );
        // }

        if (widget.serviceRequestModel.client == null) {
          return Column(
            children: [
              space20Vertical(),
              Row(
                children: [
                  space20Horizontal(),
                  const BackButtonWidget(),
                  const Spacer(),
                ],
              ),
              space100Vertical(),
              const EmptyText(
                emptyText: 'No Client Data',
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.isFromDriversMap ? MediaQuery.of(navigatorKey.currentContext!).size.width * 0.7 : 1000,
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
                          onTap: widget.isFromDriversMap
                              ? () {
                                  debugPrint('************* pop');
                                  Navigator.pop(navigatorKey.currentContext!);
                                }
                              : null,
                        ),
                        // const Spacer(),
                        Text(
                          'Service Request Details',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                        ),
                        // const Spacer(),
                        widget.isFromDriversMap
                            ? PrimaryButton(
                                text: 'Tracking',
                                width: 100,
                                onPressed: () {
                                  appBloc.setSelectedServiceRequestModel(model: widget.serviceRequestModel, isForActiveService: true);
                                  appBloc.setSelectedServiceRequestId(id: widget.serviceRequestModel.id, isForActiveService: true);
                                },
                              )
                            : const SizedBox(
                                width: 50,
                              ),
                      ],
                    ),
                    space20Vertical(),
                    MyRichText(text: 'Request Id : ', text2: widget.serviceRequestModel.id.toString() ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Remaining Time : ',
                        text2: !widget.serviceRequestModel.isRequestActive || appBloc.localDuration.contains("-")
                            ? "0"
                            : appBloc.localDuration ?? 'Loading...'),
                    space20Vertical(),
                    MyRichText(
                        text: 'Remaining Distance : ',
                        text2: !widget.serviceRequestModel.isRequestActive || appBloc.localDistance.contains("-")
                            ? "0"
                            : appBloc.localDistance ?? 'Loading...'),
                    space20Vertical(),
                    MyRichText(text: 'Client Name : ', text2: widget.serviceRequestModel.client?.user?.name ?? ''),
                    space20Vertical(),
                    MyRichText(text: 'Client Phone : ', text2: widget.serviceRequestModel.client?.user?.phoneNumber ?? ''),
                    space20Vertical(),
                    MyRichText(text: 'Client Address : ', text2: widget.serviceRequestModel.location?.clientAddress ?? ''),
                    space20Vertical(),
                    MyRichText(
                      text: 'Corporate : ',
                      text2: widget.serviceRequestModel.corporateCompany != null ? widget.serviceRequestModel.corporateCompany!.enName ?? '' : '--',
                    ),
                    space20Vertical(),
                    MyRichText(text: 'Destination : ', text2: widget.serviceRequestModel.location?.destinationAddress ?? ''),
                    space20Vertical(),
                    MyRichText(
                        text: 'Car Details : ',
                        text2:
                            '${appBloc.manufacturersModel?.manufacturers.where((element) => element.id == widget.serviceRequestModel.car?.manufacturerId).first.enName ?? ''} ${appBloc.carsModel?.models.where((element) => element.id == widget.serviceRequestModel.car?.carModelId).first.enName ?? ''} ${widget.serviceRequestModel.car?.year.toString() ?? ''} (${widget.serviceRequestModel.car?.plateNumber ?? ''})'),
                    space20Vertical(),
                    MyRichText(
                      text: 'Created at : ',
                      text2: widget.serviceRequestModel.createdAt ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Payment Status : ',
                      text2: widget.serviceRequestModel.paymentStatus ?? '',
                    ),
                    if (widget.serviceRequestModel.adminComment != null) ...{
                      space20Vertical(),
                      MyRichText(
                        text: 'Comments : ',
                        text2: widget.serviceRequestModel.adminComment ?? '--',
                      ),
                    },
                    space20Vertical(),
                    MyRichText(
                      text: 'Payment Method : ',
                      text2: widget.serviceRequestModel.paymentMethod ?? '',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Waiting Time : ',
                      text2: (widget.serviceRequestModel.waitingTime ?? 0).toString(),
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Waiting Fees : ',
                      text2: (widget.serviceRequestModel.waitingFees ?? 0).toString(),
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Original Fees : ',
                      text2: '${widget.serviceRequestModel.originalFees}',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Fees : ',
                      text2: '${widget.serviceRequestModel.fees}',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Admin Discount : ',
                      text2: appBloc.getHighestDiscount([
                        widget.serviceRequestModel.adminDiscount ?? 0,
                        widget.serviceRequestModel.discountPercentage ?? 0,
                        // serviceRequestModel.policyAndPackage!.packageDiscountPercentage ?? 0
                      ]),
                      // '${widget.serviceRequestModel.adminDiscount ?? ''} %',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Approved By : ',
                      text2: widget.serviceRequestModel.adminDiscountApprovedBy ?? '--',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Discount Reason : ',
                      text2: widget.serviceRequestModel.adminDiscountReason ?? '--',
                    ),
                    space20Vertical(),
                    MyRichText(
                      text: 'Package Name',
                      text2: widget.serviceRequestModel.clientPackage?.package?.arName ?? '--',
                    ),
                    space30Vertical(),
                    Text(
                      'Driver Details',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    ),
                    space20Vertical(),
                    MyRichText(text: 'Driver Name : ', text2: widget.serviceRequestModel.driver?.user?.name ?? ''),
                    space20Vertical(),
                    MyRichText(text: 'Driver Phone : ', text2: widget.serviceRequestModel.driver?.user?.phoneNumber ?? ''),
                    space20Vertical(),
                    MyRichText(text: 'Driver Type : ', text2: widget.serviceRequestModel.driver?.user?.phoneNumber ?? ''),
                    space20Vertical(),
                    MyRichText(text: 'Wench Plate number : ', text2: widget.serviceRequestModel.vehicle?.VecPlate ?? ''),
                    space20Vertical(),
                    MyRichText(text: 'Wench Number : ', text2: '${widget.serviceRequestModel.vehicle?.VecNum ?? ''}'),
                    space20Vertical(),
                    MyRichText(text: 'Wench Type : ', text2: widget.serviceRequestModel.vehicle?.vehicleType?.typeName ?? ''),
                    space20Vertical(),
                    widget.serviceRequestModel.serviceRequestPhotos?.isNotEmpty ?? false
                        ? Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            children: List.generate(
                              widget.serviceRequestModel.serviceRequestPhotos?.length ?? 0,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    showImageSliderPopUp(
                                      context: context,
                                      index: index,
                                      images: widget.serviceRequestModel.serviceRequestPhotos!.map((e) => e.images![0]).toList(),
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
                                            imageUrl: widget.serviceRequestModel.serviceRequestPhotos?[index].images?[0] ?? '',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    space20Vertical(),
                    PrimaryButton(
                      text: 'Done',
                      onPressed: () {
                        widget.isFromDriversMap
                            ? Navigator.pop(navigatorKey.currentContext!)
                            : appBloc.changeStackNav(
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
