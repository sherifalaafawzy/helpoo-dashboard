import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class MainScaffold extends StatelessWidget {
  final Widget scaffold;

  const MainScaffold({
    super.key,
    required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Directionality(
          textDirection: AppBloc.get(context).isRtl
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: scaffold,
        );
      },
    );
  }
}
