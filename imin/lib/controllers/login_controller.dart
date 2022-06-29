import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/data/account.dart';
import 'package:imin/models/account_model.dart';
import 'package:imin/models/login_model.dart';
import 'package:imin/services/login_service.dart';
import 'package:imin/views/widgets/not_connect_internet.dart';

class LoginController extends GetxController {
  var isVisibility = false.obs;
  var isRememberAccount = true.obs;

  var userCheck = true.obs;
  var passwordCheck = true.obs;

  var username = "".obs;
  var password = "".obs;
  var isLogin = 0.obs;

  var dataProfile;

  var usernameControl = TextEditingController().obs;
  var passwordControl = TextEditingController().obs;

  Account acc = Account();

  @override
  void onInit() {
    // database
    acc.getDatabase();

    super.onInit();
  }

  Future getAccount() async {
    List<AccountModel> data = await acc.accounts();
    username.value = data[0].username;
    password.value = data[0].password;

    usernameControl.value.text = data[0].username;
    passwordControl.value.text = data[0].password;
    isLogin.value = data[0].isLogin;
  }

  Future login(BuildContext context, expandController) async {
    EasyLoading.show(status: 'กรุณารอสักครู่...');

    bool check = false;

    if (usernameControl.value.text == "") {
      userCheck(false);
      check = true;
    } else {
      userCheck(true);
    }

    if (passwordControl.value.text == "") {
      passwordCheck(false);
      check = true;
    } else {
      passwordCheck(true);
    }

    if (check) {
      EasyLoading.dismiss();
      return;
    }

    dataProfile = await loginApi(
      usernameControl.value.text,
      passwordControl.value.text,
    );
    // print(dataProfile.Response);
    if (dataProfile == 'not call api') {
      EasyLoading.dismiss();
      alertSystemOnConnectInternet().show(context);
      return false;
    }

    if (dataProfile is LoginModel) {
      if (isRememberAccount.value) {
        var account = AccountModel(
          id: 1,
          username: usernameControl.value.text,
          password: passwordControl.value.text,
          isLogin: 1,
        );
        acc.updateAccount(account);
      }

      EasyLoading.dismiss();
      EasyLoading.showSuccess('เข้าสู่ระบบสำเร็จ');
      expandController.setDefaultValues();

      EasyLoading.dismiss();
      Timer(Duration(microseconds: 200), () => Get.toNamed('/expansion_panel'));

      return true;
    } else {
      EasyLoading.dismiss();
      if (json.decode(dataProfile.body)['detail'] ==
          'This user account has been disabled.')
      // print(json.decode(dataProfile.body)['detail']);
      {
        EasyLoading.showError('ผู้ใช้ถูกระงับ');
        return false;
      }
      EasyLoading.showError('ข้อมูลผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
      return false;
    }
  }

  Future logout() async {
    EasyLoading.show(status: 'กรุณารอสักครู่...');

    var account = AccountModel(
      id: 1,
      username: username.value,
      password: password.value,
      isLogin: 0,
    );
    await acc.updateAccount(account);

    Timer(Duration(seconds: 1), () {
      EasyLoading.dismiss();
      Get.toNamed('/login');
    });
  }
}
