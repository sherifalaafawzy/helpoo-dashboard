import 'package:flutter/material.dart';

class ConfirmTextComponent extends StatelessWidget {
  final String headline;
  final String text;
  final Color? color;
  const ConfirmTextComponent(
      {super.key, required this.headline, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$headline: ',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: color?.withOpacity(0.6) ?? Colors.grey,
                )),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color ?? Colors.black,
              ),
        ),
      ],
    );
  }
}
