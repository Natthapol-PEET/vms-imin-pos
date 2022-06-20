import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/controllers/walkin_controller.dart';
import 'package:imin/functions/dialog_gate.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/gate_service.dart';
import 'package:imin/views/screens/Demo/select.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'entrance_project_screen.dart';

// ignore: must_be_immutable
class UploadPersonalScreen extends StatelessWidget {
  UploadPersonalScreen({Key? key}) : super(key: key);

  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());

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
                    : NextInput(code: cameraController.response['code']),
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
            fontSize: 28,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02, bottom: size.height * 0.08),
          child: Obx(() => Text(
                'กรุณาอัพโหลดรูป' +
                    uploadPersonalController.selectedValue.value +
                    'จริงเพื่อเข้าโครงการ',
                style: TextStyle(
                  fontFamily: fontRegular,
                  fontSize: 22,
                ),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "ประเภทบัตร",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: fontRegular,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Icon(Icons.arrow_drop_down),
                            items: uploadPersonalController.items,
                            onChanged: (value) {
                              uploadPersonalController.selectedValue.value =
                                  value as String;
                            },
                            value: uploadPersonalController.selectedValue.value,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 20),

                Obx(
                  () => Container(
                    child: cameraController.imageUrl.value == ""
                        ? uploadPersonalController.selectedValue.value ==
                                "บัตรประจำตัวประชาชน"
                            ? Image.asset(
                                'assets/images/id-card-image.png',
                                scale: 2.5,
                              )
                            : Image.asset(
                                'assets/images/license-card.png',
                                scale: 2.5,
                              )
                        : Image.network(
                            cameraController.imageUrl.value,
                            scale: 1.2,
                            headers: <String, String>{
                              'Authorization':
                                  'Bearer ${loginController.dataProfile.token}'
                            },
                          ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Obx(() => Text(
                        '*กรุณาถ่ายภาพ' +
                            uploadPersonalController.selectedValue.value,
                        style: TextStyle(
                          fontFamily: fontPromptRegular,
                          fontSize: 18,
                        ),
                      )),
                ),
                Obx(
                  () => RoundButtonOutline(
                    title: cameraController.imageUrl.value == ""
                        ? 'ถ่ายภาพ'
                        : 'ถ่ายภาพใหม่',
                    press: () => Get.toNamed('/camera'),
                  ),
                ),
                SizedBox(height: 5),
                // Obx(
                //   () => RoundButtonOutline(
                //     title: cameraController.imageUrl.value == ""
                //         ? 'ถ่ายภาพ'
                //         : 'ถ่ายภาพใหม่',
                //     press: () async {
                //       final _imagePicker = ImagePicker();

                //       XFile _pickedFile = await _imagePicker.pickImage(
                //         source: ImageSource.camera,
                //         maxHeight: 480,
                //         maxWidth: 640,
                //         // imageQuality: 0-100
                //         imageQuality: 50,
                //       ) as XFile;
                //       // File _imageFilePicked = File(_pickedFile.path);
                //       // print(_imageFilePicked);
                //       cameraController.uploadPersonalApi(_pickedFile);
                //     },
                //   ),
                // ),
                SizedBox(height: 5),
                Obx(
                  () => RoundButtonOutline(
                    title: cameraController.imageUrl.value == ""
                        ? 'อัพโหลดภาพ'
                        : 'อัพโหลดภาพใหม่',
                    press: () async {
                      final _imagePicker = ImagePicker();

                      XFile? _pickedFile = await _imagePicker.pickImage(
                          source: ImageSource.gallery);
                      // File _imageFilePicked = File(_pickedFile);
                      // print(_pickedFile);

                      if (_pickedFile.runtimeType == Null) return;
                      cameraController.uploadPersonalApi(_pickedFile as XFile,
                          uploadPersonalController.selectedValue.value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<ExpansionPanelController>(
                builder: (c) => RoundButtonOutline(
                  width: 100,
                  title: 'ยกเลิก',
                  press: () {
                    cameraController.imageUrl.value = "";
                    uploadPersonalController.initValue();
                    c.currentContent = EntranceProjectScreen();
                    c.update(['aopbmsbbffdgkb']);
                  },
                ),
              ),
              Row(
                children: [
                  Obx(() => RoundButton(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.015,
                        title: 'ถัดไป',
                        press: cameraController.imageUrl.value == ""
                            ? null
                            : () => uploadPersonalController.screenOne.value =
                                false,
                      )),
                  SizedBox(width: size.width * 0.055),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NextInput extends StatelessWidget {
  NextInput({
    required this.code,
    Key? key,
  }) : super(key: key);

  final String code;

  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final loginController = Get.put(LoginController());
  final walkinController = Get.put(WalkinController());

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
            fontSize: 28,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02, bottom: size.height * 0.08),
          child: Text(
            'กรุณากรอกข้อมูลของผู้เข้าโครงการ',
            style: TextStyle(
              fontFamily: fontRegular,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          width: size.width * 0.74,
          height: size.height * 0.60,
          // color: Colors.red,
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          // padding: paddingOnly({left = 10}),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.32,
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
                          () => (walkinController.hasDataValue.value != true)
                              ? Container(
                                  color: themeBgColor,
                                  height: size.height * 0.5,
                                  width: size.width * 0.5,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputAddVisitor(
                    title: 'เลขประจำตัวประชาชน',
                    hintText: 'กรุณากรอกเลขประจำตัวประชาชน',
                    initValue: uploadPersonalController.idCard.value,
                    onChanged: (v) => uploadPersonalController.idCard.value = v,
                  ),
                  Obx(
                    () => uploadPersonalController.checkIdCard.value
                        ? Container()
                        : ShowEarningText(
                            text: '*กรุณากรอกและตรวจสอบเลขประจำตัวประชาชน'),
                  ),
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
                    width: 100,
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
                          vertical: size.height * 0.015,
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
                              String text = jsonDecode(
                                  utf8.decode(response.bodyBytes))['detail'];

                              EasyLoading.showInfo(text == 'Invalid Home'
                                  ? 'ไม่มีข้อมูลบ้านเลขที่นี้'
                                  : text);
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
      height: size.height * 0.6,
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
          child: RoundButton(
            title: 'พิมพ์',
            press: () {},
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.28,
          height: 45,
          // margin: EdgeInsets.only(top: 10, bottom: 20),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: TextFormField(
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: size.width * 0.28,
          height: 45,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: DropdownSearch(
            showSearchBox: true,
            items: initValue,
            // dropdownSearchDecoration:
            //     InputDecoration(hintText: 'เลือกบ้านเลขที่'),
            onChanged: onChanged,
            selectedItem: 'เลือกบ้านเลขที่',
          ),
        ),
      ],
    );
  }
}
