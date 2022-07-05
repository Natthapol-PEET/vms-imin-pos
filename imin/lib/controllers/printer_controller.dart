import 'dart:typed_data';

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/register_walkin_service.dart';
import 'package:intl/intl.dart';

class PrinterController extends GetxController {
  final loginController = Get.put(LoginController());
  final screenController = Get.put(ScreenController());
  final takePictureController = Get.put(TakePictureController());
  final uploadPersonalController = Get.put(UploadPersonalController());

  var connected = false.obs;
  var availableBluetoothDevices = [].obs;
  var homeNumber = ''.obs;
  var qrId = ''.obs;
  @override
  void onInit() {
    this.setConnect('');
    super.onInit();
  }

  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
    availableBluetoothDevices.value = bluetooths!;
    update(['update-printre-data-row']);
  }

  Future<void> setConnect(String mac) async {
    final String? result =
        await BluetoothThermalPrinter.connect('00:11:22:33:44:55');
    print("state conneected mac $mac");
    print("state conneected $result");
    if (result == "true") {
      connected.value = true;
    }
  }

  Future<void> printTicket() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    print('ticket');
    if (isConnected == "true") {
      List<int> bytes = await getTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      // final result = await BluetoothThermalPrinter.writeBytes([240, 241]);
      // final result = await BluetoothThermalPrinter.writeText();

      print("Print: $result");
    } else {
      //Hadnle Not Connected Senario
    }
    // const PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    // final printer = NetworkPrinter(paper, profile);

    // final PosPrintResult res =
    //     await printer.connect('192.168.0.123', port: 9100);

    // if (res == PosPrintResult.success) {
    //   // testReceipt(printer);
    //   printer.sendraw('asd');
    //   printer.disconnect();
    // }

    // print('Print result: ${res.msg}');
  }

  Future<void> printGraphics() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> bytes = await getGraphicsTicket();
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  Future<List<int>> getGraphicsTicket() async {
    List<int> bytes = [];

    return bytes;
  }

  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    final fDate = new DateFormat('dd/MM/yy');
    final fTime = new DateFormat('HH:mm');
    print('check D1 ${qrId}');
    // Text(f.format(DateTime.now()));
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.setGlobalCodeTable('CP874');
    // final  profile = await CapabilityProfile.getAvailableProfiles();
    // final generator = Generator(PaperSize.mm58, profile);
    // final Ticket generator = Ticket(PaperSize.mm58, profile);
    // final Ticket generator = Ticket(PaperSize.mm58, profile);

    bytes += generator.text("ARTANI",
        styles: PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);
    bytes +=
        generator.text("home No.: ${uploadPersonalController.homeNumber.value}",
            styles: PosStyles(
              align: PosAlign.center,
            ),
            containsChinese: true);
    bytes += generator.text(
        'Date : ${fDate.format(DateTime.now())} Time : ${fTime.format(DateTime.now())}',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text(' ', styles: PosStyles(align: PosAlign.center));
    bytes += generator.qrcode(
      qrId.value,
      size: QRSize(0x10),
    );
    bytes += generator.text(' ', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Scan QR to enter the project.',
        styles: PosStyles(
          align: PosAlign.center,
        ));
    bytes += generator.hr(ch: '_');
    bytes += generator.text('Note.',
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
        ));
    bytes += generator.text(
        '1. if there is a charge,Payment must be made via Mobile Payment before leaving the village',
        styles: PosStyles(
          align: PosAlign.left,
        ));
    bytes += generator.text(
        "2. If you don't get an E-Stamp before leaving the project,Contact the residents or juristic persons to make an E-Stamp.",
        styles: PosStyles(
          align: PosAlign.left,
        ));

    // bytes += generator.text("บ้านเลขที่ 1/1",
    //     styles: PosStyles(align: PosAlign.center, codeTable: 'CP1252'),
    //     containsChinese: true);
    // var byte = utf8.encode('บ้านเลขที่ 1/1');
    // Uint8List encoded =
    //     await CharsetConverter.encode("IBM-Thai", "บ้านเลขที่ 1/1");
    // String decoded =
    //     await CharsetConverter.decode("IBM-Thai", Uint8List.fromList(encoded));
    // List<String> charsets = await CharsetConverter.availableCharsets();
    // print(Type());
    // bytes += generator.text(decoded,
    //     styles: PosStyles(codeTable: 'cp874'), containsChinese: true);

    Uint8List encThai =
        await CharsetConverter.encode("CP865", "Thai: ใบเสร็จ-ใบรับผ้า");
    String decoded =
        await CharsetConverter.decode("CP865", Uint8List.fromList(encThai));
    // print('decoded 865');

    Uint8List encThaiCP874 =
        await CharsetConverter.encode("CP874", "Thai: ใบเสร็จ-ใบรับผ้า");
    String decodedCP874 = await CharsetConverter.decode(
        "CP874", Uint8List.fromList(encThaiCP874));
    // print('decoded CP874');
    // print(decodedCP874);

    // bytes += generator.textEncoded(encThaiCP874,
    //     styles: PosStyles(codeTable: 'CP874'));
    // bytes += generator.text(decodedCP874,
    //     styles: PosStyles(codeTable: 'CP874'), containsChinese: true);

    // print('bytes');
    // print(bytes);
    ////////////////////////////
    bytes += generator.cut();
    return bytes;
    // return [];
  }
}
