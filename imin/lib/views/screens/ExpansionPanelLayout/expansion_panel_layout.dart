import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen.dart';
import 'package:imin/views/screens/ExpansionPanelLayout/burger_menu_d1_pro.dart';
import 'package:imin/views/screens/ExpansionPanelLayout/burger_menu_m2_pro.dart';
import 'package:imin/views/widgets/bottom_app_bar.dart';
import 'package:imin/views/widgets/top_app_bar.dart';

// ignore: must_be_immutable
class ExpansionPanelScreen extends StatelessWidget {
  ExpansionPanelScreen({
    Key? key,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final onWillPopController = Get.put(OnWillPopController());
  final loginController = Get.put(LoginController());
  final screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //  Dialog Exit App
    onWillPopController.context = context;

    return WillPopScope(
      onWillPop: onWillPopController.onWillPop,
      child: Scaffold(
        backgroundColor: contentColor,
        body: Row(
          children: [
            (screenController.DeviceCurrent == Device.iminM2Pro)
                ? Container()
                : MenuBergerD1Pro(),
            Expanded(
              flex: 4,
              child: GetBuilder<ExpansionPanelController>(
                  id: 'aopbmsbbffdgkb', // here
                  init: ExpansionPanelController(),
                  builder: (controller) => (screenController.DeviceCurrent !=
                          Device.iminM2Pro)
                      ? Column(
                          children: [
                            TopAppBar(),
                            Expanded(
                              child: controller.currentContent,
                            ),
                          ],
                        )
                      : Scaffold(
                          key: _key,
                          appBar: AppBar(
                            backgroundColor: themeBgColor,
                            // leading: Text('data'),
                            automaticallyImplyLeading: false,
                            title: Row(
                              children: [
                                // SizedBox(
                                //   width: 5.0,
                                // ),
                                SizedBox(
                                  height: 38.0,
                                  width: 40.0,
                                  child: new IconButton(
                                      padding: new EdgeInsets.only(right: 15),
                                      color: Colors.white,
                                      icon: Image.asset(
                                        'assets/images/menu-hamburger.png',
                                        scale: 1,
                                        width: 60,
                                        // height: 60,
                                      ),
                                      onPressed: () {
                                        controller.keyDrawer = _key;
                                        print('key: $_key');
                                        _key.currentState!.openDrawer();
                                        // _key.currentState!.openEndDrawer();
                                      }),
                                ),
                                Image.asset(
                                  "assets/images/logo_horizontal.png",
                                  scale: 2.0,
                                )
                              ],
                            ),
                            actions: [
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "การแจ้งเตือน",
                                                    style: TextStyle(
                                                      fontFamily: fontRegular,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                title:
                                                    'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 100/2',
                                                time: 'ตอนนี้',
                                                color: redAlertColor,
                                              ),
                                              CardAlertSecurity(
                                                title:
                                                    'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 101',
                                                time: '2 นาทีที่แล้ว',
                                                color: redAlertColor,
                                              ),
                                              CardAlertSecurity(
                                                title:
                                                    'สัญญาณขอความช่วยเหลือ บ้านเลขที่ 301',
                                                time: '20 นาทีที่แล้ว',
                                                color: redAlertColor,
                                              ),
                                              CardAlertSecurity(
                                                title:
                                                    'สัญญาณอุปกรณ์มีปัญหา บ้านเลขที่ 111',
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
                            ],
                            toolbarHeight: 45,
                            // title: Text('title')
                          ),
                          body: Column(
                            children: [
                              Expanded(child: controller.currentContent),
                              BottomAppBarOptions()
                            ],
                          ),
                          drawer: Container(
                              width: size.width * 0.6,
                              child: Drawer(child: MenuBergerM2Pro())),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
