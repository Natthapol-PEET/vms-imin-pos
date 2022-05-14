import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundButtonOutline extends StatelessWidget {
  const RoundButtonOutline({
    Key? key,
    required this.title,
    required this.press,
    this.width = 150,
    this.height = 40,
  }) : super(key: key);

  final String title;
  final VoidCallback? press;
  final double width;
  final double height;

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
            fontSize: 18,
            fontFamily: fontRegular,
          ),
        ),
      ),
    );

    return ElevatedButton(
      // style: ButtonStyle(
      //   padding: MaterialStateProperty.all<EdgeInsets>(
      //     EdgeInsets.symmetric(
      //       horizontal: size.width * 0.05,
      //       vertical: size.height * 0.012,
      //     ),
      //   ),
      //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
      //     (Set<MaterialState> states) {
      //       if (states.contains(MaterialState.pressed))
      //         return Colors.white;
      //       else if (states.contains(MaterialState.disabled))
      //         return Colors.grey;
      //       return Colors.white;
      //     },
      //   ),
      // ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(
          width: 1,
          color: purpleBlueColor,
        ),
      ),
      // onPressed: () {
      //   if (_formKey.currentState!.validate()) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text(
      //         'เข้าสู่ระบบ',
      //         style: TextStyle(
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   );
      //   }
      // },
      onPressed: press,
      child: Text(
        title,
        style: TextStyle(
          color: purpleBlueColor,
          fontSize: 18,
          fontFamily: fontRegular,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
