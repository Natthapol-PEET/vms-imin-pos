import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/profile_image.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_input_form_field.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final emailControl = TextEditingController(text: 'Suchin12@gmail.com');
  final fullnameControl = TextEditingController(text: 'สุจิน สว่างเนตร');
  final levelControl = TextEditingController(text: 'รปภ.');
  final passwordControl = TextEditingController();

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
              Image.asset('assets/images/profile.png', scale: 3),

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
                        subDetailText('Suchin12@gmail.com'),
                        subDetailText('สุจิน สว่างเนตร'),
                        subDetailText('093-1851721'),
                        subDetailText('หัวหน้ารปภ.'),
                      ],
                    ),
                  ],
                ),
              ),
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
  return Padding(
    padding: EdgeInsets.only(bottom: padding),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: fontRegular,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Padding subDetailText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: fontRegular,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}
