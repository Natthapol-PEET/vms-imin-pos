import 'dart:io';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button.dart';

EasyDialog alertSystemOnConnectInternet() {
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
        "ระบบมีปัญหา กรุณาลองใหม่อีกครั้งในภายหลัง",
        style: TextStyle(
          fontFamily: fontRegular,
          fontSize: 20,
        ),
      ),
      SizedBox(height: 20),
      RoundButton(
        title: "ตกลง",
        press: () => exit(0),
      ),
    ],
  );
}
