import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import '../../../helpoo_in_app_notifications.dart';

class TableTextWithSubTextItem extends StatelessWidget {
  final String text;
  final String subText;
  final bool isCentered;
  const TableTextWithSubTextItem(
      {super.key,
      required this.text,
      this.isCentered = false,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    return isCentered
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Column(
                children: [
                  InkWell(
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
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  space5Vertical(),
                  InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: subText));

                      HelpooInAppNotification.showSuccessMessage(
                        duration: const Duration(seconds: 1),
                        message: 'Data copied to clipboard',
                      );
                    },
                    child: Tooltip(
                      message: 'Click to copy',
                      child: Text(
                        subText,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                InkWell(
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
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                space5Vertical(),
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: subText));

                    HelpooInAppNotification.showSuccessMessage(
                      duration: const Duration(seconds: 1),
                      message: 'Data copied to clipboard',
                    );
                  },
                  child: Tooltip(
                    message: 'Click to copy',
                    child: Text(
                      subText,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
