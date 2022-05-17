import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future registerWalkinApi(String firstname, String lastname, String idCard,
    String code, String homeNumber, String licensePlate) async {
  try {
    final response = await http.post(
      Uri.parse(ipServer + '/login_register_walkinguard'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "firstname": firstname,
        "lastname": lastname,
        "idCard": idCard,
        "code": code,
        "homeNumber": homeNumber,
        "licensePlate": licensePlate,
      }),
    );

    print('response.statusCode: ${response.statusCode}');

    return response.statusCode;

    if (response.statusCode == 200) {
      // return LoginModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // throw Exception('Failed to load Profile');
      return false;
    }
  } catch (e) {
    print("e: $e");
    return false;
  }
}
