import 'package:flutter/material.dart';
import 'package:helpoo_insurance_dashboard/core/util/constants.dart';

class PrimaryDividerText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const PrimaryDividerText({required this.text, this.textStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        space20Horizontal(),
        Text(text, style: textStyle),
        space20Horizontal(),
        Expanded(
          child: Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey[300],
          ),
        )
      ],
    );
  }
}