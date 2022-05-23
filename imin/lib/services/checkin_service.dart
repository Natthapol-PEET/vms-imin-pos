import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';
import 'package:imin/models/login_model.dart';

Future checkInApi(String listStatus, String listId, String homeId,
    String dateIn, String token) async {
  try {
    print('listStatus ${listStatus}');
    print('listId ${listId}');
    print('homeId ${homeId}');
    print('dateIn ${dateIn}');
    return true;
    // final response = await http.post(
    //   Uri.parse(ipServer + '/guardhouse_checkin/'),
    //   headers: <String, String>{
    //     "Content-Type": "application/json",
    //     "Authorization": "Bearer $token",
    //   },
    //   body: jsonEncode(<String, String>{
    //     "classname": listStatus, "class_id": listId, "datetime_in": dateIn
    //   }),
    // );

    // print('response.statusCode: ${response.statusCode}');

    // if (response.statusCode == 200) {
    //   return LoginModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    // } else {
    //   // throw Exception('Failed to load Profile');
    //   return false;
    // }
  } catch (e) {
    print("e: $e");
    return false;
  }
}
