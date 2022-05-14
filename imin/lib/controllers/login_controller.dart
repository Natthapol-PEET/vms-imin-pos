import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imin/data/account.dart';
import 'package:imin/models/account_model.dart';
import 'package:imin/models/login_model.dart';

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

  Future getAccount() async {
    List<AccountModel> data = await Account().accounts();
    print('getAccount: $data');

    username.value = data[0].username;
    password.value = data[0].password;

    usernameControl.value.text = data[0].username;
    passwordControl.value.text = data[0].password;
    isLogin.value = data[0].isLogin;
  }
}
