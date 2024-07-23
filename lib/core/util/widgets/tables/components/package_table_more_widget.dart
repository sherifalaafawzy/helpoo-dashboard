import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';
import 'action_item.dart';

class PackageTableMoreWidget extends StatefulWidget {
  final Function()? onViewTap;
  final Function()? onUsersTap;
  final Function()? onPromoCodesUsersTap;

  // final AccidentReportModel accidentReportModel;

  const PackageTableMoreWidget({
    super.key,
    required this.onViewTap,
    required this.onUsersTap,
    this.onPromoCodesUsersTap,
  });

  @override
  State<PackageTableMoreWidget> createState() => _PackageTableMoreWidgetState();
}

class _PackageTableMoreWidgetState extends State<PackageTableMoreWidget> {
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
                  PopupMenuItem(
                    value: 2,
                    child: const ActionItem(
                      text: 'Users',
                      icon: Icons.people,
                    ),
                    onTap: () => widget.onUsersTap!(),
                  ),
                  if (widget.onPromoCodesUsersTap != null)
                    PopupMenuItem(
                      value: 3,
                      child: const ActionItem(
                        text: 'Promo Codes Users',
                        icon: Icons.people,
                      ),
                      onTap: () => widget.onPromoCodesUsersTap!(),
                    ),
                ],
              ).then((value) {
                if (value != null) {}
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
