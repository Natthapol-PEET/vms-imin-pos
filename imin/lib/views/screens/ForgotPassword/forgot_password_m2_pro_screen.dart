import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/forgot_password_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/helpers/constance.dart';

class ForgotPasswordM2Pro extends StatelessWidget {
  ForgotPasswordM2Pro({Key? key}) : super(key: key);
  final controller = Get.put(ForgotPasswordController());
  final onWillPopController = Get.put(OnWillPopController());
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
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
                  // color: themeBgColor,
                  // color: themeBgColor.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 1,
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
                                  fontSize: titleM2FontSize,
                                  fontFamily: fontRegular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.018),
                              Text(
                                'กรุณากรอกอีเมลที่ลงทะเบียนไว้',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: normalM2FontSize + 2,
                                  fontFamily: fontRegular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'ระบบจะส่งลิงค์รีเซ็ทรหัสผ่านให้ทางอีเมลของคุณ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: normalM2FontSize + 2,
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
                                  style:
                                      TextStyle(fontSize: normalM2FontSize + 2),
                                  onChanged: (value) =>
                                      controller.emailValue.value = value,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'กรอกอีเมล',
                                    contentPadding: EdgeInsets.only(left: 20),
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height * 0.017),

                              //send button
                              sendRequestForgot(size, context),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  'กลับไปหน้าล็อกอิน',
                                  style: TextStyle(
                                    fontFamily: fontRegular,
                                    fontSize: normalM2FontSize + 2,
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
                  scale: 1.7,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Row sendRequestForgot(Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                horizontal: size.width * 0.406,
                vertical: size.height * 0.02,
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return hilightTextColor;
                else if (states.contains(MaterialState.disabled))
                  return Colors.grey;
                return hilightTextColor;
              },
            ),
          ),
          onPressed: () => {controller.requestEmail(context)},
          child: Text(
            'ส่ง',
            style: TextStyle(
              color: Colors.white,
              fontSize: normalM2FontSize + 2,
              fontFamily: fontRegular,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
