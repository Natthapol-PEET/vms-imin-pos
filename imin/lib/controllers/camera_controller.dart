import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/services/upload_personal_service.dart';

class TakePictureController extends GetxController {
  late CameraDescription camera;
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  var imagePath = "".obs;
  var response = Map<String, dynamic>().obs;

  @override
  void onInit() {
    response.value = {
      "fullname": "",
      "idCard": "",
      "code": "",
    };

    super.onInit();
  }

  Future initCamera() async {
    final cameras = await availableCameras();
    camera = cameras.first;

    controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    initializeControllerFuture = controller.initialize();
  }

  Future takePicture() async {
    Get.back();
    EasyLoading.show(status: 'กรุณารอสักครู่...');

    try {
      await initializeControllerFuture;
      final image = await controller.takePicture();

      var response = await uploadPersonal(image.path);
      response.stream.transform(utf8.decoder).listen((value) {
        try {
          Map<String, dynamic> json = jsonDecode(value);

          if (json['firstname'] != null) {
            imagePath.value = image.path;
            response.value = json;
            EasyLoading.dismiss();
          } else {
            EasyLoading.showError(json['message']);
          }
        } catch (e) {
          EasyLoading.showError('ระบบมีปัญหา กรุณาลองใหม่อีกครั้งในภายหลัง');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
