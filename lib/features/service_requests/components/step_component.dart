import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';

class StepComponent extends StatelessWidget {
  final bool isDone;
  final bool isCurrentStep;
  final bool isFirstStep;
  final String stepNumber;
  final String stepTitle;
  final String stepSubtitle;
  const StepComponent({
    super.key,
    required this.isDone,
    this.isFirstStep = false,
    required this.stepNumber,
    required this.isCurrentStep,
    required this.stepTitle,
    required this.stepSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFirstStep)
          Container(
            width: 100,
            height: 2,
            color: isCurrentStep
                ? Colors.green
                : isDone
                    ? Colors.green
                    : Colors.green.withOpacity(0.3),
          ),
        space5Horizontal(),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isDone ? Colors.green : Colors.white,
            border: isDone
                ? null
                : Border.all(
                    color: isCurrentStep
                        ? Colors.green
                        : Colors.green.withOpacity(0.3),
                    width: 2),
            shape: BoxShape.circle,
          ),
          child: isDone
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                )
              : null,
        ),
        space5Horizontal(),
        Text(
          stepNumber,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: isCurrentStep
                    ? regularBlack
                    : isDone
                        ? regularBlack
                        : textGrayColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        space5Horizontal(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stepTitle,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: textColor)),
            space3Vertical(),
            Text(stepSubtitle,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: textColor)),
          ],
        ),
      ],
    );
  }
}
