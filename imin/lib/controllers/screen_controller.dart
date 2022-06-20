import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum Device { iminD1Pro, iminM2Pro }

class ScreenController extends GetxController {
  showSize(Size size) {
    print("width: ${size.width}");
    print("height: ${size.height}");

    if (size.width == 640.0) {
      // Hide status bar and bottom navigation bar
      SystemChrome.setEnabledSystemUIOverlays([]);
      // Lock Screen Orientation
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      return Device.iminM2Pro;
    } else if (size.width == 1280.0) {
      // Hide status bar and bottom navigation bar
      SystemChrome.setEnabledSystemUIOverlays([]);
      // Lock Screen Orientation
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);

      return Device.iminD1Pro;
    }

    update();
  }
}
