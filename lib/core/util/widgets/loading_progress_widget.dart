import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class LoadingProgressWidget extends StatelessWidget {
  const LoadingProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'جاري رفع الملفات',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
              ),
              space20Vertical(),
              CupertinoActivityIndicator(
                color: Theme.of(context).primaryColor,
                radius: 20,
              ),
              Text(
                '${appBloc.doneFileUploaded}%',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
              ),
              space20Vertical(),
            ],
          ),
        );
      },
    );
  }
}
