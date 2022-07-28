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

class LoginScreenM2Pro extends StatelessWidget {
  const LoginScreenM2Pro({
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
              //  Container(
              //   color: themeBgColor,
              //   height: size.height,
              //   width: size.width,
              //   child: Image.asset(
              //     'assets/images/forgot_password.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Stack(children: [
                Container(
                  height: size.height,
                  width: size.width,
                  color: themeBgColor,
                  child: Image.asset(
                    "assets/images/BG-Login.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    // color: themeBgColor,
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
                                    editIcon: true,
                                    fontSize: normalM2FontSize + 2,
                                    icon: Icons.person_outline,
                                    textTitle: "ชื่อผู้ใช้",
                                    textController: controller.usernameControl,
                                    invalid: controller.loginCheck.value,
                                    initialValue: controller.username.value,
                                    onChange: (v) => {
                                      controller.usernameControl.value.text = v,
                                      controller.checkInput()
                                    },
                                  ),
                                  // if (!controller.userCheck.value) ...[
                                  //   Padding(
                                  //     padding: EdgeInsets.only(top: 5),
                                  //     child: Row(
                                  //       children: [
                                  //         Text(
                                  //           '*กรุณากรอกชื่อผู้ใช้',
                                  //           style: TextStyle(
                                  //             fontFamily: fontRegular,
                                  //             color: Colors.red,
                                  //             fontSize: normalM2FontSize + 2,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ],
                                  RoundTextFormField(
                                    editIcon: true,
                                    icon: Icons.lock_outline,
                                    textTitle: "รหัสผ่าน",
                                    fontSize: normalM2FontSize + 2,
                                    isVisibility: controller.isVisibility.value,
                                    onClickVisibility: () => controller
                                        .isVisibility
                                        .value = !controller.isVisibility.value,
                                    textController: controller.passwordControl,
                                    invalid: controller.loginCheck.value,
                                    initialValue: controller.password.value,
                                    onChange: (v) => {
                                      controller.passwordControl.value.text = v,
                                      controller.checkInput()
                                    },
                                  ),
                                  // if (!controller.passwordCheck.value) ...[
                                  //   Padding(
                                  //     padding: EdgeInsets.only(top: 5),
                                  //     child: Row(
                                  //       children: [
                                  //         Text(
                                  //           '*กรุณากรอกรหัสผ่าน',
                                  //           style: TextStyle(
                                  //             fontFamily: fontRegular,
                                  //             color: Colors.red,
                                  //             fontSize: normalM2FontSize + 2,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        // remember & forget
                        Container(
                          // color: Colors.amber,
                          height: size.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text('data'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // color: Colors.amber,
                                          width: size.width * 0.05,
                                          // height: size.height * 0.01,
                                          child: Checkbox(
                                              value: controller
                                                  .isRememberAccount.value,
                                              activeColor: hilightTextColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              fillColor: MaterialStateProperty
                                                  .resolveWith((states) {
                                                if (states.contains(
                                                    MaterialState.selected)) {
                                                  return hilightTextColor;
                                                }
                                                return Colors.white;
                                              }),
                                              onChanged: (bool? v) {
                                                if (v == true) {
                                                  controller.isRememberAccount
                                                      .value = true;
                                                } else {
                                                  controller.isRememberAccount
                                                      .value = false;
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.015),
                                  Text(
                                    "จดจำบัญชีของฉัน",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: normalM2FontSize + 2,
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
                                    fontSize: normalM2FontSize + 2,
                                    fontFamily: fontRegular,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Button
                        SizedBox(height: size.height * 0.04),
                        Obx(
                          () => RoundButton(
                            horizontal: size.width * 0.325,
                            fontSize: normalM2FontSize + 2,
                            title: 'เข้าสู่ระบบ',
                            press: (controller.userCheck.value &&
                                    controller.passwordCheck.value)
                                ? () async {
                                    bool isLogin = await controller.login(
                                        context, expandController);
                                    if (isLogin) {
                                      // init socket
                                      SocketService socketService =
                                          SocketService();
                                      socketService.startSocketClient();
                                    }
                                  }
                                : null,
                            // press: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
