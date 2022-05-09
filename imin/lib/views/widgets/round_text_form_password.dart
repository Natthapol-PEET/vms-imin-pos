import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

class RoundTextFormPassword extends StatelessWidget {
  RoundTextFormPassword({
    Key? key,
    required this.icon,
    required this.textTitle,
    this.isVisibility,
    this.onClickVisibility,
    required this.onChange,
  }) : super(key: key);

  final IconData icon;
  final String textTitle;
  final bool? isVisibility;
  final VoidCallback? onClickVisibility;
  final onChange;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textTitle,
            style: TextStyle(
              color: Colors.black,
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
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
            child: TextFormField(
              obscureText: isVisibility == true ? false : true,
              decoration: InputDecoration(
                  hintText: textTitle,
                  contentPadding: EdgeInsets.only(left: 10, top: 10),

                  // prefixIcon: Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: size.width * 0.008),
                  //   child: Icon(icon, color: Colors.black),
                  // ),
                  suffixIcon: InkWell(
                    onTap: onClickVisibility,
                    child: Icon(
                      isVisibility == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isVisibility == true ? Colors.black : Colors.grey,
                    ),
                  )),
              validator: (v) {
                // if (v == null || v.isEmpty) {
                //   return 'Please enter some text';
                // }
                // return null;
              },
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
