import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:easy_dialog/easy_dialog.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/printer_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/controllers/walkin_controller.dart';
import 'package:imin/functions/dialog_gate.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/gate_service.dart';
import 'package:imin/views/screens/Demo/select.dart';
import 'package:imin/views/screens/EntranceProject/approve_personal_screen_d1_pro.dart';
import 'package:imin/views/screens/EntranceProject/approve_personal_screen_m2_pro.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'entrance_project_screen.dart';

// ignore: must_be_immutable
class PrinterScreen extends StatelessWidget {
  PrinterScreen({Key? key}) : super(key: key);

  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final screenController = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Obx(() => Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    left: size.width * 0.03,
                    right: size.width * 0.03),
                // padding: EdgeInsets.symmetric(
                //     vertical: size.height * 0.03, horizontal: size.width * 0.03),
                child: uploadPersonalController.screenOne.value
                    ? UploadCard()
                    : (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? NextInputM2Pro(
                            code: cameraController.response['code'])
                        : NextInputD1Pro(
                            code: cameraController.response['code']),
              )),
        ),
      ],
    );
  }
}

class UploadCard extends StatelessWidget {
  UploadCard({
    Key? key,
  }) : super(key: key);

  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final loginController = Get.put(LoginController());
  final screenController = Get.put(ScreenController());
  final printerController = Get.put(PrinterController());

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bluetooth Thermal Printer Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Search Paired Bluetooth"),
              // TextButton(
              //   onPressed: () {
              //     printerController.getBluetooth();
              //   },
              //   child: Text("Search"),
              // ),
              // GetBuilder<PrinterController>(
              //   id: 'update-printre-data-row',
              //   builder: (c) => Obx(
              //     () => Container(
              //       height: 200,
              //       child: ListView.builder(
              //         itemCount:
              //             printerController.availableBluetoothDevices.length > 0
              //                 ? printerController
              //                     .availableBluetoothDevices.length
              //                 : 0,
              //         itemBuilder: (context, index) {
              //           return ListTile(
              //             onTap: () {
              //               String select = printerController
              //                   .availableBluetoothDevices[index];
              //               List list = select.split("#");
              //               // String name = list[0];
              //               String mac = list[1];
              //               printerController.setConnect(mac);
              //             },
              //             title: Text(
              //                 '${printerController.availableBluetoothDevices[index]}'),
              //             subtitle: Text("Click to connect"),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // TextButton(
              //   onPressed: printerController.connected.value
              //       ? printerController.printGraphics
              //       : null,
              //   child: Text("Print"),
              // ),
              TextButton(
                onPressed: printerController.connected.value
                    ? printerController.printTicket
                    : printerController.printTicket,
                child: Text("Print Ticket"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
