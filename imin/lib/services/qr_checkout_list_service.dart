import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future qrCheckOutListService(
    {required String token, required String dataQr}) async {
  String uri = ipServerForQrApi + '/checkout_list/';

  try {
    // final loginModel = LoginModel.token;
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, String>{"qrGenId": dataQr}),
    );
    // log('data result : ${utf8.decode(response.bodyBytes)}');
    // log('url result : ${utf8.decode(response.bodyBytes)}');
    // return json.decode(utf8.decode(response.bodyBytes));
     return json.decode(response.body);
  } catch (e) {
    print("e: $e");
    return false;
  }
}
