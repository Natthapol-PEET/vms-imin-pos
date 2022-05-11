import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/data/account.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/account_model.dart';
import 'package:imin/models/login_model.dart';
import 'package:imin/services/login_service.dart';
import 'package:imin/services/profile_servicec.dart';
import 'package:imin/views/widgets/bg_image.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_text_form_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final expandController = Get.put(ExpansionPanelController());
  final onWillPopController = Get.put(OnWillPopController());

  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Dialog Exit App
    onWillPopController.context = context;

    return WillPopScope(
      onWillPop: onWillPopController.onWillPop,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Row(
            children: [
              BgImage(),
              Container(
                width: size.width / 2,
                height: size.height,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                color: themeBgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      "assets/images/Artani-Logo-Security.png",
                      height: size.height * 0.3,
                      fit: BoxFit.fitHeight,
                    ),

                    // E-mail
                    // Password
                    Container(
                      // margin: EdgeInsets.only(top: size.height * 0.05),
                      child: Form(
                        // key: _formKey,
                        child: Obx(
                          () => Column(
                            children: [
                              RoundTextFormField(
                                icon: Icons.person_outline,
                                textTitle: "ชื่อผู้ใช้",
                                textController: controller.usernameControl,
                                invalid: controller.userCheck.value,
                                initialValue: controller.username.value,
                                onChange: (v) =>
                                    controller.usernameControl.value.text = v,
                              ),
                              if (!controller.userCheck.value) ...[
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '*กรุณากรอกชื่อผู้ใช้',
                                        style: TextStyle(
                                          fontFamily: fontRegular,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              RoundTextFormField(
                                icon: Icons.lock_outline,
                                textTitle: "รหัสผ่าน",
                                isVisibility: controller.isVisibility.value,
                                onClickVisibility: () => controller.isVisibility
                                    .value = !controller.isVisibility.value,
                                textController: controller.passwordControl,
                                invalid: controller.passwordCheck.value,
                                initialValue: controller.password.value,
                                onChange: (v) =>
                                    controller.passwordControl.value.text = v,
                              ),
                              if (!controller.passwordCheck.value) ...[
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '*กรุณากรอกรหัสผ่าน',
                                        style: TextStyle(
                                          fontFamily: fontRegular,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),

                    // remember & forget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  value: controller.isRememberAccount.value,
                                  activeColor: hilightTextColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return hilightTextColor;
                                    }
                                    return Colors.white;
                                  }),
                                  onChanged: (bool? v) {
                                    if (v == true) {
                                      controller.isRememberAccount.value = true;
                                    } else {
                                      controller.isRememberAccount.value =
                                          false;
                                    }
                                  }),
                            ),
                            Text(
                              "จดจำบัญชีของฉัน",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: fontRegular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed('forgot_password'),
                          child: Text(
                            "ลืมรหัสผ่าน?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: fontRegular,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Button
                    SizedBox(height: size.height * 0.008),
                    RoundButton(
                      title: 'เข้าสู่ระบบ',
                      press: () async {
                        bool check = false;

                        if (controller.usernameControl.value.text == "") {
                          controller.userCheck(false);
                          check = true;
                        } else {
                          controller.userCheck(true);
                        }

                        if (controller.passwordControl.value.text == "") {
                          controller.passwordCheck(false);
                          check = true;
                        } else {
                          controller.passwordCheck(true);
                        }

                        if (check) return;

                        var data = await loginApi(
                            controller.usernameControl.value.text,
                            controller.passwordControl.value.text);

                        if (data is LoginModel &&
                            controller.isRememberAccount.value) {
                          var account = AccountModel(
                            id: 1,
                            username: controller.usernameControl.value.text,
                            password: controller.passwordControl.value.text,
                          );
                          Account().updateAccount(account);

                          // print(data.profilePath);
                          // var image = await getProfileImage(data.profilePath);
                          // print(image.runtimeType);

                          // EasyLoading.addStatusCallback((status) {
                          //   // print('EasyLoading Status $status');
                          //   Timer(Duration(seconds: 2),
                          //       () => EasyLoading.dismiss());
                          // });
                          // EasyLoading.show(status: 'loading...');

                          Get.toNamed('/expansion_panel');
                          expandController.setDefaultValues();
                        }

                        // print(data.token);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
