import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen_d1_pro.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen_m2.dart';
import 'package:imin/views/screens/EntranceProject/upload_personal_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_screen.dart';
import 'package:imin/views/widgets/title_content.dart';

class EntranceProjectScreen extends StatefulWidget {
  EntranceProjectScreen({Key? key}) : super(key: key);

  @override
  _EntranceProjectScreenState createState() => _EntranceProjectScreenState();
}

class _EntranceProjectScreenState extends State<EntranceProjectScreen> {
  final entranceController = Get.put(EntranceProjectController());
  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());

  syncFunction() async {
    // controller.getDataEntrance(); //Allist
    entranceController.getEntranceData(); // 3 list
  }

  @override
  void initState() {
    // syncFunction();
    super.initState();
  }

  TextEditingController findControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    entranceController.context = context;
    final screenController = Get.put(ScreenController());
    if (screenController.DeviceCurrent == Device.iminM2Pro) {
      return EntranceProjectScreenM2();
    } else {
      return EntranceProjectScreenM2();
    }
  }
}
