import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/views/screens/CamareQr/camera_qr_d1_pro_screen.dart';

class ScanQrScreen extends StatelessWidget {
  ScanQrScreen({Key? key}) : super(key: key);
  final screenController = Get.put(ScreenController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return const CameraQrD1Screen();
    return (screenController.DeviceCurrent == Device.iminM2Pro)
        // m2 screen
        ? CameraQrD1ProScreen(size: size)
        // d1 screen
        : CameraQrD1ProScreen(size: size);
  }
}
