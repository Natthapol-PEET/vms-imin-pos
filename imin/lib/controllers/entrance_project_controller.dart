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
    dataEntrance.value = await getEntranceProjectApi(token);
    print(dataEntrance.value[1].hashCode["home_id"]);
    // print('getData: ${getData}');
    // print('getDataEn');
  }
}
