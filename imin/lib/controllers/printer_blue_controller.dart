// import 'dart:typed_data';

// // import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:imin/views/widgets/form_print.dart';
// import 'package:path_provider/path_provider.dart';

// class PrinterBlueController extends GetxController {
//   var bluetooth = BlueThermalPrinter.instance;

//   List<BluetoothDevice> _devices = [];
//   var context;
//   var device;
//   var connected = false.obs;
//   var pathImage;
//   TestPrint? testPrint;
//   @override
//   void onInit() {
//     super.onInit();
//     initPlatformState();
//     // initSavetoPath();
//     testPrint = TestPrint();
//   }

//   initSavetoPath() async {
//     //read and write
//     //image max 300px X 300px
//     final filename = 'yourlogo.png';
//     // var bytes = await rootBundle.load("assets/images/yourlogo.png");
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     // writeToFile(bytes, '$dir/$filename');

//     pathImage = '$dir/$filename';
//   }

//   Future<void> initPlatformState() async {
//     bool? isConnected = await bluetooth.isConnected;
//     List<BluetoothDevice> devices = [];
//     try {
//       devices = await bluetooth.getBondedDevices();
//     } on PlatformException {
//       // TODO - Error
//     }

//     bluetooth.onStateChanged().listen((state) {
//       switch (state) {
//         case BlueThermalPrinter.CONNECTED:
//           connected.value = true;
//           print("bluetooth device state: connected");

//           break;
//         case BlueThermalPrinter.DISCONNECTED:
//           connected.value = false;
//           print("bluetooth device state: disconnected");
//           break;
//         // case BlueThermalPrinter.DISCONNECT_REQUESTED:
//         //   setState(() {
//         //     connected = false;
//         //     print("bluetooth device state: disconnect requested");
//         //   });
//         //   break;
//         case BlueThermalPrinter.STATE_TURNING_OFF:
//           connected.value = false;
//           print("bluetooth device state: bluetooth turning off");

//           break;
//         case BlueThermalPrinter.STATE_OFF:
//           connected.value = false;
//           print("bluetooth device state: bluetooth off");

//           break;
//         case BlueThermalPrinter.STATE_ON:
//           connected.value = false;
//           print("bluetooth device state: bluetooth on");

//           break;
//         case BlueThermalPrinter.STATE_TURNING_ON:
//           connected.value = false;
//           print("bluetooth device state: bluetooth turning on");

//           break;
//         case BlueThermalPrinter.ERROR:
//           connected.value = false;
//           print("bluetooth device state: error");

//           break;
//         default:
//           print(state);
//           break;
//       }
//     });

//     if (!isConnected!) return;

//     _devices = devices;

//     if (isConnected!) {
//       connected.value = true;
//     }
//   }

//   List<DropdownMenuItem<BluetoothDevice>> getDeviceItems() {
//     List<DropdownMenuItem<BluetoothDevice>> items = [];
//     if (_devices.isEmpty) {
//       items.add(DropdownMenuItem(
//         child: Text('NONE'),
//       ));
//     } else {
//       _devices.forEach((device) {
//         items.add(DropdownMenuItem(
//           child: Text(device.name!),
//           value: device,
//         ));
//       });
//     }
//     return items;
//   }

//   Future<void> connect() async {
//     if (device == null) {
//       show('No device selected.');
//     } else {
//       bluetooth.isConnected.then((isConnected) {
//         if (!isConnected!) {
//           bluetooth.connect(device).catchError((error) {
//             connected.value = false;
//           });
//           connected.value = true;
//         }
//       });
//     }
//   }

//   void disconnect() {
//     bluetooth.disconnect();
//     connected.value = false;
//   }

// //write to app path
//   // Future<void> writeToFile(ByteData data, String path) {
//   //   final buffer = data.buffer;
//   //   return new File(path).writeAsBytes(
//   //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//   // }

//   Future show(
//     String message, {
//     Duration duration: const Duration(seconds: 3),
//   }) async {
//     await new Future.delayed(new Duration(milliseconds: 100));
//     ScaffoldMessenger.of(context).showSnackBar(
//       new SnackBar(
//         content: new Text(
//           message,
//           style: new TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         duration: duration,
//       ),
//     );
//   }
// }
