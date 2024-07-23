import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';

enum StepType { current, previous, next }

class StepWidget extends StatefulWidget {
  StepType stepType;
  String title;
  String subtitle;
  bool isCurrent;
  bool isNext;
  bool isPrevious;
  Function()? onTap;

  StepWidget({
    super.key,
    this.stepType = StepType.next,
    required this.title,
    required this.subtitle,
    this.isCurrent = false,
    this.isNext = false,
    this.isPrevious = false,
    this.onTap,
  });

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = widget.stepType == StepType.previous;
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isPrevious ? Colors.green : Colors.white,
                border: Border.all(
                  width: 3,
                  color: widget.isNext
                      ? Colors.green.withOpacity(0.3)
                      : Colors.green,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.check,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
            space10Horizontal(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        widget.isNext ? FontWeight.w400 : FontWeight.w700,
                    color: widget.isNext ? secondaryGrey : secondary,
                  ),
                ),
                space5Vertical(),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
