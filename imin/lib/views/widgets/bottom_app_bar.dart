import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_bottom_bar_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/ExpansionPanelLayout/burger_menu_d1_pro.dart';
import 'package:imin/views/screens/Profile/profile_screen.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:path/path.dart';

class BottomAppBarOptions extends StatefulWidget {
  BottomAppBarOptions({
    Key? key,
  }) : super(key: key);

  @override
  _BottomAppBarOptionsState createState() => _BottomAppBarOptionsState();
}

class _BottomAppBarOptionsState extends State<BottomAppBarOptions>
    with SingleTickerProviderStateMixin {
  final loginController = Get.put(LoginController());
  final screenController = Get.put(ScreenController());
  final expandController = Get.put(ExpansionAppBarController());
  final expandController2 = Get.put(ExpansionPanelController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BottomAppBar(
      // shape: shape
      color: themeBgColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Container(
          height: 43,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // if (centerLocations.contains(fabLocation)) const Spacer(),
              // Expanded(
              //   child: Container(
              //     color: purpleBlueColor,
              //     child: IconButton(
              //       tooltip: 'Search',
              //       icon: Column(
              //         children: [
              //           const Icon(
              //             Icons.time_to_leave,
              //             size: 15,
              //           ),
              //           Text(
              //             'vehicle management',
              //             style: TextStyle(
              //                 fontSize: normalM2FontSize,
              //                 color: textColorContrast),
              //           )
              //         ],
              //       ),
              //       onPressed: () {
              //         expandController2.onExpansionChanged(true, 0);
              //       },
              //     ),
              //   ),
              // ),
              GetBuilder<ExpansionAppBarController>(
                id: 'aVeryUniqueID', // here
                init: ExpansionAppBarController(),
                builder: (controller) => Expanded(
                  child: Column(
                    children: [
                      buildBottomMenu(controller, size),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildBottomMenu(ExpansionAppBarController controller, Size size) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: IconButton(
                tooltip: 'Open navigation menu',
                icon: Column(
                  children: [
                    const Icon(
                      Icons.security,
                      size: 15,
                    ),
                    Text(
                      'security center',
                      style: TextStyle(
                          fontSize: normalM2FontSize, color: textColorContrast),
                    )
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ),
          for (int i = 0; i < controller.itemData.length; i++) ...[
            Expanded(
              child: Container(
                color:
                    (controller.rememberSelected == i) ? purpleBlueColor : null,
                child: IconButton(
                  // tooltip: 'Search',
                  icon: Column(
                    children: [
                      Icon(
                        controller.itemData[i].icon,
                        size: 15,
                      ),
                      Text(
                        controller.itemData[i].titleItem,
                        style: TextStyle(
                            fontSize: normalM2FontSize,
                            color: textColorContrast),
                      )
                    ],
                  ),
                  onPressed: () {
                    controller.onExpansionChanged(
                        controller.itemData[i].expanded, i);
                  },
                ),
              ),
            ),
          ]
        ],
      ),
      //     child: ListView.builder(
      //   key: Key('builder ${controller.selected.toString()}'), //attention
      //   itemCount: controller.itemData.length,
      //   itemBuilder: (context, index) {
      //     return Expanded(
      //       child: Container(
      //         color:
      //             (controller.itemData[index].expanded) ? purpleBlueColor : null,
      //         child: IconButton(
      //           tooltip: 'Favorite',
      //           icon: Column(
      //             children: [
      //               Icon(
      //                 controller.itemData[index].icon,
      //                 size: 15,
      //               ),
      //               Text(
      //                 controller.itemData[index].titleItem,
      //                 style: TextStyle(
      //                     fontSize: normalM2FontSize, color: textColorContrast),
      //               )
      //             ],
      //           ),
      //           onPressed: () {
      //             controller.onExpansionChanged(
      //                 controller.itemData[index].expanded, index);
      //             print(index);
      //           },
      //         ),
      //       ),
      //     );
      //   },
      // )
    );
  }
}
