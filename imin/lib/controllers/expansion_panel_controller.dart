import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/models/item_model.dart';
import 'package:imin/views/screens/ChangePassword/change_password_screen.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_screen.dart';
import 'package:imin/views/screens/Profile/profile_screen.dart';

class ExpansionPanelController extends GetxController {
  int selected = -1.obs; //attention
  int rememberSelected = -1.obs;
  Widget currentContent = EntranceProjectScreen();

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      icon: Icons.timer,
      titleItem: 'เวลาเข้าโครงการ',
      currentContent: EntranceProjectScreen(),
      subItem: [],
      subItemSelect: [],
      onClick: [],
    ),
    ItemModel(
      icon: Icons.schedule,
      titleItem: 'เวลาออกจากโครงการ',
      currentContent: ExitProjectScreen(),
      subItem: [],
      onClick: [],
    ),
    ItemModel(
      icon: Icons.settings,
      titleItem: 'ตั้งค่า',
      currentContent: ProfileScreen(),
      subItem: ['ข้อมูลส่วนตัว', 'เปลี่ยนรหัสผ่าน'],
      subItemSelect: [true, false],
      onClick: [
        ProfileScreen(),
        ChangePasswordScreen(),
      ],
    ),
  ];

  onExpansionChanged(bool v, int index) {
    if (rememberSelected == index) {
      return;
    }

    rememberSelected = index;
    itemData[index].expanded = v;
    currentContent = itemData[index].currentContent;
    print('doing ...');

    // clear selected index 0
    if (itemData[index].subItemSelect.length > 0) {
      itemData[index].subItemSelect = [true, false];
    }

    // if (v) {
    //   selected = index;
    // } else {
    //   selected = -1;
    // }

    selected = index;
    print('selected: $selected');

    // update menu
    update(['aVeryUniqueID']); // and then here

    // update content
    update(['aopbmsbbffdgkb']); // and then here
  }

  updateSubItemSelector(int itemDataIndex, int subItemIndex) {
    for (int i = 0; i < itemData[itemDataIndex].subItem.length; i++) {
      if (subItemIndex == i) {
        itemData[itemDataIndex].subItemSelect[i] = true;
        currentContent = itemData[itemDataIndex].onClick[i];
      } else {
        itemData[itemDataIndex].subItemSelect[i] = false;
      }
    }
    // print('selector: ${itemData[itemDataIndex].subItemSelect[i]}');

    // update menu
    update(['aVeryUniqueID']); // and then here

    // update content
    update(['aopbmsbbffdgkb']); // and then here

    print('selected: $selected');
  }

  setDefaultValues() {
    selected = -1.obs; //attention
    rememberSelected = -1.obs;
    currentContent = EntranceProjectScreen();

    itemData = <ItemModel>[
      ItemModel(
        icon: Icons.timer,
        titleItem: 'เวลาเข้าโครงการ',
        currentContent: EntranceProjectScreen(),
        subItem: [],
        subItemSelect: [],
        onClick: [],
      ),
      ItemModel(
        icon: Icons.schedule,
        titleItem: 'เวลาออกจากโครงการ',
        currentContent: ExitProjectScreen(),
        subItem: [],
        onClick: [],
      ),
      ItemModel(
        icon: Icons.settings,
        titleItem: 'ตั้งค่า',
        currentContent: ProfileScreen(),
        subItem: ['ข้อมูลส่วนตัว', 'เปลี่ยนรหัสผ่าน'],
        subItemSelect: [true, false],
        onClick: [
          ProfileScreen(),
          ChangePasswordScreen(),
        ],
      ),
    ];

    // update menu
    update(['aVeryUniqueID']); // and then here

    // update content
    update(['aopbmsbbffdgkb']); // and then here
  }
}
