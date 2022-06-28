import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/socket_service.dart';
import 'package:imin/views/widgets/bg_image.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_text_form_field.dart';


class LoginScreenD1Pro extends StatelessWidget {
  const LoginScreenD1Pro({
    Key? key,
    required this.onWillPopController,
    required this.size,
    required this.controller,
    required this.expandController,
  }) : super(key: key);

  final OnWillPopController onWillPopController;
  final Size size;
  final LoginController controller;
  final ExpansionPanelController expandController;

  @override
  Widget build(BuildContext context) {
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
                        bool isLogin =
                            await controller.login(context, expandController);
                        if (isLogin) {
                          // init socket
                          SocketService socketService = SocketService();
                          socketService.startSocketClient();
                        }
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
