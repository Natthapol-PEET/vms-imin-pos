import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

// ignore: must_be_immutable
class RoundTextFormField extends StatelessWidget {
  RoundTextFormField({
    Key? key,
    required this.icon,
    required this.textTitle,
    this.isVisibility,
    this.onClickVisibility,
    this.textController,
    this.invalid = true,
    this.onChange,
    this.initialValue,
    this.editIcon = false,
    this.fontSize = 16,
  }) : super(key: key);

  final IconData icon;
  final String textTitle;
  final bool? isVisibility;
  final VoidCallback? onClickVisibility;
  var textController;
  final bool invalid;
  final Function(String)? onChange;
  String? initialValue;
  final bool editIcon;
  final double fontSize;

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
              fontSize: fontSize,
              fontFamily: fontRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            // height: size.height * fontSize * 0.0047,
            margin: EdgeInsets.only(top: size.height * 0.008),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              initialValue: initialValue,
              // controller: initialValue != ""
              //     ? (TextEditingController()..text = initialValue as String)
              //     : null,
              // controller: textController,
              onChanged: onChange,
              obscureText: textTitle != "รหัสผ่าน"
                  ? false
                  : isVisibility == true
                      ? false
                      : true,
              style: TextStyle(
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: invalid ? Colors.transparent : Colors.red,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: invalid ? Colors.transparent : Colors.red,
                    width: 1.5,
                  ),
                ),
                hintText: textTitle,
                // prefixIconConstraints:
                //     BoxConstraints(minWidth: 23, maxHeight: 20),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.008),
                  child: Icon(
                    icon,
                    color: Colors.black,
                    size: (editIcon)
                        ? size.width * fontSize * 0.0045
                        : size.width * 0.02,
                  ),
                ),
                suffixIcon: textTitle == "รหัสผ่าน"
                    ? InkWell(
                        onTap: onClickVisibility,
                        child: Icon(
                          isVisibility == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color:
                              isVisibility == true ? Colors.black : Colors.grey,
                        ),
                      )
                    : null,
              ),
              // validator: (v) {
              //   // if (v == null || v.isEmpty) {
              //   //   return 'Please enter some text';
              //   // }
              //   // return null;
              //   print(v);
              // },
            ),
          ),
        ],
      ),
    );
  }
}
