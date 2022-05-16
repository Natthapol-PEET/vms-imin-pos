import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RePasswordController extends GetxController {
  var isVisibilityOld = false.obs;
  var isVisibilityNew = false.obs;
  var isVisibilityReNew = false.obs;
  var warningText = CheckWarning(text: '').obs;
  var oldPasswordValue = ''.obs;
  var newPasswordValue = ''.obs;
  var confirmNewPasswordValue = ''.obs;
  var checkMatchPassword = true.obs;
  var checkValidatePassword = false.obs;

// var warningText = (String).obs;

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
  void onChangeOldPassword(v) {
    oldPasswordValue.value = v;
    checkValidate();
  }

  void onChangeNewPassword(v) {
    var levelPassword = 0;
    newPasswordValue.value = v;
    bool validateCharactor(String value) {
      String pattern =
          // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
          r'^(?=.*?[A-Z])(?=.*?[a-z]).{0,}$';
      RegExp regExp = new RegExp(pattern);
      return regExp.hasMatch(value);
    }

    bool validateNumber(String value) {
      String pattern =
          // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
          r'^(?=.*?[0-9]).{0,}$';
      RegExp regExp = new RegExp(pattern);
      return regExp.hasMatch(value);
    }

    if (v.length >= 8 && v.length <= 32) {
      levelPassword = levelPassword + 1;
    } else {
      warningText.value =
          CheckWarning(text: '*รหัสผ่านต้องมีตัวอักษร 8 ถึง 32 ตัวอักษร');
    }
    if (validateCharactor(v)) {
      levelPassword = levelPassword + 1;
    } else {
      warningText.value =
          CheckWarning(text: '*รหัสผ่านต้องมีตัวอักษรพิมพ์เล็กและพิมพ์ใหญ่');
    }
    if (validateNumber(v)) {
      levelPassword = levelPassword + 1;
    } else {
      warningText.value =
          CheckWarning(text: '*รหัสผ่านต้องมีอย่างน้อยหนึ่งหมายเลข');
    }
    if (v.length == 0) {
      check.value = checkList[0];
    } else if (levelPassword == 1) {
      check.value = checkList[1];
    } else if (levelPassword == 2) {
      check.value = checkList[2];
    } else if (levelPassword == 3) {
      check.value = checkList[3];
      warningText.value = CheckWarning(text: '');
    } else {
      check.value = checkList[1];
    }
    if (newPasswordValue.value == confirmNewPasswordValue.value) {
      checkMatchPassword.value = true;
    } else {
      checkMatchPassword.value = false;
    }
    checkValidate();
  }

  void onChangeNewPasswordAgain(v) {
    confirmNewPasswordValue.value = v;
    if (newPasswordValue.value == v) {
      checkMatchPassword.value = true;
    } else {
      checkMatchPassword.value = false;
    }
    checkValidate();
  }

  void checkValidate() {
    if (checkMatchPassword.value == true &&
        oldPasswordValue.value.length > 0 &&
        check.value == checkList[3]) {
      checkValidatePassword.value = true;
    } else {
      checkValidatePassword.value = false;
    }
  }

  void resetPassword() {
    // print('oldPass:' + oldPasswordValue.value);
    // print('newPass:' + newPasswordValue.value);
    if (checkValidatePassword.value == true) {
      print('success');
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

class CheckWarning {
  String text;

  CheckWarning({
    this.text = "",
  });
}
