import 'package:flutter/material.dart';

class ItemModel {
  IconData icon;
  String titleItem;
  Widget currentContent;
  List subItem;
  List subItemSelect;
  List<Widget> onClick;
  bool expanded;

  ItemModel({
    this.icon = Icons.ac_unit,
    this.titleItem = "",
    required this.currentContent,
    this.subItem = const [],
    this.subItemSelect = const [],
    this.onClick = const [],
    this.expanded = false,
  });
}
