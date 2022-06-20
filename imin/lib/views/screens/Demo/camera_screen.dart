import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';

class TakePictureScreen extends StatelessWidget {
  TakePictureScreen({Key? key}) : super(key: key);

  final uploadController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<TakePictureController>(
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
                          onPressed: () async {
                            c.takePicture(uploadController.selectedValue.value);
                            cameraController.stopCamera();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
