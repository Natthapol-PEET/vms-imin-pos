import 'dart:io';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
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
                        // : Image.file(
                        //     File(cameraController.imagePath.value)),
                        : Image.network(
                            cameraController.imageUrl.value,
                            fit: BoxFit.fitHeight,
                            height: 200,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInputAddVisitor(
                  title: 'บ้านเลขที่',
                  hintText: 'กรุณาพิมพ์บ้านเลขที่',
                  onChanged: (v) =>
                      uploadPersonalController.homeNumber.value = v,
                ),
                Obx(
                  () => uploadPersonalController.checkHomeNumber.value
                      ? Container()
                      : ShowEarningText(text: '*กรุณากรอกบ้านเลขที่'),
                ),
                // Obx(
                //   () => TextInputAddVisitor(
                //     title: 'ชื่อ - นามสกุล',
                //     hintText: '',
                //     initValue: cameraController.response['fullname'],
                //   ),
                // ),
                // Obx(
                //   () => cameraController.imageUrl.value != ""
                //       ? ShowEarningText(
                //           text: 'กรุณาตรวจสอบชื่อ - นามสกุล',
                //           color: Colors.orange,
                //         )
                //       : Container(),
                // ),
                // Obx(
                //   () => TextInputAddVisitor(
                //     title: 'เลขประจำตัวประชาชน',
                //     hintText: '',
                //     initValue: cameraController.response['idCard'],
                //   ),
                // ),
                // Obx(
                //   () => cameraController.imageUrl.value != ""
                //       ? ShowEarningText(
                //           text: 'กรุณาตรวจสอบเลขประจำตัวประชาชน',
                //           color: Colors.orange,
                //         )
                //       : Container(),
                // ),
                TextInputAddVisitor(
                  title: 'เลขทะเบียนรถ',
                  hintText: 'กรุณาพิมพ์เลขทะเบียนรถ',
                  onChanged: (v) {
                    uploadPersonalController.licensePlate.value = v;
                  },
                ),
                Obx(
                  () => uploadPersonalController.checkLicensePlate.value
                      ? Container()
                      : ShowEarningText(text: '*กรุณากรอกเลขทะเบียนรถ'),
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
                          EasyDialog(
                            width: 400,
                            height: size.height * 0.5,
                            contentListAlignment: CrossAxisAlignment.start,
                            closeButton: false,
                            // title: Text("เพิ่มผู้เข้าโครงการ"),
                            // description: Text("This is a basic dialog"),
                            contentList: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'เพิ่มผู้เข้าโครงการ',
                                    style: TextStyle(
                                      fontFamily: fontRegular,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: size.height * 0.01),
                              Divider(
                                color: dividerTableColor,
                                thickness: 2,
                              ),
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
                            ],
                          ).show(context);

                          // EasyLoading.show(status: 'กรุณารอสักครู่ ...');

                          // int statusCode = await c.checkInput(
                          //     code, loginController.dataProfile.guardId);
                          // EasyLoading.dismiss();

                          // if (statusCode == 201) {
                          //   EasyLoading.showSuccess(
                          //       'บันทึกข้อมูลเรียบร้อยแล้ว');

                          //   EasyDialog(
                          //     title: Text("Basic Easy Dialog Title"),
                          //     description: Text("This is a basic dialog"),
                          //     contentList: [],
                          //   ).show(context);
                          // }
                        }),
                  ),
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
          padding: const EdgeInsets.only(top: 12),
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
          width: size.width * 0.25,
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
