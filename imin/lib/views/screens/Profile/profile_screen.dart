import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/ChangePassword/change_password_screen.dart';
import 'package:imin/views/screens/EntranceProject/entrance_project_screen.dart';
import 'package:imin/views/widgets/profile_image.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';
import 'package:imin/views/widgets/round_input_form_field.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  final emailControl = TextEditingController(text: 'Suchin12@gmail.com');
  final fullnameControl = TextEditingController(text: 'สุจิน สว่างเนตร');
  final levelControl = TextEditingController(text: 'รปภ.');
  final passwordControl = TextEditingController();
  final screenController = Get.put(ScreenController());
  // final expandController = Get.put(ExpansionPanelController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        // Background
        Image.asset('assets/images/background-profile.png'),
        // prolile large
        Positioned(
          top: size.height * 0.05,
          child: Column(
            children: [
              // Profile
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (controller) => CircleAvatar(
                  radius: (screenController.DeviceCurrent == Device.iminM2Pro)
                      ? 50
                      : 120,
                  backgroundImage: NetworkImage(
                    ipServer +
                        '/guard/profile_image/' +
                        controller.dataProfile.profilePath,
                    headers: <String, String>{
                      'Authorization':
                          'Bearer ${loginController.dataProfile.token}'
                    },
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),

              // Content
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subTitleText('อีเมล', 20),
                        subTitleText('ชื่อ-นามสกุล', 20),
                        subTitleText('เบอร์โทรศัพท์', 20),
                        subTitleText('ระดับ', 20),
                      ],
                    ),
                    SizedBox(width: size.width * 0.03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<LoginController>(
                          builder: (v) => subDetailText(v.dataProfile.email),
                        ),
                        GetBuilder<LoginController>(
                          builder: (v) => subDetailText(
                              '${v.dataProfile.firstname} ${v.dataProfile.lastname}'),
                        ),
                        GetBuilder<LoginController>(
                          builder: (v) =>
                              subDetailText(v.dataProfile.phoneNumber ?? '-'),
                        ),
                        GetBuilder<LoginController>(
                          builder: (v) => subDetailText(
                              v.dataProfile.role == 'guard'
                                  ? 'รปภ.'
                                  : 'หัวหน้า รปภ.'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              (screenController.DeviceCurrent == Device.iminM2Pro)
                  ? GetBuilder<ExpansionPanelController>(
                      builder: (c) => RoundButtonOutline(
                        title: 'แก้ไขข้อมูลส่วนตัว',
                        fontSize: normalM2FontSize,
                        press: () {
                          c.currentContent = ChangePasswordScreen();
                          c.update(['aopbmsbbffdgkb']);
                        },
                      ),
                    )
                  // Container()
                  // ? RoundButtonOutline(
                  //     title: 'แก้ไขข้อมูลส่วนตัว',
                  //     fontSize: normalM2FontSize,
                  //     press: () {
                  //       // expandController.currentContent =
                  //       //     EntranceProjectScreen()
                  //     },

                  //     // press: () async => confirmEditInfomation(context, size),
                  //     // press: () async => saveInfomationStatus(context, size),
                  //   )
                  : Container()
              // RoundButton
              // RoundButtonOutline(
              //   title: 'แก้ไขข้อมูลส่วนตัว',
              //   press: () async => editInfomation(
              //     context,
              //     size,
              //     _formKey,
              //     emailControl,
              //     fullnameControl,
              //     levelControl,
              //   ),
              //   // press: () async => confirmEditInfomation(context, size),
              //   // press: () async => saveInfomationStatus(context, size),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Future saveInfomationStatus(BuildContext context, Size size) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: size.height * 0.02),
              width: size.width * 0.07,
              height: size.width * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: false ? greenDoneColor : Colors.redAccent.shade200,
              ),
              child: Icon(
                false ? Icons.done : Icons.close,
                color: Colors.white,
                size: 70,
              ),
            ),
            Text(
              false ? 'บันทึกสำเร็จ' : 'รหัสผ่านไม่ถูกต้อง',
              style: TextStyle(fontFamily: fontRegular, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future confirmEditInfomation(BuildContext context, Size size) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ยืนยันการแก้ไขข้อมูลส่วนตัว',
                    style: TextStyle(
                      fontFamily: fontRegular,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      color: grey3Color,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Divider(color: dividerColor),
            ],
          ),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subTitleText('กรุณาใส่รหัสผ่านเพื่อยืนยันตัวตน', 10),
              RoundInputFormField(
                textControl: passwordControl,
                hintText: 'กรุณาพิมพ์รหัสผ่าน',
              ),
            ],
          ),
        ),
        actions: [
          RoundButton(title: 'ตกลง', press: () => Get.back()),
        ],
      ),
    );
  }
}

Future editInfomation(
    BuildContext context,
    Size size,
    GlobalKey _formKey,
    TextEditingController emailControl,
    TextEditingController fullnameControl,
    TextEditingController levelControl) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      title: Container(
        width: size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'แก้ไขข้อมูลส่วนตัว',
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: grey3Color,
                    size: 24,
                  ),
                ),
              ],
            ),
            Divider(color: dividerColor),
          ],
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImage(),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subTitleText('อีเมล', 10),
                RoundInputFormField(
                  textControl: emailControl,
                ),
                subTitleText('ชื่อ-นามสกุล', 10),
                RoundInputFormField(
                  textControl: fullnameControl,
                ),
                subTitleText('ระดับ', 10),
                RoundInputFormField(
                  textControl: levelControl,
                  readOnly: true,
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        RoundButton(title: 'บันทึก', press: () => Get.back()),
      ],
    ),
  );
}

Padding subTitleText(String text, double padding) {
  final screenController = Get.put(ScreenController());
  return Padding(
    padding: EdgeInsets.only(bottom: padding),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: fontRegular,
        fontSize: (screenController.DeviceCurrent == Device.iminM2Pro)
            ? normalM2FontSize
            : 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Padding subDetailText(String text) {
  final screenController = Get.put(ScreenController());
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: fontRegular,
        fontWeight: FontWeight.w400,
        fontSize: (screenController.DeviceCurrent == Device.iminM2Pro)
            ? normalM2FontSize
            : 18,
      ),
    ),
  );
}
