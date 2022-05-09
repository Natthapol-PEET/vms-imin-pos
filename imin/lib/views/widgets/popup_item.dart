import 'package:flutter/material.dart';

class PopupItem extends PopupMenuItem {
  const PopupItem({
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  _PopupItemState createState() => _PopupItemState();
}

class _PopupItemState extends PopupMenuItemState {
  @override
  void handleTap() {}
}
