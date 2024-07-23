import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class PrimaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final Color? backgroundColor;
  final bool? isSquared;
  final double? length;
  final double? iconSize;
  final Color? iconColor;

  const PrimaryIconButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.backgroundColor,
    this.isSquared = true,
    this.length = 35,
    this.iconSize = 20,
    this.iconColor = whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length,
      height: length,
      child: Card(
        margin: EdgeInsets.zero,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: backgroundColor == Colors.white ? mainColorHex : Colors.transparent
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: InkWell(
          onTap: isDisabled
              ? null
              : () {
            if (!isLoading) {
              onPressed();
            }
          },
          child: isLoading
              ? const CupertinoActivityIndicator(color: Colors.white)
              : Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
