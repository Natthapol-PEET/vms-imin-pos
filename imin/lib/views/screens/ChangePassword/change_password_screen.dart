import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/controllers/repassword_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'package:imin/views/widgets/round_button_repassword.dart';
import 'package:imin/views/widgets/round_text_form_password.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final controller = Get.put(RePasswordController());
  final onWillPopController = Get.put(OnWillPopController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    // Dialog Exit App
    onWillPopController.context = context;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/header_re_password.png'),
              Positioned(
                top: size.height * 0.05,
                left: size.width * 0.05,
                child: Text(
                  'เปลี่ยนรหัสผ่าน',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontRegular,
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                ),
              ),
            ],
          ),

          // content
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.25, vertical: size.height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => RoundTextFormPassword(
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
                          style: TextStyle(color: controller.check.value.color),
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
                            fontSize: 14,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                Obx(
                  () => RoundTextFormPassword(
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
                            fontSize: 14,
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
    return Row(
      children: [
        RoundButtonRePassword(
          title: 'บันทึก',
          // press: () =>
          //     logout(size, context), //controller.resetPassword(),
          press: () {
            EasyDialog(
              closeButton: false,
              height: 200,
              width: 590,
              contentList: [
                // title
                Text(
                  "ยืนยันการเปลี่ยนรหัสผ่าน",
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 24,
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
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundButton(
                      title: "ยืนยัน",
                      press: () async {},
                    ),
                    SizedBox(width: 20),
                    RoundButtonOutline(
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
    // EasyDialog(
    //   closeButton: false,
    //   height: 200,
    //   width: 590,
    //   contentList: [
    //     // title
    //     Text(
    //       "ยืนยันการเปลี่ยนรหัสผ่าน",
    //       style: TextStyle(
    //         fontFamily: fontRegular,
    //         fontSize: 24,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     Divider(
    //       color: dividerColor,
    //       thickness: 1,
    //     ),
    //     SizedBox(height: 20),
    //     Text(
    //       "เมื่อคุณยืนยันการเปลี่ยนรหัสผ่านแล้วให้ทำการล็อคอินเข้าระบบใหม่",
    //       style: TextStyle(
    //         fontFamily: fontRegular,
    //         fontSize: 20,
    //       ),
    //     ),
    //     SizedBox(height: 20),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         RoundButton(
    //           title: "ยืนยัน",
    //           press: () async {},
    //         ),
    //         SizedBox(width: 20),
    //         RoundButtonOutline(
    //           title: "ยกเลิก",
    //           press: () => Get.back(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ).show(context);
  }

  Expanded buildMenu(ExpansionPanelController controller, Size size) {
    return Expanded(
      child: ListView.builder(
        key: Key('builder ${controller.selected.toString()}'), //attention
        itemCount: controller.itemData.length,
        itemBuilder: (context, index) {
          return Container(
            color: themeBgColor,
            child: ExpansionTile(
              key: Key(index.toString()), //attention
              initiallyExpanded: index == controller.selected, //attention,
              expandedAlignment: Alignment.topLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              backgroundColor: Colors.white,
              // collapsedIconColor: Colors.white,
              // iconColor: Colors.white,
              collapsedIconColor: controller.itemData[index].subItem.length > 0
                  ? Colors.white
                  : Colors.transparent,
              iconColor: controller.itemData[index].subItem.length > 0
                  ? Colors.white
                  : Colors.transparent,
              title: Row(
                children: [
                  Icon(controller.itemData[index].icon,
                      color: index == controller.selected
                          ? hilightTextColor
                          : Colors.white),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    controller.itemData[index].titleItem,
                    style: TextStyle(
                      color: index == controller.selected
                          ? hilightTextColor
                          : Colors.white,
                      fontFamily: fontRegular,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              children: [
                // for (var subItem in controller.itemData[index].subItem)
                for (int i = 0;
                    i < controller.itemData[index].subItem.length;
                    i++) ...[
                  InkWell(
                    onTap: () => controller.updateSubItemSelector(index, i),
                    // onTap: controller.itemData[index].onClick[i],
                    child: Container(
                      padding: EdgeInsets.only(
                          left: size.width * 0.04, bottom: size.height * 0.02),
                      width: double.infinity,
                      child: Text(
                        controller.itemData[index].subItem[i],
                        style: TextStyle(
                          color: controller.itemData[index].subItemSelect[i]
                              ? hilightTextColor
                              : textColor,
                          fontFamily: fontRegular,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
              onExpansionChanged: (v) =>
                  controller.onExpansionChanged(v, index),
            ),
          );
        },
      ),
    );
  }
}
