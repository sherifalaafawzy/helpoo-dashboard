import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/widgets/tables/components/action_item.dart';

class CorporateTableMoreWidget extends StatefulWidget {
  final Function()? onViewTap;
  final Function()? onUsersTap;
  final Function()? onEditTap;
  final Function()? onRequestsTap;

  // final AccidentReportModel accidentReportModel;

  const CorporateTableMoreWidget({
    super.key,
    required this.onViewTap,
    required this.onUsersTap,
    this.onEditTap,
    this.onRequestsTap,
  });

  @override
  State<CorporateTableMoreWidget> createState() =>
      _CorporateTableMoreWidgetState();
}

class _CorporateTableMoreWidgetState extends State<CorporateTableMoreWidget> {
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
                  if (widget.onEditTap != null)
                    PopupMenuItem(
                      value: 3,
                      child: const ActionItem(
                        text: 'Create a request',
                        icon: Icons.create,
                      ),
                      onTap: () => widget.onEditTap!(),
                    ),
                  if (widget.onRequestsTap != null)
                    PopupMenuItem(
                      value: 4,
                      child: const ActionItem(
                        text: 'Requests',
                        icon: Icons.request_page,
                      ),
                      onTap: () => widget.onRequestsTap!(),
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
