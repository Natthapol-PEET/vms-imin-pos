import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';

class UploadPersonalScreen extends StatelessWidget {
  UploadPersonalScreen({Key? key}) : super(key: key);

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
                        RoundButtonOutline(
                          title: 'ถ่ายภาพ',
                          press: () => Get.toNamed('/camera'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.08),
                      child: Column(
                        children: [
                          TextInputAddVisitor(
                            title: 'บ้านเลขที่',
                            hintText: 'กรุณาพิมพ์บ้านเลขที่',
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
                            () => TextInputAddVisitor(
                              title: 'เลขประจำตัวประชาชน',
                              hintText: '',
                              initValue: cameraController.response['idCard'],
                            ),
                          ),
                          TextInputAddVisitor(
                            title: 'เลขทะเบียนรถ',
                            hintText: 'กรุณาพิมพ์เลขทะเบียนรถ',
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
                      RoundButtonOutline(
                        width: 100,
                        title: 'ยกเลิก',
                        press: () {},
                      ),
                      Row(
                        children: [
                          RoundButton(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.015,
                            title: 'บันทึก',
                            press: () {},
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

class TextInputAddVisitor extends StatelessWidget {
  const TextInputAddVisitor({
    Key? key,
    required this.title,
    required this.hintText,
    this.initValue = "",
  }) : super(key: key);

  final String title;
  final String hintText;
  final String initValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: fontRegular,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: size.width * 0.25,
          height: 45,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          child: TextField(
            controller: TextEditingController()..text = initValue,
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
              // labelText: 'กรุณาพิมพ์บ้านเลขที่',
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
