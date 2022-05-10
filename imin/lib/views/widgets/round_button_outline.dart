import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundButtonOutline extends StatelessWidget {
  const RoundButtonOutline({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        primary: hilightTextColor,
        side: BorderSide(
          width: 1,
          color: hilightTextColor,
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
          color: textColorContrast,
          fontSize: 18,
          fontFamily: fontRegular,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
