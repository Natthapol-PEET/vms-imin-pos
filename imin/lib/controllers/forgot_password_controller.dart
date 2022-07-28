import 'dart:async';
import 'dart:convert';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/request_recovery_password_service.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:path/path.dart';

class ForgotPasswordController extends GetxController {
  var emailValue = ''.obs;
  var checkEmail = false.obs;

  clear() {
    emailValue.value = '';
  }

  void requestEmail(context) async {
    EasyLoading.show(status: 'โหลดข้อมูล...');
    var response = await requestRecoveryPasswordApi(emailValue.value);
    // print(jsonDecode(response.body));
    Map<String, dynamic> json = jsonDecode(response.body);
    print(json['message']);
    if (response.statusCode == 200 &&
        json['detail'] == 'Send link to E-mail Successful') {
      // print('response.statusCode: ${response.statusCode}');
      // if (response.statusCode == 200) {
      EasyLoading.dismiss();
      // EasyDialog(
      //   closeButton: false,
      //   height: 200,
      //   width: 590,
      //   contentList: [
      //     // title
      //     Text(
      //       "ลืมรหัสผ่าน",
      //       style: TextStyle(
      //         fontFamily: fontRegular,
      //         fontSize: 24,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     Divider(
      //       color: dividerColor,
      //       thickness: 1,
      //     ),
      //     SizedBox(height: 20),
      //     Text(
      //       "ระบบได้ส่งข้อความไปที่อีเมล ${emailValue.value} ",
      //       style: TextStyle(
      //         fontFamily: fontRegular,
      //         fontSize: 20,
      //       ),
      //     ),

      //     SizedBox(height: 20),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         RoundButton(
      //           title: "ตกลง",
      //           press: () => {clear(), Get.toNamed('/login')},
      //         ),
      //         SizedBox(width: 20),
      //         // RoundButtonOutline(
      //         //   title: "ยกเลิก",
      //         //   press: () => Get.back(),
      //         // ),
      //       ],
      //     ),
      //   ],
      // ).show(context);
      checkEmail(false);
      EasyLoading.showSuccess(
          'ระบบได้ส่งลิงก์สำหรับเปลี่ยนรหัสผ่านไปยังอีเมลของคุณ');
      Timer(Duration(seconds: 1), () {
        Get.toNamed('/login');
      });
      return;
    }
    if (json['detail'] == 'Invalid E-mail Address') {
      EasyLoading.showError('อีเมลไม่ถูกต้อง');
    } else {
      EasyLoading.showError(json['detail']);
    }
    // EasyLoading.showError('ads');
  }
}
