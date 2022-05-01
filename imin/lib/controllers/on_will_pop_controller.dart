import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/constance.dart';

class OnWillPopController extends GetxController {
  var context;

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'แจ้งเตือน',
              style: TextStyle(
                fontFamily: fontRegular,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text('คุณต้องการออกจากแอปใช่หรือไม่ ?'),
            actions: [
              TextButton(
                // onPressed: () => Navigator.of(context).pop(true),
                onPressed: () => exit(0),
                child: Text(
                  'ใช่',
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'ไม่ใช่',
                  style: TextStyle(
                    fontFamily: fontRegular,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }
}
