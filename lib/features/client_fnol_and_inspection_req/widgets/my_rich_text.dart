import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';

class MyRichText extends StatelessWidget {
  final String text;
  final String text2;
  final Color? textColor;
  final Color? text2Color;
  final bool isHeader;

  const MyRichText({
    super.key,
    required this.text,
    required this.text2,
    this.textColor,
    this.text2Color,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Clipboard.setData(ClipboardData(text: text2));

        HelpooInAppNotification.showSuccessMessage(
          duration: const Duration(seconds: 1),
          message: '${text.split(':').first.trim()} copied to clipboard',
        );
      },
      child: Tooltip(
        message: 'Click to copy',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.black,
                fontSize: isHeader ? 20 : 16,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            space5Horizontal(),
            Text(
              text2,
              // maxLines: 1,
              // overflow: TextOverflow.fade,
              style: TextStyle(
                color: text2Color ?? Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
