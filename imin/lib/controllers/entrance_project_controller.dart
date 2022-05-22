import 'dart:convert';

import 'package:get/get.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/models/login_model.dart';
import 'package:imin/services/get_enteance_project_service.dart';

class EntranceProjectController extends GetxController {
  var dataEntrance = [].obs;

  var logg = Get.put(LoginController());

  String token = "";

  @override
  void onInit() {
    token = logg.dataProfile.token;

    super.onInit();
  }

  getDataEntrance() async {
    try {
      dataEntrance.value = await getEntranceProjectApi(token);
      List<dynamic> values = <dynamic>[];
      values = dataEntrance;
      Map<String, dynamic> map = dataEntrance[0];
      // var encoded = utf8.encode(dataEntrance[0]['license_plate']);
      // var test = String.fromCharCodes(dataEntrance[1]['id_card']);
      // dataEntrance.map((element) => print('element :${element[0]}'));
      // print('getData: ${map['home_id']}');
      print('/${dataEntrance[0]['license_plate']}/');
      // print(encoded);
      // print('test: ${String.fromCharCodes(map['id_card'])}');
    } catch (e) {
      print('error:${e}');
    }
  }
}
