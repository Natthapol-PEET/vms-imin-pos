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
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'entrance_project_screen.dart';

// ignore: must_be_immutable
class UploadPersonalScreen extends StatelessWidget {
  UploadPersonalScreen({Key? key}) : super(key: key);

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

  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final loginController = Get.put(LoginController());
  final screenController = Get.put(ScreenController());

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
            fontSize: (screenController.DeviceCurrent == Device.iminM2Pro)
                ? titleM2FontSize
                : 28,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: (screenController.DeviceCurrent == Device.iminM2Pro)
                  ? size.height * normalM2FontSize * 0.0001
                  : size.height * 0.02),
          child: Obx(() => Text(
                'กรุณาอัพโหลดรูป' +
                    uploadPersonalController.selectedValue.value +
                    'จริงเพื่อเข้าโครงการ',
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontSize:
                        (screenController.DeviceCurrent == Device.iminM2Pro)
                            ? normalM2FontSize
                            : 22),
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
                        fontSize:
                            (screenController.DeviceCurrent == Device.iminM2Pro)
                                ? normalM2FontSize
                                : 24,
                        fontFamily: fontRegular,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        width:
                            (screenController.DeviceCurrent == Device.iminM2Pro)
                                ? normalM2FontSize * 0.5
                                : 10),
                    Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Icon(Icons.arrow_drop_down),
                            items: (screenController.DeviceCurrent ==
                                    Device.iminM2Pro)
                                ? uploadPersonalController.itemsM2
                                : uploadPersonalController.items,
                            onChanged: (value) {
                              uploadPersonalController.selectedValue.value =
                                  value as String;
                            },
                            value: uploadPersonalController.selectedValue.value,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                    height: (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? size.height * normalM2FontSize * 0.0001
                        : 20),

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
                        : (screenController.DeviceCurrent == Device.iminM2Pro)
                            ? Image.network(
                                cameraController.imageUrl.value,
                                scale: 1.2,
                                height: (screenController.DeviceCurrent ==
                                        Device.iminM2Pro)
                                    ? size.height * normalM2FontSize * 0.035
                                    : size.height * 0.25,
                                headers: <String, String>{
                                  'Authorization':
                                      'Bearer ${loginController.dataProfile.token}'
                                },
                              )
                            : RotatedBox(
                                quarterTurns: 3,
                                child: Image.network(
                                  cameraController.imageUrl.value,
                                  scale: 1.2,
                                  height: (screenController.DeviceCurrent ==
                                          Device.iminM2Pro)
                                      ? size.height * normalM2FontSize * 0.035
                                      : size.height * 0.25,
                                  headers: <String, String>{
                                    'Authorization':
                                        'Bearer ${loginController.dataProfile.token}'
                                  },
                                ),
                              ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          (screenController.DeviceCurrent == Device.iminM2Pro)
                              ? size.height * normalM2FontSize * 0.0005
                              : size.height * 0.02),
                  child: Obx(() => Text(
                        '*กรุณาถ่ายภาพ' +
                            uploadPersonalController.selectedValue.value,
                        style: TextStyle(
                          fontFamily: fontPromptRegular,
                          fontSize: (screenController.DeviceCurrent ==
                                  Device.iminM2Pro)
                              ? smallM2FontSize
                              : 18,
                        ),
                      )),
                ),
                Obx(
                  () => RoundButtonOutline(
                    title: cameraController.imageUrl.value == ""
                        ? 'ถ่ายภาพ'
                        : 'ถ่ายภาพใหม่',
                    fontSize:
                        (screenController.DeviceCurrent == Device.iminM2Pro)
                            ? normalM2FontSize
                            : 18,
                    width: (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? size.width * 0.4
                        : 150,
                    height: (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? size.height * normalM2FontSize * 0.005
                        : 40,
                    press: () {
                      cameraController.initCamera();
                      Timer(Duration(seconds: 1), () => Get.toNamed('/camera'));
                    },
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
                SizedBox(
                    height: (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? normalM2FontSize * 0.1
                        : 5),
                Obx(
                  () => RoundButtonOutline(
                    title: cameraController.imageUrl.value == ""
                        ? 'อัพโหลดภาพ'
                        : 'อัพโหลดภาพใหม่',
                    fontSize:
                        (screenController.DeviceCurrent == Device.iminM2Pro)
                            ? normalM2FontSize
                            : 18,
                    width: (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? size.width * 0.4
                        : 150,
                    height: (screenController.DeviceCurrent == Device.iminM2Pro)
                        ? size.height * normalM2FontSize * 0.005
                        : 40,
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
                  // width: 100,
                  fontSize: (screenController.DeviceCurrent == Device.iminM2Pro)
                      ? normalM2FontSize
                      : 18,
                  width: (screenController.DeviceCurrent == Device.iminM2Pro)
                      ? size.width * 0.1
                      : 100,
                  height: (screenController.DeviceCurrent == Device.iminM2Pro)
                      ? size.height * normalM2FontSize * 0.005
                      : 40,
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
                        horizontal:
                            (screenController.DeviceCurrent == Device.iminM2Pro)
                                ? size.width * 0.03
                                : size.width * 0.03,
                        vertical:
                            (screenController.DeviceCurrent == Device.iminM2Pro)
                                ? size.height * normalM2FontSize * 0.001
                                : size.height * 0.015,
                        fontSize:
                            (screenController.DeviceCurrent == Device.iminM2Pro)
                                ? normalM2FontSize
                                : 16,
                        title: 'ถัดไป',
                        press: cameraController.imageUrl.value == ""
                            ? null
                            : () => uploadPersonalController.screenOne.value =
                                false,
                      )),
                  // SizedBox(width: size.width * 0.055),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
