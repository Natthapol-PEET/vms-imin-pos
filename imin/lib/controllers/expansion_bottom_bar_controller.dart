import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/repassword_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/models/bottom_menu_model.dart';
import 'package:imin/models/item_model.dart';
import 'package:imin/views/screens/ChangePassword/change_password_screen.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_screen.dart';
import 'package:imin/views/screens/Profile/profile_screen.dart';

class ExpansionAppBarController extends GetxController {
  int selected = -1.obs; //attention
  int rememberSelected = -1.obs;
  // Widget currentContent = EntranceProjectScreen();

  final reController = Get.put(RePasswordController());
  final screenController = Get.put(ScreenController());
  final expandController2 = Get.put(ExpansionPanelController());

  List<BottomMenuModel> itemData = <BottomMenuModel>[
    BottomMenuModel(
      icon: Icons.time_to_leave,
      titleItem: 'vehicle management',
      currentContent: EntranceProjectScreen(),
      subItem: [],
      subItemSelect: [],
      onClick: [],
    ),
    BottomMenuModel(
      icon: Icons.settings,
      titleItem: 'setting',
      currentContent: ProfileScreen(),
      subItem: [],
      subItemSelect: [],
      onClick: [],
    ),
  ];

  onExpansionChanged(bool v, int index) {
    // print(v);
    // print('${itemData[index].currentContent}');
    if (rememberSelected == index && v == false) {
      selected = -1;
      update(['aVeryUniqueID']);
      return;
    }
    rememberSelected = index;
    itemData[index].expanded = v;
    expandController2.currentContent = itemData[index].currentContent;

    // clear selected index 0
    if (itemData[index].subItemSelect.length > 0) {
      itemData[index].subItemSelect = [true, false];
    }

    selected = index;
    if (index != 0) {
      expandController2.selected = -1;
      expandController2.rememberSelected = -1;
      expandController2.itemData[0].expanded = v;
    } else {
      expandController2.selected = index;
      expandController2.rememberSelected = index;
      expandController2.itemData[0].expanded = v;
    }

    reController.clear();

    // update menu
    update(['aVeryUniqueID']);
    expandController2.update(['aVeryUniqueID']); // and then here

    // update content
    expandController2.update(['aopbmsbbffdgkb']); // and then here
  }

  updateSubItemSelector(int itemDataIndex, int subItemIndex) {
    for (int i = 0; i < itemData[itemDataIndex].subItem.length; i++) {
      if (subItemIndex == i) {
        itemData[itemDataIndex].subItemSelect[i] = true;
        expandController2.currentContent = itemData[itemDataIndex].onClick[i];
      } else {
        itemData[itemDataIndex].subItemSelect[i] = false;
      }
    }
    // print('selector: ${itemData[itemDataIndex].subItemSelect[i]}');

    reController.clear();

    // update menu
    update(['aVeryUniqueID']); // and then here

    // update content
    update(['aopbmsbbffdgkb']); // and then here

    // print('selected: $selected');
  }

  setDefaultValues() {
    selected = -1.obs; //attention
    rememberSelected = -1.obs;
    expandController2.currentContent = EntranceProjectScreen();

    itemData = <BottomMenuModel>[
      BottomMenuModel(
        icon: Icons.time_to_leave,
        titleItem: 'vehicle management',
        currentContent: EntranceProjectScreen(),
        subItem: [],
        subItemSelect: [],
        onClick: [],
      ),
      BottomMenuModel(
        icon: Icons.settings,
        titleItem: 'setting',
        currentContent: ProfileScreen(),
        subItem: [],
        subItemSelect: [],
        onClick: [],
      ),
    ];

    // update menu
    update(['aVeryUniqueID']); // and then here

    // update content
    update(['aopbmsbbffdgkb']); // and then here
  }
}
