import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../helpoo_in_app_notifications.dart';

class TableTextItem extends StatelessWidget {
  final String text;
  final bool isCentered;
  final int maxLines;
  const TableTextItem({super.key, required this.text, this.isCentered = false, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return isCentered
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: text));

                  HelpooInAppNotification.showSuccessMessage(
                    duration: const Duration(seconds: 1),
                    message: 'Data copied to clipboard',
                  );
                },
                child: Tooltip(
                  message: 'Click to copy',
                  child: Text(
                    text,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Clipboard.setData(ClipboardData(text: text));

                HelpooInAppNotification.showSuccessMessage(
                  duration: const Duration(seconds: 1),
                  message: 'Data copied to clipboard',
                );
              },
              child: Tooltip(
                message: 'Click to copy',
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          );
  }
}
