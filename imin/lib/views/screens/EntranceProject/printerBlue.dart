// // import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:imin/controllers/camera_controller.dart';
// import 'package:imin/controllers/printer_blue_controller.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:imin/controllers/upload_personal_controller.dart';

// // ignore: must_be_immutable
// class PrinterBlueScreen extends StatelessWidget {
//   PrinterBlueScreen({Key? key}) : super(key: key);

//   final uploadPersonalController = Get.put(UploadPersonalController());
//   final cameraController = Get.put(TakePictureController());
//   final printerBlueController = Get.put(PrinterBlueController());
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     printerBlueController.context = context;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Blue Thermal Printer'),
//         ),
//         body: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView(
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'Device:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Expanded(
//                       child: DropdownButton(
//                         items: printerBlueController.getDeviceItems(),
//                         onChanged: (value) =>{printerBlueController.device.value = value},
//                         value: printerBlueController.device,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(primary: Colors.brown),
//                       onPressed: () {
//                         printerBlueController.initPlatformState();
//                       },
//                       child: Text(
//                         'Refresh',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           primary: printerBlueController.connected.value ? Colors.red : Colors.green),
//                       onPressed:() {printerBlueController.connected.value == true ? printerBlueController.disconnect() : printerBlueController.connect();},
//                       child: Text(
//                         printerBlueController.connected.value ? 'Disconnect' : 'Connect',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: Colors.brown),
//                     onPressed: () {
//                       printerBlueController.testPrint!.sample('pathImage');
//                     },
//                     child: Text('PRINT TEST',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
