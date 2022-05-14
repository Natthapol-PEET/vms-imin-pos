import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundButtonOutline extends StatelessWidget {
  const RoundButtonOutline({
    Key? key,
    required this.title,
    required this.press,
    this.checkValidate,
  }) : super(key: key);

  final String title;
  final VoidCallback? press;
  final bool? checkValidate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: (checkValidate == false) ? Colors.grey : hilightTextColor,
        // side: BorderSide(
        //   width: 1,
        //   color: hilightTextColor,
        // ),
      ),
      onPressed: (checkValidate == false) ? null : press,
      child: Text(
        title,
        style: TextStyle(
          color: textColorContrast,
          fontSize: 18,
          fontFamily: fontRegular,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
