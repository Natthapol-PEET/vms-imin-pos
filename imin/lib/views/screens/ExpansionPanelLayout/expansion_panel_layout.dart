import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/ChangePassword/change_password_screen.dart';
import 'package:imin/views/screens/Profile/profile_screen.dart';

// ignore: must_be_immutable
class ExpansionPanelScreen extends StatelessWidget {
  ExpansionPanelScreen({
    Key? key,
  }) : super(key: key);

  // final controller = Get.put(ExpansionPanelController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: themeBgColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.05, bottom: size.height * 0.015),
                    child: Image.asset("assets/images/Artani-Logo.png",
                        scale: 2.5),
                  ),
                  GetBuilder<ExpansionPanelController>(
                    id: 'aVeryUniqueID', // here
                    init: ExpansionPanelController(),
                    builder: (controller) => Expanded(
                      child: Column(
                        children: [
                          buildMenu(controller, size),
                          logout(size),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // child,
          Expanded(
            flex: 4,
            child: GetBuilder<ExpansionPanelController>(
              id: 'aopbmsbbffdgkb', // here
              init: ExpansionPanelController(),
              builder: (controller) => Container(
                child: controller.currentContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell logout(Size size) {
    return InkWell(
      onTap: () => Get.toNamed('/login'),
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
              backgroundColor: goldColor,
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
                          ? Colors.white
                          : Colors.grey.shade300),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    controller.itemData[index].titleItem,
                    style: TextStyle(
                      color: index == controller.selected
                          ? Colors.white
                          : Colors.grey.shade300,
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
                              ? Colors.white
                              : Colors.grey.shade300,
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
