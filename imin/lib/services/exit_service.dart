import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future getExitDataApi(String token) async {
  String uri = ipServerIminService + '/exit_project/';

  try {
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

Future exitProjectApi(int logId, String token) async {
  String uri = ipServerIminService + '/exit_project/';

  try {
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, int>{
        'logId': logId,
      }),
    );

    return response.statusCode;
    // return json.decode(utf8.decode(response.bodyBytes));
  } catch (e) {
    print("e: $e");
    return false;
  }
}
