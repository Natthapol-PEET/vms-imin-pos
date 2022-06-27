import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';
class RoundButtonIcon extends StatelessWidget {
  const RoundButtonIcon({
    Key? key,
    required this.icon,
    required this.onClick,
    this.width = 30,
    this.height = 30,
    this.size = 18,
  }) : super(key: key);

  final IconData icon;
  final Function()? onClick;
  final double width;
  final double height;
  final double size;

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
            color: textColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: size,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}