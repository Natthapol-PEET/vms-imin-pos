import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';
import 'package:imin/models/login_model.dart';

Future changePasswordApi(
    String username, String oldPassword, String newPassword) async {
  try {
    return await http.post(
      Uri.parse(ipServer + '/change_password_guard/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "username": username,
        "old_pass": oldPassword,
        "new_pass": newPassword
      }),
    );

    // print('response.statusCode: ${response.statusCode}');
    // print('response: ${response.body}');

    // print('username:' + username);
    // print('oldPassword:' + oldPassword);
    // print('newPassword:' + newPassword);

    // if (response.statusCode == 200) {
    //   return LoginModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    // } else {
    //   return false;
    return true;
    // }
  } catch (e) {
    print("e: $e");
    return false;
  }
}
