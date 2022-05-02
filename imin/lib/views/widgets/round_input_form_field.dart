import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

// ignore: must_be_immutable
class RoundInputFormField extends StatelessWidget {
  RoundInputFormField({
    Key? key,
    this.readOnly = false,
    required this.textControl,
    this.hintText = "",
  }) : super(key: key);

  final bool readOnly;
  TextEditingController textControl = TextEditingController();
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: size.width * 0.25,
      child: TextFormField(
        initialValue: textControl.text,
        readOnly: readOnly,
        cursorColor: Colors.black,
        style: TextStyle(
          fontFamily: fontRegular,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: readOnly ? grey3Color : Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            left: 15,
            bottom: 11,
            top: 11,
            right: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: grey3Color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: grey3Color),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter some text';
        //   }
        //   return null;
        // },
      ),
    );
  }
}
