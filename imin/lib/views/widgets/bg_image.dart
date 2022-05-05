import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class BgImage extends StatelessWidget {
  const BgImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width / 2,
      color: themeBgColor,
      child: Image.asset(
        "assets/images/BG-Login.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
