import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/printer_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/services/upload_personal_service.dart';
import 'package:imin/views/widgets/not_connect_internet.dart';

class TakePictureController extends GetxController {
  late CameraDescription camera;
  late CameraController controller;
  late Future<void> initializeControllerFuture;
  // final printerController = Get.put(PrinterController());
  var imagePath = "".obs;
  var response = Map<String, dynamic>().obs;
  var walkinIdPic = "".obs;
  var imageUrl = "".obs;

  clear() {
    imagePath.value = "";
    imageUrl.value = "";
    response.value = {
      "code": "",
    };
    // printerController.qrId.value = "";
  }

  @override
  void onInit() {
    response.value = {
      "code": "",
    };
    // printerController.qrId.value = "";

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

  uploadPersonalApi(XFile image, String classCard) async {
    EasyLoading.show(status: 'กรุณารอสักครู่...');
    var responseApi = await uploadPersonal(image.path, classCard);
    final printerController = Get.put(PrinterController());
    print('response');
    print(response['code']);
    responseApi.stream.transform(utf8.decoder).listen((value) {
      Map<String, dynamic> json;

      try {
        json = jsonDecode(value);
      } catch (e) {
        print("Error: $e");
        EasyLoading.dismiss();
        alertSystemOnConnectInternet();
        return;
      }

      if (json['code'] != null) {
        // imagePath.value = image.path;
        response.value = json;
        printerController.qrId.value = json['code'];
        imageUrl.value = ipServerIminService + '/card/' + json['code'] + '/';
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError(json['message']);
      }
    });
  }

  Future takePicture(String cardClass) async {
    Get.back();

    try {
      await initializeControllerFuture;
      XFile image = await controller.takePicture();

      uploadPersonalApi(image, cardClass);
    } catch (e) {
      print(e);
    }
  }

  stopCamera() {
    Timer(Duration(seconds: 1), () => controller.dispose());
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
