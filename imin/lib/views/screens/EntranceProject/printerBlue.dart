// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:typed_data';
// // import 'package:dropdown_search/dropdown_search.dart';
// import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
// import 'package:charset_converter/charset_converter.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:dropdownfield/dropdownfield.dart';
// import 'package:easy_dialog/easy_dialog.dart';
// // import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:imin/controllers/camera_controller.dart';
// import 'package:imin/controllers/entrance_project_controller.dart';
// import 'package:imin/controllers/expansion_panel_controller.dart';
// import 'package:imin/controllers/login_controller.dart';
// import 'package:imin/controllers/printer_controller.dart';
// import 'package:imin/controllers/screen_controller.dart';
// import 'package:imin/controllers/upload_personal_controller.dart';
// import 'package:imin/controllers/walkin_controller.dart';
// import 'package:imin/functions/dialog_gate.dart';
// import 'package:imin/helpers/configs.dart';
// import 'package:imin/helpers/constance.dart';
// import 'package:imin/services/gate_service.dart';
// import 'package:imin/views/screens/Demo/select.dart';
// import 'package:imin/views/screens/EntranceProject/approve_personal_screen_d1_pro.dart';
// import 'package:imin/views/screens/EntranceProject/approve_personal_screen_m2_pro.dart';
// import 'package:imin/views/widgets/round_button.dart';
// import 'package:imin/views/widgets/round_button_outline.dart';
// import 'entrance_project_screen.dart';

// // ignore: must_be_immutable
// class PrinterBlueScreen extends StatelessWidget {
//   PrinterBlueScreen({Key? key}) : super(key: key);

//   final uploadPersonalController = Get.put(UploadPersonalController());
//   final cameraController = Get.put(TakePictureController());
//   final screenController = Get.put(ScreenController());
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

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
//                         items: _getDeviceItems(),
//                         onChanged: (value) => setState(() => _device = value),
//                         value: _device,
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
//                         initPlatformState();
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
//                           primary: _connected ? Colors.red : Colors.green),
//                       onPressed: _connected ? _disconnect : _connect,
//                       child: Text(
//                         _connected ? 'Disconnect' : 'Connect',
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
//                       testPrint!.sample(pathImage);
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


