import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../network/remote/api_endpoints.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class SMS {
  static Future<bool> sendSingleSMS(String mobile, String message) async {
    try {
      var url = "https://$ENVIRONMENT.helpooapp.net/api/v2/sms/sendSms";

      var data = {
        "mobileNumber": mobile,
        "message": message,
      };

      var res = await http.post(Uri.parse(url), body: data, headers: {
        "authentication": "Bearer $token",
      });
      var resbody;
      resbody = json.decode(res.body);
      if (resbody['status'] == "success") {
        return true;
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
