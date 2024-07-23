import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';

class ServiceComponent extends StatelessWidget {
  final String serviceName;
  final Function(bool?) onSelectChanged;
  final bool isSelected;
  const ServiceComponent(
      {super.key,
      required this.serviceName,
      required this.onSelectChanged,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(serviceName,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: textColor)),
            space3Horizontal(),
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                onSelectChanged.call(value);
              },
              checkColor: Colors.white,
              activeColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        );
      },
    );
  }
}
