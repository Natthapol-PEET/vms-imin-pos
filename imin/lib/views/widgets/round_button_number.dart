import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';
class RoundButtonNumber extends StatelessWidget {
  const RoundButtonNumber({
    Key? key,
    required this.index,
    required this.selectd,
    required this.onClick,
    this.width = 30,
    this.height = 30,
    this.fontSize = 16,
  }) : super(key: key);

  final String index;
  final bool selectd;
  final Function()? onClick;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectd ? hilightTextColor : textColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            index,
            style: TextStyle(
              fontFamily: fontRobotoRegular,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: selectd ? hilightTextColor : textColor,
            ),
          ),
        ),
      ),
    );
  }
}