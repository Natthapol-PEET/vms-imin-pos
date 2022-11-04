import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundButtonOutline extends StatelessWidget {
  const RoundButtonOutline({
    Key? key,
    required this.title,
    required this.press,
    this.width = 150,
    this.height = 40,
    this.fontSize = 16,
  }) : super(key: key);

  final String title;
  final VoidCallback? press;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ButtonTheme(
      minWidth: width,
      height: height,
      child: OutlineButton(
        // color: purpleBlueColor,
        borderSide: BorderSide(color: purpleBlueColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: press,
        child: Text(
          title,
          style: TextStyle(
            color: purpleBlueColor,
            fontSize: fontSize,
            fontFamily: fontRegular,
          ),
        ),
      ),
    );
  }
}
