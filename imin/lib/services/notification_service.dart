import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future sendNotification(
    String license, String fullname, bool isEntrance) async {
  String uri = domainName + '/notification/';

  /* 
          "title": "แจ้งเตือนจากป้อม รปภ.",
          "body": "ทะเบียนหมายเลข กดกดกด เข้าโครงการ",
          "data": {"Class": "guard", "home_id": "1"}
  */
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2ODQ4OTc2NjcsImlhdCI6MTY1MzM2MTY2Nywic3ViIjoibmF0dGhhcG9sNTkzQGdtYWlsLmNvbSJ9.9xcZRbxwUfMrO36WDyXk3IXrixiYfN5U6b4xSr5ejZY";
  String text;

  if(fullname == "null null" && license == "") return;

  if (isEntrance) {
    text = fullname == " "
        ? "ทะเบียนหมายเลข $license เข้าโครงการ"
        : "คุณ $fullname เข้าโครงการ";
  } else {
    text = fullname == " "
        ? "ทะเบียนหมายเลข $license ออกจากโครงการ"
        : "คุณ $fullname ออกจากโครงการ";
  }

  try {
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(
        <String, dynamic>{
          "title": "แจ้งเตือนจากป้อม รปภ.",
          "body": text,
          "data": {
            "Class": "guard",
            "home_id": "1",
          }
        },
      ),
    );

    return response.statusCode;
    // return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print("e: $e");
    return false;
  }
}
