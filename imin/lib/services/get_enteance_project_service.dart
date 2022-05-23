import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';
import 'package:imin/models/login_model.dart';

Future getEntranceProjectApi(String token) async {
  String uri = ipServer + '/visitorlist_log/';
  String uriWhitelist = ipServer + '/whitelist_log/';
  String uriBlacklist = ipServer + '/blacklist_log/';

  try {
    // final loginModel = LoginModel.token;
    final response = await http.get(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final responseWhitelist = await http.get(
      Uri.parse(uriWhitelist),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final responseBlacklist = await http.get(
      Uri.parse(uriBlacklist),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    // var responseAll =
    //     json.decode(response.body) +
    //         json.decode(responseWhitelist.body) +
    //         json.decode(responseBlacklist.body);
    // [...response.body, ...resporesponseWhitelistnse.body, ...responseBlacklist.body, ...].expand((x) => x).toList();

    decodeFunc(v) {
      return json.decode(v);
    }

    decodeFunc2(v) {
      return utf8.decode(v);
    }

    List<dynamic> dataAll = [];
    List<String> resAll = [];
    //////////
    var dataAll2 = decodeFunc2(response.bodyBytes);
    var listData2 = decodeFunc2(responseWhitelist.bodyBytes);
    var listData3 = decodeFunc2(responseBlacklist.bodyBytes);
    resAll.add(dataAll2);
    resAll.add(listData2);
    resAll.add(listData3);
    for (var item in resAll) {
      for (var i in decodeFunc(item)) {
        // print(decodeFunc2(i));
        // print(i.home_number);
        dataAll.add(i);
      }
    }
    return dataAll;
  } catch (e) {
    print("e: $e");
    return false;
  }
}
