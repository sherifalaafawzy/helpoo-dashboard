import 'dart:async';
import 'dart:convert';
import '../network/remote/api_endpoints.dart';
import '../util/constants.dart';
import '../util/helpoo_in_app_notifications.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class FCM {
  static Future<bool> sendMessage(
      String fcmToken, String title, String body, String id, String type, {retryCount = 5}) async {
    if (retryCount < 0) {
      HelpooInAppNotification.showErrorMessage(
          message: "failed to send notification after 5 retries");
      return false;
    }
    try {
      debugPrint('SEND MESSAGE 1');
      var url = "${baseUrl}fcm/notifyMessage";

      var data = {
        "token": fcmToken,
        "title": title,
        "body": body,
        "type": type,
        "id": id
      };

      debugPrint('fcm body ==>> $data');

      debugPrint('FCM URL ==>> $url');
      debugPrint('Data ==>> $data');
      debugPrint('token ==>> $token');

      var res = await http.post(
        Uri.parse(url),
        body: data,
        headers: {"authentication": "Bearer $token"},
      );
      var resbody;
      resbody = json.decode(res.body);
      debugPrint('SEND MESSAGE FCM Body ==>> $resbody');
      debugPrint('SEND MESSAGE 2');
      if (resbody['status'] == "success") {
        debugPrint('SEND MESSAGE success');
        return true;
      } else {
        debugPrint('SEND MESSAGE failed');
        await Future.delayed(const Duration(seconds: 5));
        sendMessage(fcmToken, title, body, id, type,
            retryCount: retryCount - 1);
      }
    } catch (e) {
      debugPrint('SEND MESSAGE ERROR $e');
      debugPrint(e.toString());
      HelpooInAppNotification.showErrorMessage(message: e.toString());
      await Future.delayed(const Duration(seconds: 5));
      sendMessage(fcmToken, title, body, id, type, retryCount: retryCount - 1);
    }
    return false;
  }

  static Future<void> sendTestNotification() async {
    const String serverToken = '<Your-Server-Key>';
    const String fcmTargetDeviceToken = 'dOlcpobOT-azlMcwX0-E2x:APA91bHPXxbcH-_QCP-Yp57ZtKSnq3eUpavdV4NSu9JB4AZO0SRy28mZEk2vStv3r2a3g256Le6chbacYMUFJ-ap3aWyq5KEpcB_U09c1TyBGNqM5ay1yOrl3mOSw4bxnbv13MYyot20';

    final http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'This is a notification body',
            'title': 'This is a notification title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': fcmTargetDeviceToken,
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Notification not sent');
      print(response.toString());
      // Additionally, you might want to check the response.body for error details.
    }
  }
}
