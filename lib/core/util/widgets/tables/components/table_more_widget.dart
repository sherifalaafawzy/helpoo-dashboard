import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';
import '../../../enums.dart';
import 'action_item.dart';

class TableMoreWidget extends StatefulWidget {
  final Function()? onViewTap;
  final Function()? onTripTap;
  final Function()? onLinkTap;
  final Function()? onWaitingTimeTap;
  final Function()? onCommentTap;
  final Function()? onCloseTap;
  final Function()? onCloseWithPaymentTap;
  final Function()? onShareTrackingTap;
  final Function()? onChangeDriverTap;
  final Function()? onAutoChangeDriverTap;
  final Function()? onChangeStatus;
  final Function()? onChangePayment;
  final Function()? onRefuseCancelReq;
  final Function()? onApproveCancelReq;
  final Function()? onLiveStreamTap;
  final Function()? onClick;

  final bool isRunning;

  final bool isOpenFromCorporate;

  final bool isPaymentPaid;
  final bool trackTabVisible;
  final bool shareTrackingLinkTabVisible;
  final bool showRefuseCancelReq;
  final bool showApproveCancelReq;

  // final AccidentReportModel accidentReportModel;

  const TableMoreWidget({
    super.key,
    this.onLiveStreamTap,
    this.onClick,
    required this.onViewTap,
    required this.onTripTap,
    required this.onLinkTap,
    required this.onWaitingTimeTap,
    required this.onCommentTap,
    required this.onChangeDriverTap,
    required this.onAutoChangeDriverTap,
    this.onRefuseCancelReq,
    this.onApproveCancelReq,
    this.onShareTrackingTap,
    this.onChangeStatus,
    this.onChangePayment,
    this.onCloseTap,
    this.onCloseWithPaymentTap,
    this.isRunning = false,
    this.isOpenFromCorporate = false,
    this.isPaymentPaid = false,
    this.trackTabVisible = true,
    this.shareTrackingLinkTabVisible = true,
    this.showRefuseCancelReq = false,
    this.showApproveCancelReq = false,
  });

  @override
  State<TableMoreWidget> createState() => _TableMoreWidgetState();
}

class _TableMoreWidgetState extends State<TableMoreWidget> {
  GlobalKey threeDotMenuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: IconButton(
            key: threeDotMenuKey,
            onPressed: () {
              if (widget.onClick != null) {
                widget.onClick!();
              }
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  getXPosition(threeDotMenuKey),
                  getYPosition(threeDotMenuKey) + 45,
                  getXPosition(threeDotMenuKey),
                  getYPosition(threeDotMenuKey),
                ),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
                items: [
                  PopupMenuItem(
                    value: 1,
                    child: const ActionItem(
                      text: 'View',
                      icon: Icons.visibility,
                    ),
                    onTap: () => widget.onViewTap!(),
                  ),
                  if (widget.trackTabVisible)
                    PopupMenuItem(
                      value: 2,
                      child: const ActionItem(
                        text: 'Tracking',
                        icon: Icons.car_crash,
                      ),
                      onTap: () => widget.onTripTap!(),
                    ),
                  if (widget.isRunning && !widget.isOpenFromCorporate && !widget.isPaymentPaid) // 30784 > discount tab issue
                    const PopupMenuItem(value: 3, child: ActionItem(text: 'Discount', icon: Icons.discount)
                        // onTap: () => widget.onLinkTap!(),
                        ),
                  if (widget.isRunning && !widget.isOpenFromCorporate)
                    const PopupMenuItem(
                      value: 5,
                      child: ActionItem(text: 'Waiting Time', icon: Icons.timer),
                    ),
                  if (!widget.isOpenFromCorporate)
                    const PopupMenuItem(
                      value: 6,
                      child: ActionItem(text: 'Comment', icon: Icons.comment),
                    ),
                  if (widget.isRunning && !widget.isOpenFromCorporate)
                    const PopupMenuItem(
                      value: 7,
                      child: ActionItem(text: 'Force Change Driver', icon: Icons.person),
                    ),

                  if (widget.isRunning && !widget.isOpenFromCorporate)
                    const PopupMenuItem(
                      value: 20,
                      child: ActionItem(text: 'Auto Change Driver', icon: Icons.person),
                    ),

                  if (!widget.isOpenFromCorporate && userRoleName == Rules.Super.name)
                    const PopupMenuItem(
                      value: 9,
                      child: ActionItem(text: 'Change Payment', icon: Icons.payment),
                    ),
                  if (widget.isRunning && !widget.isOpenFromCorporate)
                    const PopupMenuItem(
                      value: 8,
                      child: ActionItem(text: 'Change Status', icon: Icons.change_circle),
                    ),
                  if (widget.showApproveCancelReq)
                    const PopupMenuItem(
                      value: 16,
                      child: ActionItem(
                        text: 'Approve Cancel Request',
                        icon: Icons.close,
                      ),
                    ),
                  if (widget.showRefuseCancelReq)
                    const PopupMenuItem(
                      value: 15,
                      child: ActionItem(
                        text: 'Refuse Cancel Request',
                        icon: Icons.close,
                      ),
                    ),
                  if (widget.isRunning)
                    const PopupMenuItem(
                      value: 4,
                      child: ActionItem(
                        text: 'Cancel',
                        icon: Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  if (widget.isRunning && !widget.isOpenFromCorporate)
                    const PopupMenuItem(
                      value: 10,
                      child: ActionItem(
                        text: 'Cancel With Payment',
                        icon: Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  if (widget.shareTrackingLinkTabVisible)
                    const PopupMenuItem(
                      value: 11,
                      child: ActionItem(text: 'Share Tracking Link', icon: Icons.ios_share_outlined),
                    ),
                  if (userRoleName == Rules.Super.name && !(appBloc.selectedServiceRequestModel?.camUrl != null) && !(appBloc.selectedServiceRequestModel?.status?.toLowerCase() == 'done' || appBloc.selectedServiceRequestModel?.status?.toLowerCase() == 'cancel'))
                    const PopupMenuItem(
                      value: 12,
                      child: ActionItem(
                        text: 'Live Stream',
                        icon: Icons.video_call_outlined,
                        color: Colors.red,
                      ),
                    ),
                ],
              ).then((value) {
                if (value != null) {
                  if (value == 3) {
                    widget.onLinkTap!();
                  }
                  if (value == 5) {
                    widget.onWaitingTimeTap!();
                  }
                  if (value == 6) {
                    widget.onCommentTap!();
                  }
                  if (value == 7) {
                    widget.onChangeDriverTap!();
                  }

                  if (value == 20) {
                    widget.onAutoChangeDriverTap!();
                  }

                  if (value == 4) {
                    widget.onCloseTap!();
                  }
                  if (value == 8) {
                    widget.onChangeStatus!();
                  }
                  if (value == 9) {
                    widget.onChangePayment!();
                  }
                  if (value == 10) {
                    widget.onCloseWithPaymentTap!();
                  }
                  if (value == 11) {
                    widget.onShareTrackingTap!();
                  }
                  if (value == 15) {
                    widget.onRefuseCancelReq!();
                  }
                  if (value == 16) {
                    widget.onApproveCancelReq!();
                  }
                  if (value == 12) {
                    widget.onLiveStreamTap!();
                  }
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: mainColorHex,
            ),
          ),
        );
      },
    );
  }
}
