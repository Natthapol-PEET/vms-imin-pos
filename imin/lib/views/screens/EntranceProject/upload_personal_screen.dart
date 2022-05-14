import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
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
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.03,
                left: size.width * 0.03,
                right: size.width * 0.03),
            // padding: EdgeInsets.symmetric(
            //     vertical: size.height * 0.03, horizontal: size.width * 0.03),
            child: Column(
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
                    'กรุณาอัพโหลดรูปบัตรประชาชนจริงเพื่อกรอกข้อมูลของผู้เข้าโครงการ',
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Container(
                            child: cameraController.imagePath.value == ""
                                ? Image.asset(
                                    'assets/images/id-card-image.png',
                                    scale: 2,
                                  )
                                : Image.file(
                                    File(cameraController.imagePath.value)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02),
                          child: Text(
                            '*กรุณาถ่ายภาพบัตรประชาชน',
                            style: TextStyle(
                              fontFamily: fontPromptRegular,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Obx(
                          () => RoundButtonOutline(
                            title: cameraController.imagePath.value == ""
                                ? 'ถ่ายภาพ'
                                : 'ถ่ายภาพใหม่',
                            press: () => Get.toNamed('/camera'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.08),
                      child: Column(
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
                          Obx(
                            () => TextInputAddVisitor(
                              title: 'ชื่อ - นามสกุล',
                              hintText: '',
                              initValue:
                                  cameraController.response['firstname'] +
                                      " " +
                                      cameraController.response['lastname'],
                            ),
                          ),
                          Obx(
                            () => cameraController.imagePath.value != ""
                                ? ShowEarningText(
                                    text: 'กรุณาตรวจสอบชื่อ - นามสกุล',
                                    color: Colors.orange,
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => TextInputAddVisitor(
                              title: 'เลขประจำตัวประชาชน',
                              hintText: '',
                              initValue: cameraController.response['idCard'],
                            ),
                          ),
                          Obx(
                            () => cameraController.imagePath.value != ""
                                ? ShowEarningText(
                                    text: 'กรุณาตรวจสอบเลขประจำตัวประชาชน',
                                    color: Colors.orange,
                                  )
                                : Container(),
                          ),
                          TextInputAddVisitor(
                            title: 'เลขทะเบียนรถ',
                            hintText: 'กรุณาพิมพ์เลขทะเบียนรถ',
                            onChanged: (v) {
                              uploadPersonalController.licensePlate.value = v;
                            },
                          ),
                          Obx(
                            () =>
                                uploadPersonalController.checkLicensePlate.value
                                    ? Container()
                                    : ShowEarningText(
                                        text: '*กรุณากรอกเลขทะเบียนรถ'),
                          ),
                        ],
                      ),
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
                          GetBuilder<UploadPersonalController>(
                            builder: (c) => RoundButton(
                                horizontal: size.width * 0.03,
                                vertical: size.height * 0.015,
                                title: 'บันทึก',
                                press: () {
                                  if (cameraController.imagePath.value == "") {
                                    EasyLoading.showInfo(
                                        'กรุณาถ่ายภาพบัตรประชาชน');
                                    return;
                                  }

                                  c.checkInput(
                                    cameraController.response['firstname'],
                                    cameraController.response['lastname'],
                                    cameraController.response['idCard'],
                                  );
                                }),
                          ),
                          SizedBox(width: size.width * 0.055),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
            controller: initValue == "" ? controller : controller
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
