import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/Demo/camera_d1_pro_screen.dart';
import 'package:imin/views/screens/Demo/camera_m2_pro_screen.dart';

class TakePictureScreen extends StatelessWidget {
  TakePictureScreen({Key? key}) : super(key: key);

  final uploadController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return (screenController.DeviceCurrent == Device.iminM2Pro)
        ? TakePictureScreenM2Pro(
            size: size,
            uploadController: uploadController,
            cameraController: cameraController)
        : TakePictureScreenD1Pro(
            size: size,
            uploadController: uploadController,
            cameraController: cameraController);
  }
}
