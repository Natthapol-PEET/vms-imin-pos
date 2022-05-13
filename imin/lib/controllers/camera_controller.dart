import 'package:camera/camera.dart';
import 'package:get/get.dart';

class TakePictureController extends GetxController {
  late CameraDescription camera;
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  var imagePath = "".obs;
  var response = Map<String, dynamic>().obs;

  @override
  void onInit() {
    response.value = {
      "firstname": "",
      "lastname": "",
      "idCard": "",
    };

    super.onInit();
  }

  Future initCamera() async {
    final cameras = await availableCameras();
    camera = cameras.first;

    controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    initializeControllerFuture = controller.initialize();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
