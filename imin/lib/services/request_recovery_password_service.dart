import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';
import 'package:imin/models/login_model.dart';

Future requestRecoveryPasswordApi(String email) async {
  try {
    return await http.post(
      Uri.parse(ipServer + '/change_password_guard/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          <String, String>{"email": email, "url": "http://domain.com/"}),
    );

    // print('response.statusCode: ${response.statusCode}');
    // print('response: ${response}');

    print('username:' + email);
    return true;
    // if (response.statusCode == 200) {
    //   return LoginModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    // } else {
    //   return false;
    // }
  } catch (e) {
    print("e: $e");
    return false;
  }
}
