import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/printer_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/views/widgets/picture_to_slip_printer.dart';
import 'package:intl/intl.dart';

EasyDialog dialogDetailPicPrinter(Size size, BuildContext context) {
  final uploadPersonalController = Get.put(UploadPersonalController());
  final printerController = Get.put(PrinterController());
    GlobalKey globalKey = GlobalKey();
    GlobalKey globalKey2 = GlobalKey();
    GlobalKey globalKey3 = GlobalKey();
    Future<void> capturePng() async {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      RenderRepaintBoundary boundary2 = globalKey2.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      RenderRepaintBoundary boundary3 = globalKey3.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      var image2 = await boundary2.toImage();
      var image3 = await boundary3.toImage();
      print('image');
      print(image);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      ByteData? byteData2 =
          await image2.toByteData(format: ImageByteFormat.png);
      ByteData? byteData3 =
          await image3.toByteData(format: ImageByteFormat.png);
      // printerController.printTicketPic(byteData);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      Uint8List pngBytes2 = byteData2!.buffer.asUint8List();
      Uint8List pngBytes3 = byteData3!.buffer.asUint8List();
      // list
      printerController.printTicketPic(pngBytes, pngBytes2, pngBytes3);
      // print('pngBytes');
      // print(pngBytes);
      // YOUR_BYTES = pngBytes;
    }

    Timer(Duration(milliseconds: 150), () {
      // EasyLoading.dismiss();
      capturePng();
      Get.back();
      // Get.toNamed('/login');
    });

    return EasyDialog(
      width: 400,
      height: size.height * 0.7,
      contentListAlignment: CrossAxisAlignment.start,
      closeButton: false,
      contentList: [
        FormSlip(
          globalKey: globalKey,
          homeAddress: uploadPersonalController.homeNumber.value,
          onDate: new DateFormat('dd/MM/yy'),
          onTime: new DateFormat('HH:mm'),
        ),
        FormSlip2(globalKey: globalKey2),
        FormSlip3(globalKey: globalKey3),
      ],
    );
  }