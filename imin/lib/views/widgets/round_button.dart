import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.title,
    required this.press,
    this.horizontal = 64.0,
    this.vertical = 9.6,
    this.width = 150,
    this.height = 40,
    this.fontSize = 16,
  }) : super(key: key);

  final String title;
  final VoidCallback? press;
  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            // horizontal: size.width * 0.05,
            // vertical: size.height * 0.012,
            horizontal: horizontal,
            vertical: vertical,
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
      onPressed: press,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontFamily: fontRegular,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
