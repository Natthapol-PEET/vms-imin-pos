import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/cupertino.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:imin/views/widgets/picture_to_slip_printer.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'package:intl/intl.dart';
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
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final loginController = Get.put(LoginController());
  final screenController = Get.put(ScreenController());
  final printerController = Get.put(PrinterController());

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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

    // Future<Uint8List> createImageFromWidget(Widget widget,
    //     {Duration? wait, Size? logicalSize, Size? imageSize}) async {
    //   final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    //   logicalSize ??= window.physicalSize / window.devicePixelRatio;
    //   imageSize ??= window.physicalSize;

    //   assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    //   final RenderView renderView = RenderView(
    //     window: ,
    //     child: RenderPositionedBox(
    //         alignment: Alignment.center, child: repaintBoundary),
    //     configuration: ViewConfiguration(
    //       size: logicalSize,
    //       devicePixelRatio: 1.0,
    //     ),
    //   );

    //   final PipelineOwner pipelineOwner = PipelineOwner();
    //   final BuildOwner buildOwner = BuildOwner();

    //   pipelineOwner.rootNode = renderView;
    //   renderView.prepareInitialFrame();

    //   final RenderObjectToWidgetElement<RenderBox> rootElement =
    //       RenderObjectToWidgetAdapter<RenderBox>(
    //     container: repaintBoundary,
    //     child: widget,
    //   ).attachToRenderTree(buildOwner);

    //   buildOwner.buildScope(rootElement);

    //   if (wait != null) {
    //     await Future.delayed(wait);
    //   }

    //   buildOwner.buildScope(rootElement);
    //   buildOwner.finalizeTree();

    //   pipelineOwner.flushLayout();
    //   pipelineOwner.flushCompositingBits();
    //   pipelineOwner.flushPaint();

    //   final Image image = await repaintBoundary.toImage(
    //       pixelRatio: imageSize.width / logicalSize.width);
    //   final ByteData byteData =
    //       await image.toByteData(format: ImageByteFormat.png);

    //   return byteData.buffer.asUint8List();
    // }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bluetooth Thermal Printer Demo'),
        ),
        body: Container(
          // padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: printerController.connected.value
                    ? () {
                        // printerController.printTicket();
                        // printerController.globalPicKey.value = globalKey;
                        capturePng();
                      }
                    : () {
                        // printerController.printTicket();
                        capturePng();
                      },
                child: Text("Print Ticket"),
              ),
              // FormPrinterPic(globalKey: globalKey),
              FormSlip(
                globalKey: globalKey,
                homeAddress: '11/3',
                onDate: new DateFormat('dd/MM/yy'),
                onTime: new DateFormat('HH:mm'),
              ),
              FormSlip2(globalKey: globalKey2),
              FormSlip3(globalKey: globalKey3),
              // Opacity(
              //     opacity: 1.0,
              //     child: new Padding(
              //       padding: const EdgeInsets.only(
              //         left: 16.0,
              //       ),
              //       child: FormSlip(globalKey: globalKey),
              //     ))
              // Capturer(
              //   overRepaintKey: globalKey,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class FormSlip extends StatelessWidget {
//   const FormSlip({
//     Key? key,
//     required this.globalKey,
//     required this.homeAddress,
//     this.onDate,
//     this.onTime,
//   }) : super(key: key);

//   final GlobalKey<State<StatefulWidget>> globalKey;
//   final homeAddress;
//   final onDate;
//   final onTime;
//   // final onDate = new DateFormat('dd/MM/yy');
//   //   final onTime = new DateFormat('HH:mm');

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: globalKey,
//       child: Container(
//           width: 450,
//           color: Colors.white,
//           child:
//               //  Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [Text('ทดสอบ'), Text('data')],
//               // ),
//               Column(
//             children: [
//               Text(
//                 'บ้านเลขที่ ${homeAddress}',
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text(
//                   'วันที่ : ${onDate.format(DateTime.now())} เวลา : ${onTime.format(DateTime.now())}',
//                   style: TextStyle(fontSize: 20))
//             ],
//           )),
//     );
//   }
// }

// class FormSlip2 extends StatelessWidget {
//   const FormSlip2({
//     Key? key,
//     required this.globalKey,
//   }) : super(key: key);

//   final GlobalKey<State<StatefulWidget>> globalKey;

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: globalKey,
//       child: Container(
//           width: 450,
//           color: Colors.white,
//           child:
//               //  Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [Text('ทดสอบ'), Text('data')],
//               // ),
//               Column(
//             children: [
//               Text(
//                 'แสกน QR นี้เพื่อแสกนเข้าโครงการ',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ],
//           )),
//     );
//   }
// }

// class FormSlip3 extends StatelessWidget {
//   const FormSlip3({
//     Key? key,
//     required this.globalKey,
//   }) : super(key: key);

//   final GlobalKey<State<StatefulWidget>> globalKey;

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: globalKey,
//       child: Container(
//           width: 450,
//           color: Colors.white,
//           child:
//               //  Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [Text('ทดสอบ'), Text('data')],
//               // ),
//               Column(
//             children: [
//               Text(
//                 'หมายเหตุ',
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text(
//                   '1. หากมีการชำระเงินต้องทำการชำระเงินผ่าน Mobile Payment ให้เรียบร้อยก่อนออกจากโครงการ',
//                   style: TextStyle(fontSize: 20)),
//               Text(
//                   '2. หากไม่ได้ E-Stamp ก่อนออกจากโครงการ ให้ติดต่อลูกบ้านหรือนิติบุคคลเพื่อทำการ E-Stamp',
//                   style: TextStyle(fontSize: 20)),
//             ],
//           )),
//     );
//   }
// }

// class Capturer extends StatelessWidget {
//   static final Random random = Random();

//   // final GlobalKey<OverRepaintBoundaryState> overRepaintKey;
//   final GlobalKey<State<StatefulWidget>> overRepaintKey;

//   const Capturer({Key? key, required this.overRepaintKey}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: OverRepaintBoundary(
//         key: overRepaintKey,
//         child: RepaintBoundary(
//           child: Column(
//             children: List.generate(
//               30,
//               (i) => Container(
//                 color: Color.fromRGBO(random.nextInt(256), random.nextInt(256),
//                     random.nextInt(256), 1.0),
//                 height: 100,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OverRepaintBoundary extends StatefulWidget {
//   final Widget child;

//   const OverRepaintBoundary({Key? key, required this.child}) : super(key: key);

//   @override
//   OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
// }

// class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
