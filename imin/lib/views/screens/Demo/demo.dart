import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class ExpansionPanelDemo extends StatefulWidget {
  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  int selected = 0; //attention

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: themeBgColor,
        // padding: EdgeInsets.all(10),
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
                  key: Key(index.toString()),
                  initiallyExpanded: index == selected,
                  onExpansionChanged: (newState) {
                    if (newState) {
                      setState(() => selected = index);
                    } else {
                      setState(() => selected = -1);
                    }
                  }

                  // onExpansionChanged: (bool status) {
                  //   print("status: $status");
                  //   setState(() {
                  //     for (int i = 0; i < itemData.length; i++) {
                  //       print("i = $i : ${itemData[i].expanded}");
                  //       itemData[i].expanded = false;
                  //       print("i = $i : ${itemData[i].expanded}");
                  //     }

                  //     itemData[index].expanded = !itemData[index].expanded;
                  //   });
                  // },
                  ),
            );

            return Container(
              color: themeBgColor,
              // margin: EdgeInsets.only(bottom: 10.0),
              child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 500),
                dividerColor: themeBgColor,
                elevation: 0,
                // expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
                children: [
                  ExpansionPanel(
                    backgroundColor: themeBgColor,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        color: themeBgColor,
                        // padding: EdgeInsets.all(10),
                        child: Text(
                          itemData[index].headerItem,
                          style: TextStyle(
                            color: itemData[index].colorsItem,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                    body: Container(
                      color: themeBgColor,
                      // padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemData[index].discription,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: itemData[index].expanded,
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    itemData[index].expanded = !itemData[index].expanded;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

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
