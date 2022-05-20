import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future registerWalkinApi(String code, String homeNumber, String licensePlate,
    int guardId) async {
  try {
    final response = await http.post(
      Uri.parse(ipServerIminService + '/register_walkin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "code": code,
        "homeNumber": homeNumber,
        "licensePlate": licensePlate,
        "guardId": guardId.toString(),
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
