import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
import 'package:imin/views/widgets/picture_to_slip_printer.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'package:imin/views/widgets/show_detail_printer.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'entrance_project_screen.dart';

// ignore: must_be_immutable

class NextInputM2Pro extends StatelessWidget {
  NextInputM2Pro({
    required this.code,
    Key? key,
  }) : super(key: key);

  final String code;

  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final loginController = Get.put(LoginController());
  final walkinController = Get.put(WalkinController());
  final screenController = Get.put(ScreenController());
  final printerController = Get.put(PrinterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'เพิ่มผู้เข้าโครงการ',
          style: TextStyle(
            color: Colors.black,
            fontFamily: fontRegular,
            fontWeight: FontWeight.w600,
            fontSize: titleM2FontSize,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * normalM2FontSize * 0.001),
          child: Text(
            'กรุณากรอกข้อมูลของผู้เข้าโครงการ',
            style: TextStyle(
              fontFamily: fontRegular,
              fontSize: normalM2FontSize,
            ),
          ),
        ),
        Container(
          height: size.height * 0.60,
          // color: Colors.red,
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          // padding: paddingOnly({left = 10}),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextInputAddVisitor(
                  //   title: 'เลขประจำตัวประชาชน',
                  //   hintText: 'กรุณากรอกเลขประจำตัวประชาชน',
                  //   initValue: uploadPersonalController.idCard.value,
                  //   onChanged: (v) => uploadPersonalController.idCard.value = v,
                  // ),
                  // Obx(
                  //   () => uploadPersonalController.checkIdCard.value
                  //       ? Container()
                  //       : ShowEarningText(
                  //           text: '*กรุณากรอกและตรวจสอบเลขประจำตัวประชาชน'),
                  // ),
                  GetBuilder<WalkinController>(
                    id: 'update-walkin-home-data',
                    init: WalkinController(),
                    builder: (controller) => TextInputSelect(
                      title: 'บ้านเลขที่',
                      hintText: 'กรุณากรอกบ้านเลขที่',
                      initValue: controller.homeListData,
                      // controller: controller,
                      onChanged: (v) {
                        uploadPersonalController.homeNumber.value = v as String;
                        controller.filterSearchResults(v);
                      },
                    ),
                  ),
                  Obx(
                    () => uploadPersonalController.checkHomeNumber.value
                        ? Container()
                        : ShowEarningText(text: '*กรุณากรอกบ้านเลขที่'),
                  ),
                  TextInputAddVisitor(
                    title: 'เลขทะเบียนรถ',
                    hintText: 'กรุณากรอกเลขทะเบียนรถ',
                    initValue: uploadPersonalController.licensePlate.value,
                    onChanged: (v) =>
                        uploadPersonalController.licensePlate.value = v,
                  ),
                  Container(
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.00,
                        vertical: size.height * 0.01),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: dividerTableColor),
                      child: GetBuilder<WalkinController>(
                        id: 'update-walkin-data-row',
                        builder: (c) =>
                            // Obx(() =>
                            Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DataTable(
                              showCheckboxColumn: false,
                              dividerThickness: 0.5,
                              columnSpacing: double.infinity,
                              // (walkinController.hasDataValue.value != true)
                              //     ? 150
                              //     : 150,
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => grey3Color),
                              columns: c.createColumns(size),
                              // columns: _createColumns(),
                              rows: c.dataRow,
                            ),
                            Obx(
                              () =>
                                  (walkinController.hasDataValue.value != true)
                                      ? Container(
                                          color: themeBgColor,
                                          height: size.height * 0.2,
                                          width: size.width * 0.7,
                                          child: Image.asset(
                                            'assets/images/NodataTable.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(),
                            ),
                          ],
                        ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.03,
                left: size.height * 0.055,
                right: size.height * 0.055),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<ExpansionPanelController>(
                  builder: (c) => RoundButtonOutline(
                    fontSize: normalM2FontSize,
                    width: size.width * 0.1,
                    height: size.height * normalM2FontSize * 0.005,
                    title: 'ย้อนกลับ',
                    press: () {
                      uploadPersonalController.screenOne.value = true;
                    },
                  ),
                ),
                Row(
                  children: [
                    GetBuilder<UploadPersonalController>(
                      builder: (c) => RoundButton(
                          horizontal: size.width * 0.03,
                          vertical: size.height * normalM2FontSize * 0.001,
                          fontSize: normalM2FontSize,
                          title: 'บันทึก',
                          press: () async {
                            EasyLoading.show(status: 'กรุณารอสักครู่ ...');

                            var response = await c.checkInput(
                                code, loginController.dataProfile.guardId);
                            EasyLoading.dismiss();

                            if (response.runtimeType == int) {
                              return;
                            }

                            if (response.statusCode == 201) {
                              EasyLoading.showSuccess(
                                  'บันทึกข้อมูลเรียบร้อยแล้ว');

                              dialogPrinter(size, context).show(context);
                            } else {
                              try {
                                String text = jsonDecode(
                                    utf8.decode(response.bodyBytes))['detail'];
                                EasyLoading.showInfo(text == 'Invalid Home'
                                    ? 'ไม่มีข้อมูลบ้านเลขที่นี้'
                                    : text);
                              } catch (e) {
                                EasyLoading.showInfo('กรุณาลองใหม่อีกครั้ง');
                              }
                            }
                          }),
                    ),
                    // SizedBox(width: size.width * 0.055),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  EasyDialog dialogPrinter(Size size, BuildContext context) {
    return EasyDialog(
      width: 400,
      height: size.height * 0.7,
      contentListAlignment: CrossAxisAlignment.start,
      closeButton: false,
      contentList: [
        Text(
          'เพิ่มผู้เข้าโครงการ',
          style: TextStyle(
            fontFamily: fontRegular,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Divider(color: dividerTableColor, thickness: 2),
        SizedBox(height: size.height * 0.01),
        Text(
          'พิมพ์ใบเสร็จให้กับผู้ที่ต้องการเข้ามาในโครงการ',
          style: TextStyle(
            fontFamily: fontRegular,
            fontSize: 18,
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Center(
          child: Image.asset(
            'assets/images/printer.png',
            scale: 2,
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Center(
          child:
              // GetBuilder<PrinterController>(
              GetBuilder<ExpansionPanelController>(
            id: 'update-printre-data-row',
            builder: (c) => RoundButton(
              title: 'พิมพ์',
              press: () {
                // c.printTicket();
                // c.currentContent = UploadPersonalScreen();
                dialogDetailPicPrinter(size, context).show(context);
                c.update(['aopbmsbbffdgkb']);
                print('print Reciepe');
              },
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Center(
          child: GetBuilder<ExpansionPanelController>(
            builder: (c) => RoundButtonOutline(
              title: 'เปิดไม้กั้น',
              press: () {
                Get.back();
                showDialogOpenGate([]).show(context);
                Timer(Duration(seconds: 3), () {
                  Get.back();
                  c.currentContent = EntranceProjectScreen();
                  c.update(['aopbmsbbffdgkb']);
                });

                // ----------- gate ------------------
                gateController(gateBarrierOpenUrl);
                Future.delayed(Duration(seconds: 8),
                    () => gateController(gateBarrierCloseUrl));
                // ----------- gate ------------------
              },
            ),
          ),
        ),
      ],
    );
  }

  // EasyDialog dialogDetailPicPrinter(Size size, BuildContext context) {
  //   GlobalKey globalKey = GlobalKey();
  //   GlobalKey globalKey2 = GlobalKey();
  //   GlobalKey globalKey3 = GlobalKey();
  //   Future<void> capturePng() async {
  //     RenderRepaintBoundary boundary =
  //         globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     RenderRepaintBoundary boundary2 = globalKey2.currentContext!
  //         .findRenderObject() as RenderRepaintBoundary;
  //     RenderRepaintBoundary boundary3 = globalKey3.currentContext!
  //         .findRenderObject() as RenderRepaintBoundary;
  //     var image = await boundary.toImage();
  //     var image2 = await boundary2.toImage();
  //     var image3 = await boundary3.toImage();
  //     print('image');
  //     print(image);
  //     ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
  //     ByteData? byteData2 =
  //         await image2.toByteData(format: ImageByteFormat.png);
  //     ByteData? byteData3 =
  //         await image3.toByteData(format: ImageByteFormat.png);
  //     // printerController.printTicketPic(byteData);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();
  //     Uint8List pngBytes2 = byteData2!.buffer.asUint8List();
  //     Uint8List pngBytes3 = byteData3!.buffer.asUint8List();
  //     // list
  //     printerController.printTicketPic(pngBytes, pngBytes2, pngBytes3);
  //     // print('pngBytes');
  //     // print(pngBytes);
  //     // YOUR_BYTES = pngBytes;
  //   }

  //   Timer(Duration(milliseconds: 150), () {
  //     // EasyLoading.dismiss();
  //     capturePng();
  //     Get.back();
  //     // Get.toNamed('/login');
  //   });

  //   return EasyDialog(
  //     width: 400,
  //     height: size.height * 0.7,
  //     contentListAlignment: CrossAxisAlignment.start,
  //     closeButton: false,
  //     contentList: [
  //       FormSlip(
  //         globalKey: globalKey,
  //         homeAddress: uploadPersonalController.homeNumber.value,
  //         onDate: new DateFormat('dd/MM/yy'),
  //         onTime: new DateFormat('HH:mm'),
  //       ),
  //       FormSlip2(globalKey: globalKey2),
  //       FormSlip3(globalKey: globalKey3),
  //     ],
  //   );
  // }
}

class ShowEarningText extends StatelessWidget {
  const ShowEarningText({
    Key? key,
    required this.text,
    this.color = Colors.red,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: fontRegular,
        color: color,
        fontSize: 16,
      ),
    );
  }
}

class TextInputAddVisitor extends StatelessWidget {
  const TextInputAddVisitor({
    Key? key,
    required this.title,
    required this.hintText,
    this.initValue = "",
    this.controller,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final String hintText;
  final String initValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: fontRegular,
              fontSize: normalM2FontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.7,
          height: 45,
          // margin: EdgeInsets.only(top: 10, bottom: 20),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: TextFormField(
            style: TextStyle(fontSize: normalM2FontSize),
            // enabled: false,
            // readOnly: true,
            controller: initValue == "" ? controller : TextEditingController()
              ?..text = initValue,
            onChanged: onChanged,
            cursorColor: dividerTableColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: dividerTableColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: dividerTableColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}

class TextInputSelect extends StatelessWidget {
  const TextInputSelect({
    Key? key,
    required this.title,
    required this.hintText,
    this.initValue,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final String hintText;
  final List<String>? initValue;
  final TextEditingController? controller;
  final Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: fontRegular,
              fontSize: normalM2FontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.7,
          height: 45,
          // padding: EdgeInsets.only(bottom: 5),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Theme(
            data: ThemeData(
                textTheme:
                    TextTheme(subtitle1: TextStyle(fontSize: normalM2FontSize)),
                buttonColor: Colors.amber),
            child: DropdownSearch(
              // dropdownSearchBaseStyle: TextStyle(fontSize: 10),
              showSearchBox: true,
              items: initValue,
              // dropdownSearchDecoration:
              //     InputDecoration(hintText: 'เลือกบ้านเลขที่'),
              onChanged: onChanged,
              selectedItem: 'เลือกบ้านเลขที่',
            ),
          ),
        ),
      ],
    );
  }
}
