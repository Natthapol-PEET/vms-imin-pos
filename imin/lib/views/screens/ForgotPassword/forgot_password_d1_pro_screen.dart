import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/forgot_password_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/helpers/constance.dart';

class ForgotPasswordD1Pro extends StatelessWidget {
  ForgotPasswordD1Pro({Key? key}) : super(key: key);
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
                                'ระบบจะส่งลิงก์รีเซ็ตรหัสผ่านให้ทางอีเมลของคุณ',
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
                              // Obx(() => Row(
                              //       children: [
                              //         if (controller.checkEmail.value ==
                              //             true) ...[
                              //           EasyDialog(
                              //             closeButton: false,
                              //             height: 200,
                              //             width: 590,
                              //             contentList: [
                              //               // title
                              //               Text(
                              //                 "ลืมรหัสผ่าน",
                              //                 style: TextStyle(
                              //                   fontFamily: fontRegular,
                              //                   fontSize: 24,
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //               Divider(
                              //                 color: dividerColor,
                              //                 thickness: 1,
                              //               ),
                              //               SizedBox(height: 20),
                              //               Text(
                              //                 "ระบบได้ส่งข้อความไปที่อีเมล ${controller.emailValue.value} ",
                              //                 style: TextStyle(
                              //                   fontFamily: fontRegular,
                              //                   fontSize: 20,
                              //                 ),
                              //               ),

                              //               SizedBox(height: 20),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   RoundButton(
                              //                     title: "ตกลง",
                              //                     press: () => {
                              //                       controller.clear(),
                              //                       Get.toNamed('/login')
                              //                     },
                              //                   ),
                              //                   SizedBox(width: 20),
                              //                   // RoundButtonOutline(
                              //                   //   title: "ยกเลิก",
                              //                   //   press: () => Get.back(),
                              //                   // ),
                              //                 ],
                              //               ),
                              //             ],
                              //           ).show(context)
                              //         ]
                              //       ],
                              //     )),
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

  Row sendRequestForgot(Size size, BuildContext context) {
    return Row(
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
                horizontal: size.width * 0.118,
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
          onPressed: () => {
            controller.requestEmail(context)
           
          },
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
      ],
    );
  }
}
