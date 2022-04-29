import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/models/item_model.dart';

class ExpansionPanelController extends GetxController {
  int selected = -1.obs; //attention
  int rememberSelected = -1.obs;

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      icon: Icons.supervisor_account,
      titleItem: 'สุจิน สว่างเนตร',
      subItem: ['ข้อมูลส่วนตัว', 'เปลี่ยนรหัสผ่าน'],
      subItemSelect: [true, false],
      onClick: [() {}, () {}],
    ),
    ItemModel(
      icon: Icons.timer,
      titleItem: 'เวลาเข้าโครงการ',
      subItem: [],
      subItemSelect: [],
      onClick: [],
    ),
    ItemModel(
      icon: Icons.schedule,
      titleItem: 'เวลาออกจากโครงการ',
      subItem: [],
      onClick: [],
    ),
  ];

  updateSubItemSelector(int itemDataIndex, int subItemIndex) {
    for (int i = 0; i < itemData[itemDataIndex].subItem.length; i++) {
      if (subItemIndex == i) {
        itemData[itemDataIndex].subItemSelect[i] = true;
      } else {
        itemData[itemDataIndex].subItemSelect[i] = false;
      }

      // print('selector: ${itemData[itemDataIndex].subItemSelect[i]}');
      update(['aVeryUniqueID']); // and then here
    }
  }

  onExpansionChanged(bool v, int index) {
    if (rememberSelected == index) {
      return;
    }

    rememberSelected = index;
    itemData[index].expanded = v;
    print('doing ...');

    // if (v) {
    //   selected = index;
    // } else {
    //   selected = -1;
    // }

    selected = index;
    // print('index: $index');

    update(['aVeryUniqueID']); // and then here
  }
}
