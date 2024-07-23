import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';
import '../../main.dart';

class Utils {
  Utils._();

  static String covertStringToTimeStamp(String date) {
    if (DateTime.tryParse(date) == null) {
      debugPrint('XXXXX -->> Date is not in correct format');
      return date;
    }
    return DateTime.parse(date).millisecondsSinceEpoch.toString();
  }

  static String covertTimeStampToString(String timeStamp) {
    if (int.tryParse(timeStamp) == null) {
      debugPrint('XXXXX -->> TimeStamp is not in correct format');
      return timeStamp;
    }
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp)).toString();
  }

  //* Default loading for the app
  static Future showAlertLoadingIndicator({BuildContext? context}) {
    return showDialog(
      context: context ?? navigatorKey.currentContext!,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(.3),
      useSafeArea: false,
      builder: (_) => glassMorphismBox(
        sigmaX: 5,
        sigmaY: 5,
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  ///* Return a `GlassMorphismBox`
  static Widget glassMorphismBox({
    required Widget child,
    double? sigmaX,
    double? sigmaY,
    BorderRadius? borderRadiusObject,
    double? borderRadius,
  }) {
    return ClipRRect(
      borderRadius:
          borderRadiusObject ?? (borderRadius == null ? BorderRadius.zero : BorderRadius.circular(borderRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX ?? 10, sigmaY: sigmaY ?? 10),
        child: child,
      ),
    );
  }
}

///* Print in log shortcuts `log()`
printMeLog(dynamic data) {
  if (kDebugMode) {
    log(data.toString(), time: DateTime.now());
  }
}

///* Print in 'red color' in log
void printWarning(dynamic data) {
  if (kDebugMode) {
    logger.warning(data);
  }
}
