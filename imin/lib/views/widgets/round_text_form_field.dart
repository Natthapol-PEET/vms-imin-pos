import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundTextFormField extends StatelessWidget {
  RoundTextFormField({
    Key? key,
    required this.icon,
    required this.textTitle,
    this.isVisibility,
    this.onClickVisibility,
  }) : super(key: key);

  final IconData icon;
  final String textTitle;
  final bool? isVisibility;
  final VoidCallback? onClickVisibility;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: fontRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.008),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              obscureText: isVisibility == true ? false : true,
              decoration: InputDecoration(
                hintText: textTitle,
                // prefixIconConstraints:
                //     BoxConstraints(minWidth: 23, maxHeight: 20),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.008),
                  child: Icon(icon, color: Colors.black),
                ),
                suffixIcon: textTitle == "รหัสผ่าน"
                    ? InkWell(
                        onTap: onClickVisibility,
                        child: Icon(
                          isVisibility == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color:
                              isVisibility == true ? Colors.black : Colors.grey,
                        ),
                      )
                    : null,
              ),
              validator: (v) {
                // if (v == null || v.isEmpty) {
                //   return 'Please enter some text';
                // }
                // return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
