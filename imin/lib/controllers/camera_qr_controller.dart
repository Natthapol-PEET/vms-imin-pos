import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/controllers/printer_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/upload_personal_service.dart';
import 'package:imin/views/screens/CamareQr/camera_qr_screen.dart';
import 'package:imin/views/widgets/not_connect_internet.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrController extends GetxController {
  final entranceProjectController = Get.put(EntranceProjectController());
  final exitProjectController = Get.put(ExitProjectController());
  QRViewController? qrReaderController;
  Barcode? resultQrReader;
  late CameraDescription camera;
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  // final printerController = Get.put(PrinterController());
  var imagePath = "".obs;
  var response = Map<String, dynamic>().obs;
  var walkinIdPic = "".obs;
  var imageUrl = "".obs;
  var currentPage = "".obs;

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

  void onQRViewCreated(QRViewController qrReaderController) {
    qrReaderController = qrReaderController;

    qrReaderController.scannedDataStream.listen((scanData) {
      // qrReaderSearchResults

      resultQrReader = scanData;
      var codeScanData = scanData.code;
      // var codeScanData = 'W10831672964359836394';
      qrReaderController.pauseCamera();
      Get.back();
      switch (this.currentPage.value) {
        case entrancePage:
          this.currentPage.value == "";
          entranceProjectController.qrReaderSearchResults(codeScanData);
          break;
        case exitPage:
          // log('exit page');
          this.currentPage.value == "";
          exitProjectController.qrReaderExitVillageSearchResults(codeScanData);
          break;
        default:
      }
    });
  }

  EasyDialog showQrCamera({required Size size, required String currentPage}) {
    // EasyDialog showQrCamera(size) {
    this.currentPage.value = currentPage;
    return EasyDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: size.height,
      closeButton: true,
      cardColor: Colors.black,
      contentList: [ScanQrScreen()],
    );
  }

  @override
  void dispose() {
    qrReaderController?.dispose();
    super.dispose();
  }
}
