import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../extensions/days_extensions.dart';

class PrimaryCheckbox extends StatefulWidget {
  final ValueChanged<bool>? valueChanged;
  final double? size;
  final double? iconSize;
  final bool initialValue;
  final String? text;
  final IconData? icon;

  const PrimaryCheckbox({
    super.key,
    this.valueChanged,
    this.size,
    this.iconSize,
    this.initialValue = false,
    this.text,
    this.icon,
  });

  @override
  State<PrimaryCheckbox> createState() => _PrimaryCheckboxState();
}

class _PrimaryCheckboxState extends State<PrimaryCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.valueChanged != null) {
          widget.valueChanged!.call(widget.initialValue);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // height: widget.size ?? 22,
        // width: widget.size ?? 22,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 6.br,
          border: Border.all(
              width: widget.initialValue ? 2 : 1,
              color: widget.initialValue ? mainColorHex : Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon ?? Icons.check,
              size: widget.iconSize ?? 20,
              color: widget.initialValue ? mainColorHex : Colors.grey.shade400,
            ),
            space5Horizontal(),
            Text(
              widget.text ?? '',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 18.0,
                    color: widget.initialValue
                        ? mainColorHex
                        : Colors.grey.shade400,
                    fontWeight:
                        widget.initialValue ? FontWeight.w500 : FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
