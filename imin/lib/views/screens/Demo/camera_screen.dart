import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/upload_personal_service.dart';

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
                      Container(
                        width: size.width * 0.6,
                        height: size.height * 0.6,
                        color: Colors.white,
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
                        onPressed: () async {
                          try {
                            // EasyLoading.show(status: 'loading...');
                            await c.initializeControllerFuture;
                            final image = await c.controller.takePicture();
                            c.imagePath.value = image.path;

                            var response = await uploadPersonal(image.path);
                            response.stream
                                .transform(utf8.decoder)
                                .listen((value) {
                              Map<String, dynamic> json = jsonDecode(value);
                              print(json);
                              print(json.runtimeType);
                              print(json['firstname']);
                              c.response.value = json;
                            });

                            // Timer(Duration(seconds: 1), () {
                            //   EasyLoading.dismiss();
                            //   Get.back();
                            // });

                            Get.back();
                          } catch (e) {
                            print(e);
                          }
                        },
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
