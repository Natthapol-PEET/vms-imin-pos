import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RePasswordController extends GetxController {
  var isVisibilityOld = false.obs;
  var isVisibilityNew = false.obs;
  var isVisibilityReNew = false.obs;

  var checkList = [
    CheckPasswordSecret(text: '', color: Colors.white, lenght: 0), // non secret
    CheckPasswordSecret(text: 'อ่อน', color: Colors.red, lenght: 1), // 1
    CheckPasswordSecret(text: 'ปานกลาง', color: Colors.yellow, lenght: 2), // 2
    CheckPasswordSecret(
        text: 'เยี่ยม', color: Colors.green, lenght: 3), // 3 secret
  ];

  var check = CheckPasswordSecret(text: '', color: Colors.white, lenght: 0).obs;

  // @override
  // void onInit() {
  //   check.value = checkList[0];
  //   super.onInit();
  // }

  void onChangeNewPassword(v) {
    if (v.length == 0) {
      check.value = checkList[0];
    } else if (v.length == 1) {
      check.value = checkList[1];
    } else if (v.length == 2) {
      check.value = checkList[2];
    } else {
      check.value = checkList[3];
    }
  }
}

class CheckPasswordSecret {
  String text;
  Color color;
  int lenght;

  CheckPasswordSecret({
    this.text = "",
    this.color = Colors.white,
    this.lenght = 0,
  });
}
