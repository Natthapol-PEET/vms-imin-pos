import 'dart:async';
import 'dart:io';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';

class OnWillPopController extends GetxController {
  var context;

  Future<bool> onWillPop() async {
    return EasyDialog(
          closeButton: false,
          height: 240,
          width: 450,
          contentList: [
            // title
            Text(
              "แจ้งเตือน",
              style: TextStyle(
                fontFamily: fontRegular,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: dividerColor,
              thickness: 1,
            ),
            SizedBox(height: 20),
            Text(
              "คุณต้องการออกจากแอปใช่หรือไม่ ?",
              style: TextStyle(
                fontFamily: fontRegular,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(
                  title: "ยืนยัน",
                  press: () async {
                    EasyLoading.show(status: 'กรุณารอสักครู่...');

                    Timer(Duration(seconds: 1), () {
                      EasyLoading.dismiss();
                      exit(0);
                    });
                  },
                ),
                SizedBox(width: 20),
                RoundButtonOutline(
                  title: "ยกเลิก",
                  press: () => Get.back(),
                ),
              ],
            ),
          ],
        ).show(context) ??
        false;
  }
}
