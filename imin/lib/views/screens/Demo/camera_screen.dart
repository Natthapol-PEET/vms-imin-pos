import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/upload_personal_service.dart';
import 'package:imin/views/widgets/not_connect_internet.dart';

class TakePictureScreen extends StatelessWidget {
  TakePictureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<TakePictureController>(
      builder: (c) => Scaffold(
        body: FutureBuilder<void>(
          future: c.initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    child: CameraPreview(c.controller),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/crop-personal.png',
                        fit: BoxFit.fitWidth,
                        width: size.width * 0.7,
                      ),
                      SizedBox(height: size.height * 0.025),
                      Text(
                        '*กรุณาถ่ายรูปบัตรประชาชน',
                        style: TextStyle(
                          fontFamily: fontRegular,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      MaterialButton(
                        color: purpleBlueColor,
                        padding: EdgeInsets.all(20),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () async => c.takePicture(),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
