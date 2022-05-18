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

   
  } catch (e) {
    print("e: $e");
    return false;
  }
}
