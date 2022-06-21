import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum Device { iminD1Pro, iminM2Pro }

class ScreenController extends GetxController {
  dynamic DeviceCurrent = '';
  showSize(Size size) {
    print("width: ${size.width}");
    print("height: ${size.height}");
    // print("Device: ${Device.iminM2Pro}");
// print("DeviceCurrent: ${DeviceCurrent}");
    // if (size.width == 640.0) {
    if (size.width <= 720.0) {
      // Hide status bar and bottom navigation bar
      SystemChrome.setEnabledSystemUIOverlays([]);
      // Lock Screen Orientation
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      DeviceCurrent = Device.iminM2Pro;
      print("DeviceCurrent: ${DeviceCurrent}");
      return Device.iminM2Pro;
      // } else if (size.width == 1280.0) {
    } else if (size.width <= 1280.0) {
      // Hide status bar and bottom navigation bar
      SystemChrome.setEnabledSystemUIOverlays([]);
      // Lock Screen Orientation
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      print("DeviceCurrent: ${DeviceCurrent}");
      return Device.iminD1Pro;
    }

    update();
  }
}
