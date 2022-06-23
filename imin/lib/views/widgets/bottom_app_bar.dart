import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final expandController = Get.put(ExpansionPanelController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BottomAppBar(
      // shape: shape,
      color: themeBgColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                child: IconButton(
                  tooltip: 'Open navigation menu',
                  icon: Column(
                    children: [
                      const Icon(
                        Icons.security,
                        size: 20,
                      ),
                      Text(
                        'security center',
                        style: TextStyle(
                            fontSize: normalM2FontSize,
                            color: textColorContrast),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            // if (centerLocations.contains(fabLocation)) const Spacer(),
            Expanded(
              child: Container(
                color: purpleBlueColor,
                child: IconButton(
                  tooltip: 'Search',
                  icon: Column(
                    children: [
                      const Icon(
                        Icons.time_to_leave,
                        size: 20,
                      ),
                      Text(
                        'vehicle management',
                        style: TextStyle(
                            fontSize: normalM2FontSize,
                            color: textColorContrast),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: IconButton(
                  tooltip: 'Favorite',
                  icon: Column(
                    children: [
                      const Icon(
                        Icons.settings,
                        size: 20,
                      ),
                      Text(
                        'setting',
                        style: TextStyle(
                            fontSize: normalM2FontSize,
                            color: textColorContrast),
                      )
                    ],
                  ),
                  onPressed: () {
                    expandController.updateSubItemSelector(2, 0);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
