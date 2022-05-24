import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';

EasyDialog showDialogOpenGate(dynamic item) {
  return EasyDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    width: 420,
    height: 250,
    closeButton: false,
    contentListAlignment: CrossAxisAlignment.center,
    contentList: [
      Center(
        child: Image.asset('assets/images/open-gate.png'),
      ),
      SizedBox(height: 10),
      Center(
        child: Text(
          'ประตูโครงการเปิด',
          style: TextStyle(
            fontFamily: fontRegular,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
