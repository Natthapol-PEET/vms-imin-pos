import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';
import 'package:imin/models/login_model.dart';

Future loginApi(String user, String password) async {
  try {
    final response = await http.post(
      Uri.parse(ipServer + '/login_guard/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "username": user,
        "password": password,
      }),
    );

    print('response.statusCode: ${response.statusCode}');

    if (response.statusCode == 200) {
      return LoginModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // throw Exception('Failed to load Profile');
      return false;
    }
  } catch (e) {
    print("e: $e");
    return false;
  }
}
