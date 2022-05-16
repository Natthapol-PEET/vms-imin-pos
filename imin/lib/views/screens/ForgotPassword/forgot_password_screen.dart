import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_text_form_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final expandController = Get.put(ExpansionPanelController());
  final onWillPopController = Get.put(OnWillPopController());

  // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Dialog Exit App
    onWillPopController.context = context;

    return WillPopScope(
      onWillPop: onWillPopController.onWillPop,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Container(
                color: themeBgColor,
                height: size.height,
                width: size.width,
                child: Image.asset(
                  'assets/images/forgot_password.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: Container(
                  width: size.width / 1,
                  height: size.height,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.375),
                  // color: themeBgColor,
                  // color: themeBgColor.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 3,
                        height: size.height / 1.8,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0),
                        child: Form(
                          // key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // text
                              Text(
                                'ลืมรหัสผ่าน',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: fontRegular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.038),
                              Text(
                                'กรุณากรอกอีเมลที่ลงทะเบียนไว้',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: fontRegular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'ระบบจะส่งลิงค์รีเซ็ทรหัสผ่านให้ทางอีเมลของคุณ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: fontRegular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // email
                              Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.017),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'กรอกอีเมล',
                                    contentPadding: EdgeInsets.only(left: 20),
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height * 0.017),
                              // button
                              // RoundButton(
                              //   title: 'เข้าสู่ระบบ',
                              //   press: () {
                              //     Get.toNamed('/expansion_panel');
                              //     expandController.setDefaultValues();
                              //   },
                              // ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                      horizontal: size.width * 0.118,
                                      vertical: size.height * 0.02,
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return hilightTextColor;
                                      else if (states
                                          .contains(MaterialState.disabled))
                                        return Colors.grey;
                                      return hilightTextColor;
                                    },
                                  ),
                                ),
                                onPressed: () => Get.back(),
                                child: Text(
                                  'ส่ง',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: fontRegular,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              // textBack
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'กลับไปหน้าล็อกอิน',
                                  style: TextStyle(
                                    fontFamily: fontRegular,
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Button
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  'assets/images/logo_horizontal.png',
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
