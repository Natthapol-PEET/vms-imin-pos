import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class TitleContent extends StatelessWidget {
  const TitleContent({
    Key? key,
    required this.text,
    this.fontSize = 28,
  }) : super(key: key);

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Flexible(
      flex: 1,
      child: Padding(
        padding:
            EdgeInsets.only(top: size.height * 0.03, left: size.width * 0.03),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontFamily: fontRegular,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
