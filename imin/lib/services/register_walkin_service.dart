import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future registerWalkinApi(String code, String idCard, String homeNumber,
    String licensePlate, int guardId, String token) async {
  try {
    final response = await http.post(
      Uri.parse(ipServerIminService + '/register_walkin/'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, String>{
        "code": code,
        "idCard": idCard,
        "home_number": homeNumber,
        "licensePlate": licensePlate,
        "guardId": guardId.toString(),
      }),
    );

    print('response.statusCode: ${response.statusCode}');

    return response;

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
