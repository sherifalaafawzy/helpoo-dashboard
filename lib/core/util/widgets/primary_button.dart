import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final bool isIconButton;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isIconButton = false,
    this.isDisabled = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 43.0,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : () {
                if (!isLoading) {
                  onPressed();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: backgroundColor == Colors.white ? mainColorHex : Colors.transparent
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading && isIconButton)
              const CupertinoActivityIndicator(
                color: Colors.white,
              ),
            if (isIconButton) const Spacer(),
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor),
            ),
            if (isLoading && !isIconButton)
              const SizedBox(
                width: 10,
              ),
            if (isLoading && !isIconButton)
              const CupertinoActivityIndicator(
                color: Colors.white,
              ),
            if (isIconButton) const Spacer(),
            if (isIconButton)
              Icon(
                icon,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
