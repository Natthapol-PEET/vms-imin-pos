import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/data/account.dart';
import 'package:imin/models/account_model.dart';
import 'package:imin/services/change_password_service.dart';

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

  var check = CheckPasswordSecret(text: '', color: Colors.white, lenght: 0).obs;
  var checkList = [
    CheckPasswordSecret(text: '', color: Colors.white, lenght: 0), // non secret
    CheckPasswordSecret(text: 'อ่อน', color: Colors.red, lenght: 1), // 1
    CheckPasswordSecret(text: 'ปานกลาง', color: Colors.yellow, lenght: 2), // 2
    CheckPasswordSecret(
        text: 'เยี่ยม', color: Colors.green, lenght: 3), // 3 secret
  ];

  clear() {
    isVisibilityOld.value = false;
    isVisibilityNew.value = false;
    isVisibilityReNew.value = false;
    warningText.value = CheckWarning(text: '');
    oldPasswordValue.value = '';
    newPasswordValue.value = '';
    confirmNewPasswordValue.value = '';
    checkMatchPassword.value = true;
    checkValidatePassword.value = false;
    check.value = CheckPasswordSecret(text: '', color: Colors.white, lenght: 0);
  }

// var warningText = (String).obs;

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

  void resetPassword(String username) async {
    EasyLoading.show(status: 'loading...');

    // print('oldPass:' + oldPasswordValue.value);
    // print('newPass:' + newPasswordValue.value);
    if (checkValidatePassword.value == true) {
      print('username: $username');
      var response = await changePasswordApi(
          username, oldPasswordValue.value, newPasswordValue.value);
      // print('success: ${checkChangePassword}');

      Map<String, dynamic> json = jsonDecode(response.body);

      print('json: $json');

      if (response.statusCode == 200) {
        final loginController = Get.put(LoginController());

        var account = AccountModel(
          id: 1,
          username: loginController.username.value,
          password: loginController.password.value,
          isLogin: 0,
        );
        await Account().updateAccount(account);

        Timer(Duration(seconds: 1), () {
          EasyLoading.dismiss();
          Get.toNamed('/login');
        });

        return;
      }

      EasyLoading.showError(json['detail']);
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
