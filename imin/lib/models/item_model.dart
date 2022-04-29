import 'package:flutter/material.dart';

class ItemModel {
  IconData icon;
  String titleItem;
  List subItem;
  List subItemSelect;
  List<VoidCallback>? onClick;
  bool expanded;

  ItemModel({
    this.icon = Icons.ac_unit,
    this.titleItem = "",
    this.subItem = const [],
    this.subItemSelect = const [],
    this.onClick,
    this.expanded = false,
  });
}
