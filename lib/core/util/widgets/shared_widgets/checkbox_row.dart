import 'package:flutter/material.dart';
import '../../constants.dart';
import 'primary_checkbox.dart';

class CheckBoxRow extends StatelessWidget {
  final ValueChanged<bool>? valueChanged;
  final bool initialValue;
  final String text;

  const CheckBoxRow({
    super.key,
    this.valueChanged,
    this.initialValue = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PrimaryCheckbox(
          size: 20,
          initialValue: initialValue,
          valueChanged: (value) {
            if (valueChanged != null) {
              valueChanged!.call(value);
            }
          },
        ),
        space10Horizontal(),
        Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 16.0,
                color: secondaryGrey,
                fontWeight: FontWeight.w400,
              ),
        )
      ],
    );
  }
}
