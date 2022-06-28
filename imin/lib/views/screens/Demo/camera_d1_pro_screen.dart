import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';



class TakePictureScreenD1Pro extends StatelessWidget {
  const TakePictureScreenD1Pro({
    Key? key,
    required this.size,
    required this.uploadController,
    required this.cameraController,
  }) : super(key: key);

  final Size size;
  final UploadPersonalController uploadController;
  final TakePictureController cameraController;

  @override
  Widget build(BuildContext context) {
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
