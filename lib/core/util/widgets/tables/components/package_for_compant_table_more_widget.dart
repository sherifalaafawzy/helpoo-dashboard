import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';
import 'action_item.dart';

class PackageForCompanyTableMoreWidget extends StatefulWidget {
  final Function()? onUsersTap;

  // final AccidentReportModel accidentReportModel;

  const PackageForCompanyTableMoreWidget({
    super.key,
    required this.onUsersTap,
  });

  @override
  State<PackageForCompanyTableMoreWidget> createState() => _PackageForCompanyTableMoreWidgetState();
}

class _PackageForCompanyTableMoreWidgetState extends State<PackageForCompanyTableMoreWidget> {
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
                      text: 'Users',
                      icon: Icons.people,
                    ),
                    onTap: () => widget.onUsersTap!(),
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
