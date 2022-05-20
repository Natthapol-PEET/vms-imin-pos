import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/upload_personal_service.dart';
import 'package:imin/views/widgets/not_connect_internet.dart';

class TakePictureScreen extends StatelessWidget {
  TakePictureScreen({Key? key}) : super(key: key);

  final uploadController = Get.put(UploadPersonalController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<TakePictureController>(
      builder: (c) => Scaffold(
        body: FutureBuilder<void>(
          future: c.initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                children: [
                  Container(
                    width: size.width * 0.9,
                    height: size.height,
                    child: CameraPreview(c.controller),
                  ),
                  Container(
                    height: size.height,
                    width: size.width * 0.1,
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: MaterialButton(
                        color: purpleBlueColor,
                        // padding: EdgeInsets.all(20),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () async =>
                            c.takePicture(uploadController.selectedValue.value),
                      ),
                    ),
                  ),
                ],
              );
              // return Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Container(
              //       width: size.width,
              //       height: size.height,
              //       child: CameraPreview(c.controller),
              //     ),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         // Image.asset(
              //         //   'assets/images/crop-personal.png',
              //         //   fit: BoxFit.fitWidth,
              //         //   width: size.width * 0.7,
              //         // ),
              //         // SizedBox(height: size.height * 0.025),
              //         // SizedBox(height: size.height * 0.5),
              //         // Text(
              //         //   '*กรุณาถ่ายรูปบัตรประชาชน',
              //         //   style: TextStyle(
              //         //     fontFamily: fontRegular,
              //         //     color: Colors.white,
              //         //     fontSize: 18,
              //         //   ),
              //         // ),
              //         // SizedBox(height: size.height * 0.025),

              //       ],
              //     ),
              //   ],
              // );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
