// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:imin/views/screens/ChangePassword/change_password_screen.dart';
import 'package:imin/views/screens/Demo/calendar_screen.dart';
import 'package:imin/views/screens/Demo/popup_menu_screen.dart';
import 'package:imin/views/screens/Demo/select.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_screen.dart';
import 'package:imin/views/screens/ExpansionPanelLayout/expansion_panel_layout.dart';
import 'package:imin/views/screens/ForgotPassword/forgot_password_screen.dart';
import 'package:imin/views/screens/Login/login_screen.dart';
import 'package:imin/views/screens/Demo/demo.dart';
import 'package:imin/views/screens/Profile/profile_screen.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(MyApp());

  // The following line will enable the Android and iOS wakelock.
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  // Hide status bar and bottom navigation bar
  SystemChrome.setEnabledSystemUIOverlays([]);
  // Lock Screen Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VMS Dashboard Status',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations
            .delegate, // Add global cupertino localiztions.
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      locale: const Locale('th', 'TH'),

      initialRoute: '/login',
      getPages: [
        // Screens
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/expansion_panel', page: () => ExpansionPanelScreen()),
        GetPage(name: '/forgot_password', page: () => ForgotPassword()),

        // Components
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/change_password', page: () => ChangePasswordScreen()),
        GetPage(name: '/entrance_project', page: () => EntranceProjectScreen()),
        GetPage(name: '/exit_project', page: () => ExitProjectScreen()),

        // demos
        GetPage(name: '/demo', page: () => ExpansionPanelDemo()),
        GetPage(name: '/select', page: () => Selector()),
        GetPage(name: '/popup_menu', page: () => PopupMenuScreen()),
        GetPage(name: '/calendar', page: () => CalendarScreen()),
      ],
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static const platform = MethodChannel('samples.flutter.dev/battery');
//   // Get battery level.
//   String _batteryLevel = 'Unknown battery level.';

//   Future<void> _getBatteryLevel() async {
//     String batteryLevel;
//     try {
//       final int result = await platform.invokeMethod('getBatteryLevel');
//       batteryLevel = 'Battery level at $result % .';
//     } on PlatformException catch (e) {
//       batteryLevel = "Failed to get battery level: '${e.message}'.";
//     }

//     setState(() {
//       _batteryLevel = batteryLevel;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             ElevatedButton(
//               child: Text('Get Battery Level'),
//               onPressed: _getBatteryLevel,
//             ),
//             Text(_batteryLevel),
//           ],
//         ),
//       ),
//     );
//   }
// }
