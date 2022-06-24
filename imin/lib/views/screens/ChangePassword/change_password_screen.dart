import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_bottom_bar_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/controllers/repassword_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/Profile/profile_screen.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'package:imin/views/widgets/round_button_repassword.dart';
import 'package:imin/views/widgets/round_text_form_password.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final controller = Get.put(RePasswordController());
  final onWillPopController = Get.put(OnWillPopController());
  final screenController = Get.put(ScreenController());
  // final expandController = Get.put(ExpansionPanelController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Dialog Exit App
    onWillPopController.context = context;
    // return ChangePasswordForm(size, context);
    if (screenController.DeviceCurrent == Device.iminM2Pro) {
      return ChangePasswordForm(size, context, smallM2FontSize,
          normalM2FontSize, titleM2FontSize, 0.14, 0.1, 0);
    } else {
      return ChangePasswordForm(size, context, 14, 16, 26, 0.25, 0.1, 10);
    }
  }

  SingleChildScrollView ChangePasswordForm(
      Size size,
      BuildContext context,
      double smalltext,
      double text,
      double headText,
      paddingWidth,
      paddingHeight,
      paddingTopInput) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/header_re_password.png'),
              (screenController.DeviceCurrent == Device.iminM2Pro)
                  ? Positioned(
                      top: size.height * 0.00,
                      left: size.width * 0.00,
                      child: Row(
                        children: [
                          GetBuilder<ExpansionPanelController>(
                            id: 'aVeryUniqueID5', // here
                            init: ExpansionPanelController(),
                            builder: (controller) => IconButton(
                                onPressed: () {
                                  controller.currentContent = ProfileScreen();
                                  controller.update(['aopbmsbbffdgkb']);
                                },
                                icon: Icon(Icons.navigate_before,
                                    color: Colors.white)),
                          ),
                          Text(
                            'เปลี่ยนรหัสผ่าน',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: fontRegular,
                              fontWeight: FontWeight.w600,
                              fontSize: headText,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Positioned(
                      top: size.height * 0.05,
                      left: size.width * 0.05,
                      child: Text(
                        'เปลี่ยนรหัสผ่าน',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontRegular,
                          fontWeight: FontWeight.w600,
                          fontSize: headText,
                        ),
                      ),
                    ),
            ],
          ),

          // content
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * paddingWidth,
                vertical: size.height * paddingHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => RoundTextFormPassword(
                    fontSize: text,
                    extendSize: text * 3,
                    iconsize: text * 1.5,
                    paddingTopInput: paddingTopInput.toDouble(),
                    icon: Icons.lock,
                    textTitle: "รหัสผ่านเก่า",
                    isVisibility: controller.isVisibilityOld.value,
                    onClickVisibility: () => controller.isVisibilityOld.value =
                        !controller.isVisibilityOld.value,
                    onChange: (v) => controller.onChangeOldPassword(v),
                  ),
                ),

                Obx(
                  () => RoundTextFormPassword(
                    fontSize: text,
                    extendSize: text * 3,
                    iconsize: text * 1.5,
                    paddingTopInput: paddingTopInput.toDouble(),
                    icon: Icons.lock,
                    textTitle: "รหัสผ่านใหม่",
                    isVisibility: controller.isVisibilityNew.value,
                    onClickVisibility: () => controller.isVisibilityNew.value =
                        !controller.isVisibilityNew.value,
                    onChange: (v) => controller.onChangeNewPassword(v),
                    matchPassword: controller.checkMatchPassword.value,
                  ),
                ),

                // Divider check secret password
                Obx(
                  () => Row(
                    children: [
                      for (int i = 0;
                          i < controller.check.value.lenght;
                          i++) ...[
                        Container(
                          width: size.width / 11.0,
                          height: size.height / 38,
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Divider(
                            thickness: 5,
                            color: controller.check.value.color,
                          ),
                        ),
                      ],
                      if (controller.check.value.lenght > 0) ...[
                        Text(
                          controller.check.value.text,
                          style: TextStyle(
                              color: controller.check.value.color,
                              fontSize: text),
                        ),
                      ],
                    ],
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      if (controller.check.value.lenght > 0) ...[
                        Text(
                          controller.warningText.value.text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: fontRegular,
                            fontSize: smalltext,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                Obx(
                  () => RoundTextFormPassword(
                    fontSize: text,
                    extendSize: text * 3,
                    iconsize: text * 1.5,
                    paddingTopInput: paddingTopInput.toDouble(),
                    icon: Icons.lock,
                    textTitle: "ยืนยันรหัสผ่านใหม่",
                    isVisibility: controller.isVisibilityReNew.value,
                    onClickVisibility: () => controller.isVisibilityReNew
                        .value = !controller.isVisibilityReNew.value,
                    onChange: (v) => controller.onChangeNewPasswordAgain(v),
                    matchPassword: controller.checkMatchPassword.value,
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      if (!controller.checkMatchPassword.value) ...[
                        Text(
                          '*รหัสผ่านไม่ตรงกัน',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: fontRegular,
                            fontSize: smalltext,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // RoundButtonRePassword(
                      //   title: 'บันทึก',
                      //   // press: () =>
                      //   //     logout(size, context), //controller.resetPassword(),
                      //   press: () => logout(size, context),
                      //   checkValidate: controller.checkValidatePassword.value,
                      //   // () async => saveInfomationStatus(context, size),
                      // ),
                      ResetPassword(size, context),
                    ],
                  ),
                ),
                // RoundButton
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding subTitleText(String text, double padding) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontRegular,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Row ResetPassword(Size size, BuildContext context) {
    final double text = (screenController.DeviceCurrent == Device.iminM2Pro)
        ? normalM2FontSize
        : 20;
    return Row(
      children: [
        RoundButtonRePassword(
          fontSize: text,
          title: 'บันทึก',
          // press: () =>
          //     logout(size, context), //controller.resetPassword(),
          press: () {
            EasyDialog(
              closeButton: false,
              height: (screenController.DeviceCurrent == Device.iminM2Pro)
                  ? 160
                  : 200,
              width: 590,
              contentList: [
                // title
                Text(
                  "ยืนยันการเปลี่ยนรหัสผ่าน",
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: dividerColor,
                  thickness: 1,
                ),
                SizedBox(height: 20),
                Text(
                  "เมื่อคุณยืนยันการเปลี่ยนรหัสผ่านแล้วให้ทำการล็อคอินเข้าระบบใหม่",
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: text,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundButton(
                      fontSize: text,
                      title: "ยืนยัน",
                      press: () {
                        final loginController = Get.put(LoginController());

                        controller
                            .resetPassword(loginController.username.value);
                      },
                    ),
                    SizedBox(width: 20),
                    RoundButtonOutline(
                      fontSize: text,
                      title: "ยกเลิก",
                      press: () => Get.back(),
                    ),
                  ],
                ),
              ],
            ).show(context);
          },
          checkValidate: controller.checkValidatePassword.value,
          // () async => saveInfomationStatus(context, size),
        ),
      ],
    );
  }
}
