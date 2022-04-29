import 'package:flutter/material.dart';

class ItemModel {
  String headerItem;
  String discription;
  Color colorsItem;
  bool expanded;

  ItemModel({
    this.headerItem = "",
    this.discription = "",
    this.colorsItem = Colors.white,
    this.expanded = false,
  });
}
