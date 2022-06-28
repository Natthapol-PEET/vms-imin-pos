import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/socket_service.dart';
import 'package:imin/views/screens/Login/login_D1_Pro_screen.dart';
import 'package:imin/views/screens/Login/login_M2_Pro_screen.dart';
import 'package:imin/views/widgets/bg_image.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_text_form_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final expandController = Get.put(ExpansionPanelController());
  final onWillPopController = Get.put(OnWillPopController());
  final screenController = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Dialog Exit App
    onWillPopController.context = context;

    return (screenController.DeviceCurrent == Device.iminM2Pro)
        ? LoginScreenM2Pro(
            onWillPopController: onWillPopController,
            size: size,
            controller: controller,
            expandController: expandController)
        : LoginScreenD1Pro(
            onWillPopController: onWillPopController,
            size: size,
            controller: controller,
            expandController: expandController);
  }
}
