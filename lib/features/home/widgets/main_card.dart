import 'package:flutter/material.dart';
import '../../../core/util/widgets/primary_padding.dart';


class MainCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const MainCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 260,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: PrimaryPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_outlined,
              color: Colors.white,
              size: 60,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 70,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
