import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/controllers/exit_project_controller_m2.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/ExitProject/exit_project_d1_pro_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_m2_pro_screen.dart';
import 'package:imin/views/widgets/popup_item.dart';
import 'package:imin/views/widgets/title_content.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ExitProjectScreen extends StatefulWidget {
  ExitProjectScreen({Key? key}) : super(key: key);

  @override
  _ExitProjectScreenState createState() => _ExitProjectScreenState();
}

class _ExitProjectScreenState extends State<ExitProjectScreen> {
  final exitController = Get.put(ExitProjectController());
  final exitControllerM2 = Get.put(ExitProjectControllerM2());

  @override
  void initState() {
    super.initState();
  }

  TextEditingController findControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    exitController.context = context;

    exitControllerM2.context = context;
    final screenController = Get.put(ScreenController());
    if (screenController.DeviceCurrent == Device.iminM2Pro) {
      return ExitProjectM2ProScreen(
          size: size, exitController: exitControllerM2);
    } else {
      return ExitProjectD1ProScreen(size: size, exitController: exitController);
    }
    // return ExitProjectD1ProScreen(size: size, exitController: exitController);
  }
}
