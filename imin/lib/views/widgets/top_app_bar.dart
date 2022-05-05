import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button.dart';

class TopAppBar extends StatefulWidget {
  TopAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _TopAppBarState createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar>
    with SingleTickerProviderStateMixin {
  var animationController;
  bool _menuShown = false;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Animation<double> opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);

    return Container(
      color: themeBgColor,
      height: size.height * 0.075,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundButton(
            title: 'Go to security center',
            press: () {},
          ),
          Row(
            children: [
              // ภาษา
              Image.asset('assets/images/thai-icon.png'),
              SizedBox(width: size.width * 0.005),
              Text(
                'ภาษาไทย',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: fontRegular,
                  fontSize: 14,
                ),
              ),
              // SizedBox(width: size.width * 0.01),

              // bell
              // MaterialButton(
              //   onPressed: () => showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (BuildContext context) =>
              //         _buildPopupDialog(context, size),
              //   ),
              //   minWidth: 0,
              //   child: Image.asset(
              //     'assets/images/bell-icon.png',
              //     scale: 1.2,
              //   ),
              // ),
              // PopupMenuButton(
              //   icon: Image.asset(
              //     'assets/images/bell-icon.png',
              //     scale: 1.2,
              //   ),
              //   onSelected: (newValue) {
              //     // add this property
              //     print(newValue);
              //   },
              //   itemBuilder: (context) => [
              //     PopupMenuItem(
              //       child: Text("Settings"),
              //       value: 0,
              //     ),
              //   ],
              // ),

              TextButton(
                onPressed: () {},
                child: PopupMenuButton(
                  offset: Offset(80, size.height * 0.06),
                  icon: Image.asset(
                    'assets/images/bell-icon.png',
                    scale: 1.2,
                  ),
                  itemBuilder: (_) {
                    return [
                      PopupMenuItem(
                        child: Container(
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "การแจ้งเตือน",
                                    style: TextStyle(
                                      fontFamily: fontRegular,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: iconCloseColor,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      color: iconCloseColor,
                                    ),
                                  ),
                                ],
                              ),
                              CardAlertSecurity(
                                title: 'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 100/2',
                                time: 'ตอนนี้',
                                color: redAlertColor,
                              ),
                              CardAlertSecurity(
                                title: 'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 101',
                                time: '2 นาทีที่แล้ว',
                                color: redAlertColor,
                              ),
                              CardAlertSecurity(
                                title: 'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 301',
                                time: '20 นาทีที่แล้ว',
                                color: redAlertColor,
                              ),
                              CardAlertSecurity(
                                title: 'สัญญาณอุปกรณ์มีปัญหา บ้านเลขที่ 111',
                                time: '1 ชั่วโมงที่แล้ว',
                                color: orangeAlertColor,
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ),

              // profile
              Image.asset('assets/images/profile-mini.png'),
              SizedBox(width: size.width * 0.005),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'พิทยา จริณพร',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontRegular,
                    ),
                  ),
                  Text(
                    'หัวหน้า รปภ.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontRegular,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(width: size.width * 0.01),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
    );
  }

  Widget _buildPopupDialog(BuildContext context, Size size) {
    // return Dialog(
    //   child: Container(
    //     width: 100,
    //     height: 100,
    //     color: Colors.green,
    //   ),
    // );
    return SimpleDialog(
      insetPadding:
          EdgeInsets.only(bottom: size.height * 0.5, left: size.width * 0.6),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0,
      children: [
        _ShapedWidget(),
      ],
    );
  }
}

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

class _ShapedWidget extends StatelessWidget {
  _ShapedWidget();
  final double padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: _ShapedWidgetBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(padding),
          ),
          padding: padding,
        ),
        elevation: 4.0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'การแจ้งเตือน',
                      style: TextStyle(
                        fontFamily: fontRegular,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: iconCloseColor,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: iconCloseColor,
                      ),
                    ),
                  ],
                ),
              ),
              CardAlertSecurity(
                title: 'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 100/2',
                time: 'ตอนนี้',
                color: redAlertColor,
              ),
              CardAlertSecurity(
                title: 'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 101',
                time: '2 นาทีที่แล้ว',
                color: redAlertColor,
              ),
              CardAlertSecurity(
                title: 'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 301',
                time: '20 นาทีที่แล้ว',
                color: redAlertColor,
              ),
              CardAlertSecurity(
                title: 'สัญญาณอุปกรณ์มีปัญหา บ้านเลขที่ 111',
                time: '1 ชั่วโมงที่แล้ว',
                color: orangeAlertColor,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CardAlertSecurity extends StatelessWidget {
  const CardAlertSecurity({
    Key? key,
    required this.title,
    required this.time,
    required this.color,
  }) : super(key: key);

  final String title;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey.shade300),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: iconCloseColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 15),
            child: Text(
              time,
              style: TextStyle(
                fontFamily: fontRegular,
                fontSize: 13,
                color: iconCloseColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShapedWidgetBorder extends RoundedRectangleBorder {
  _ShapedWidgetBorder({
    required this.padding,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero,
  }) : super(side: side, borderRadius: borderRadius);

  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width - 55, rect.top) // ..moveTo(set-right, rect.top)
      ..lineTo(rect.width - 70,
          rect.top - 13) // ..lineTo(rect.width - 20.0, set-top)
      ..lineTo(rect.width - 85, rect.top) // ..lineTo(set-left, rect.top)
      ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height - padding)));
  }
}
