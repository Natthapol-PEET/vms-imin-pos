import 'dart:async';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/data/account.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/account_model.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'package:imin/views/widgets/top_app_bar.dart';

// ignore: must_be_immutable
class ExpansionPanelScreen extends StatelessWidget {
  ExpansionPanelScreen({
    Key? key,
  }) : super(key: key);

  final onWillPopController = Get.put(OnWillPopController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //  Dialog Exit App
    onWillPopController.context = context;

    return WillPopScope(
      onWillPop: onWillPopController.onWillPop,
      child: Scaffold(
        backgroundColor: contentColor,
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: themeBgColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.03),
                      child: Image.asset(
                        "assets/images/logo_horizontal.png",
                        scale: 0.2,
                      ),
                    ),
                    GetBuilder<ExpansionPanelController>(
                      id: 'aVeryUniqueID', // here
                      init: ExpansionPanelController(),
                      builder: (controller) => Expanded(
                        child: Column(
                          children: [
                            buildMenu(controller, size),
                            logout(size, context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GetBuilder<ExpansionPanelController>(
                id: 'aopbmsbbffdgkb', // here
                init: ExpansionPanelController(),
                builder: (controller) => Column(
                  children: [
                    TopAppBar(),
                    Expanded(
                      child: controller.currentContent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton logout(Size size, BuildContext context) {
    return TextButton(
      onPressed: () async {
        EasyDialog(
          closeButton: false,
          height: 240,
          width: 450,
          contentList: [
            // title
            Text(
              "แจ้งเตือน",
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
              "ต้องการออกจากระบบหรือไม่ ?",
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
                  press: () async => await loginController.logout(),
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
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.01),
        child: Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.white),
            SizedBox(width: size.width * 0.01),
            Text(
              'ออกจากระบบ',
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontRegular,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
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
