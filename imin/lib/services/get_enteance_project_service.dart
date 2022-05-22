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
      return json.decode(utf8.decode(v));
    }

    var list1 = response.body;
    var list2 = responseWhitelist.body;
    var list3 = responseBlacklist.body;
    List<dynamic> dataAll = [];
    List<String> resAll = [];
    resAll.add(list1);
    resAll.add(list2);
    resAll.add(list3);
    for (var item in resAll) {
      for (var i in decodeFunc(item)) {
        // print(decodeFunc2(i));
        // print(i.home_number);
        dataAll.add(i);
      }
    }
    //////////
    var dataAll2 = json.decode(utf8.decode(response.bodyBytes));
    var listData2 = json.decode(utf8.decode(responseWhitelist.bodyBytes));
    var listData3 = json.decode(utf8.decode(responseBlacklist.bodyBytes));
    dataAll2.add(listData2);
    dataAll2.add(listData3);
    // print(dataAll2);
    // List<dynamic> values = <dynamic>[];
    // values = dataAll;
    // if (values.length > 0) {
    //   for (int i = 0; i < values.length; i++) {
    //     if (values[i] != null) {
    //       Map<String, dynamic> map = values[i];
    //       // _postList .add(Post.fromJson(map));
    //       // print('Id-------${map['home_id']}');
    //     }
    //   }
    // }
    return dataAll2;
  } catch (e) {
    print("e: $e");
    return false;
  }
}
