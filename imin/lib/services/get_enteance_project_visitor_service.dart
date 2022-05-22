import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';
import 'package:imin/models/login_model.dart';

Future getEntranceProjectVisitorApi(String token) async {
  String uri = ipServer + '/visitorlist_log/';

  try {
    // final loginModel = LoginModel.token;
    final response = await http.get(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    
    return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print("e: $e");
    return false;
  }
}
