import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class BackButtonWidget extends StatelessWidget {
  final Function()? onTap;

  const BackButtonWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (onTap != null) {
              debugPrint('************* pop 2');
              onTap!();
            } else {
              AppBloc.get(context).changeStackNav(
                index: appBloc.currentSideMenuIndex,
                isAdd: false,
              );
            }
          },
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 35,
            width: 35,
            margin: const EdgeInsetsDirectional.only(end: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: RotatedBox(
              quarterTurns: isEnglish ? 2 : 0,
              child: const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
