import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/round_button_outline.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.05, left: size.width * 0.03),
            child: Text(
              'ข้อมูลส่วนตัว',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontNunitoSans,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
          ),
        ),

        // content
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.height * 0.25,
                decoration: BoxDecoration(
                  color: iconGoldColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/images/people-icon.png',
                  scale: 1.8,
                ),
              ),
              SizedBox(width: size.width * 0.1),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          subTitleText('อีเมล'),
                          subTitleText('ชื่อ-นามสกุล'),
                          subTitleText('ระดับ'),
                        ],
                      ),
                      SizedBox(width: size.width * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          subDetailText('Suchin12@gmail.com'),
                          subDetailText('สุจิน สว่างเนตร'),
                          subDetailText('รปภ.'),
                        ],
                      ),
                    ],
                  ),
                  // RoundButton
                  RoundButtonOutline(
                    title: 'แก้ไขข้อมูลส่วนตัว',
                    press: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding subTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
}
