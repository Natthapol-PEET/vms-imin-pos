import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/services/upload_personal_service.dart';

class TakePictureController extends GetxController {
  late CameraDescription camera;
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  var imagePath = "".obs;
  var response = Map<String, dynamic>().obs;
  var imageUrl = "".obs;

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

  uploadPersonalApi(XFile image) async {
    EasyLoading.show(status: 'กรุณารอสักครู่...');
    var responseApi = await uploadPersonal(image.path);
    responseApi.stream.transform(utf8.decoder).listen((value) {
      Map<String, dynamic> json = jsonDecode(value);

      print(json);
      print(json['fullname']);
      print(json['fullname'] != null);

      if (json['fullname'] != null) {
        // imagePath.value = image.path;
        response.value = json;
        imageUrl.value = ipServerIminService + '/' + json['code'];
        EasyLoading.dismiss();

        print(response['fullname']);
      } else {
        EasyLoading.showError(json['message']);
      }
    });
  }

  Future takePicture() async {
    Get.back();

    try {
      await initializeControllerFuture;
      XFile image = await controller.takePicture();

      uploadPersonalApi(image);
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
