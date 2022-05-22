import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future getExitDataApi() async {
  String uri = ipServerIminService + '/exit_project';

  try {
    final response = await http.get(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token",
      },
    );

    return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print("e: $e");
    return false;
  }
}
