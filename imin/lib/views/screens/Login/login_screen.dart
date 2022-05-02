import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/on_will_pop_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/bg_image.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
          child: Row(
            children: [
              BgImage(),
              Container(
                width: size.width / 2,
                height: size.height,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                color: themeBgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset("assets/images/Artani-Logo.png", scale: 2),

                    // E-mail
                    // Password
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.05),
                      child: Form(
                        // key: _formKey,
                        child: Column(
                          children: [
                            RoundTextFormField(
                              icon: Icons.person,
                              textTitle: "อีเมลผู้ใช้",
                            ),
                            Obx(
                              () => RoundTextFormField(
                                icon: Icons.lock,
                                textTitle: "รหัสผ่าน",
                                isVisibility: controller.isVisibility.value,
                                onClickVisibility: () => controller.isVisibility
                                    .value = !controller.isVisibility.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // remember & forget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  value: controller.isRememberAccount.value,
                                  activeColor: goldColor,
                                  onChanged: (bool? v) {
                                    if (v == true) {
                                      controller.isRememberAccount.value = true;
                                    } else {
                                      controller.isRememberAccount.value =
                                          false;
                                    }
                                  }),
                            ),
                            Text(
                              "จดจำบัญชีของฉัน",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: fontRegular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "ลืมรหัสผ่าน?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: fontRegular,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Button
                    SizedBox(height: size.height * 0.008),
                    RoundButton(
                      title: 'เข้าสู่ระบบ',
                      press: () {
                        Get.toNamed('/expansion_panel');
                        expandController.setDefaultValues();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
