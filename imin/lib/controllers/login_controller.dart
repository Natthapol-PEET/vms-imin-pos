import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imin/data/account.dart';
import 'package:imin/models/account_model.dart';

class LoginController extends GetxController {
  var isVisibility = false.obs;
  var isRememberAccount = true.obs;

  var userCheck = true.obs;
  var passwordCheck = true.obs;

  var username = "".obs;
  var password = "".obs;

  var usernameControl = TextEditingController().obs;
  var passwordControl = TextEditingController().obs;

  Future getAccount() async {
    List<AccountModel> data = await Account().accounts();

    username.value = data[0].username;
    password.value = data[0].password;

    usernameControl.value.text = data[0].username;
    passwordControl.value.text = data[0].password;
  }
}
