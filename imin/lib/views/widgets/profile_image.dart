import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

// ignore: camel_case_types
class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(right: size.width * 0.1),
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
    );
  }
}
