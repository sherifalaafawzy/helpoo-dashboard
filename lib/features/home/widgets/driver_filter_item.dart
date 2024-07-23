import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverFilterItem extends StatelessWidget {
  final String title;
  final bool isOn;
  final Function(bool) onChanged;
  const DriverFilterItem({
    super.key,
    required this.title,
    required this.isOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          height: 30,
          child: FittedBox(
            fit: BoxFit.fill,
            child: CupertinoSwitch(
              value: isOn,
              activeColor: Theme.of(context).primaryColor,
              thumbColor: Colors.white,
              onChanged: onChanged,
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
