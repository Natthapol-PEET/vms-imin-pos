import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class ExpansionPanelScreen extends StatelessWidget {
  ExpansionPanelScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      headerItem: 'Android',
      discription:
          "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets.",
      colorsItem: Colors.white,
    ),
    ItemModel(
      headerItem: 'iOS',
      discription:
          "iOS is a mobile operating system created and developed by Apple Inc. exclusively for its hardware.",
      colorsItem: Colors.white,
    ),
    ItemModel(
      headerItem: 'Windows',
      discription:
          "Microsoft Windows, commonly referred to as Windows, is a group of several proprietary graphical operating system families, all of which are developed and marketed by Microsoft. ",
      colorsItem: Colors.white,
    ),
    ItemModel(
      headerItem: 'Linux',
      discription:
          "Linux is a family of open-source Unix-like operating systems based on the Linux kernel, an operating system.",
      colorsItem: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: themeBgColor,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Image.asset("assets/images/Artani-Logo.png", scale: 2.5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: itemData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: themeBgColor,
                          child: ExpansionTile(
                            backgroundColor: goldColor,
                            collapsedIconColor: Colors.white,
                            iconColor: Colors.white,
                            title: Text(
                              itemData[index].headerItem,
                              style: TextStyle(
                                color: !itemData[index].expanded
                                    ? Colors.white
                                    : Colors.grey.shade300,
                              ),
                            ),
                            children: [
                              Text(
                                itemData[index].discription,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

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
