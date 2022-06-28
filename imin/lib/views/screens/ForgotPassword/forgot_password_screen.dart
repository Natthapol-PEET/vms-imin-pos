import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/forgot_password_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/ForgotPassword/forgot_password_d1_pro_screen.dart';
import 'package:imin/views/screens/ForgotPassword/forgot_password_m2_pro_screen.dart';
import 'package:imin/views/widgets/round_button.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final controller = Get.put(ForgotPasswordController());
  final onWillPopController = Get.put(OnWillPopController());

  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();
  final screenController = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Dialog Exit App
    onWillPopController.context = context;

    return (screenController.DeviceCurrent == Device.iminM2Pro)
        ? ForgotPasswordM2Pro()
        : ForgotPasswordD1Pro();
  }
}
