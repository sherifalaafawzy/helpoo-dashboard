import 'package:flutter/material.dart';
import '../../../constants.dart';

class ActionItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  const ActionItem({
    super.key,
    required this.text,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color ?? Theme.of(context).primaryColor,
            size: 22,
          ),
          space5Horizontal(),
          Text(text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color ?? Theme.of(context).primaryColor,
                  )),
        ],
      ),
    );
  }
}
