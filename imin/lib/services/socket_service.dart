import 'dart:async';
import 'package:get/get.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/entrance_project_controller_m2.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/controllers/exit_project_controller_m2.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/socket_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:path/path.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService extends GetxController {
  final socketController = Get.put(SocketController());
  final exitController = Get.put(ExitProjectController());
  final exitControllerM2 = Get.put(ExitProjectControllerM2());
  final entranceController = Get.put(EntranceProjectController());
  final entranceControllerM2 = Get.put(EntranceProjectControllerM2());
  final loginController = Get.put(LoginController());

  startSocketClient() {
    print("startSocketClient");

    // Dart client
    socketController.socket = io(
        socketUrl,
        OptionBuilder().setTransports(['websocket'])
            // .disableAutoConnect()
            .setExtraHeaders({'Authorization': socketAuth}).build());
    socketController.socket!.connect();

    socketController.socket!.onConnect((_) {
      print("Connected");

      // ให้รู้ว่า client เข้ามา connect แล้ว
      socketController.socket!.emit('will-message', 'toWeb');

      // รอข้อความจาก server
      socketController.socket!.on('toWeb', (msg) {
        print("socket message: $msg");

        // เวลาเข้าโครงการ screen
        if (msg == "COMING_WALK_IN" || msg == "REGISTER_WALKIN" 
        || msg == "CHECKOUT"||
            msg == "ADMIN_OPERATION") {
          entranceController.getEntranceData();
          entranceControllerM2.getEntranceData();
        }

        // เวลาออกโครงการ screen
        if (msg == "COMING_WALK_IN" ||
            msg == "ADMIN_STAMP" ||
            msg == "ADMIN_OPERATION" ||
            msg == "CHECKOUT") {
          exitController.getExitData();
          exitControllerM2.getExitData();
        }
      });
      socketController.socket!.on('toWeb/Disable', (msg) {
        print("socket message: $msg");
        final typeUser = msg.split('/')[0];
        final idUser = msg.split('/')[1];
        print("dataProfile ${loginController.dataProfile.guardId}");
        // เวลาเข้าโครงการ screen
        if (typeUser == "GUARD" && '$idUser' == '${loginController.dataProfile.guardId}') {
          // entranceController.getEntranceData();
          // entranceControllerM2.getEntranceData();
          print("typeUser: $typeUser");
          print("idUser: $idUser");
        }
      });
      socketController.socket!.on('toWeb/Delete', (msg) {
        print("socket messageDelete: $msg");
        final typeUser = msg.split('/')[0];
        final idUser = msg.split('/')[1];
        print("dataProfile ${loginController.dataProfile.guardId}");
        // เวลาเข้าโครงการ screen
        if (typeUser == "GUARD" && '$idUser' == '${loginController.dataProfile.guardId}') {
          // entranceController.getEntranceData();
          // entranceControllerM2.getEntranceData();
          print("typeUser: $typeUser");
          print("idUser: $idUser");
        }
      });
    });

    // เมื่อ server ล่มหรือ internet ล่ม หรืออะไรก็ตามแต่ ที่ทำให้หลุด connect
    socketController.socket!.onDisconnect((msg) {
      print('disconnect: $msg');
      socketController.socket!.clearListeners();
      restartSocketClient();
    });

    socketController.socket!
        .on('fromServer', (fromServer) => print("fromServer: $fromServer"));
  }

  stopSocketClient() {
    print("stopSocketClient");
    socketController.socket!.emit('will-message', 'toWeb');
    socketController.socket!.clearListeners();
    socketController.socket!.disconnect();
  }

  restartSocketClient() {
    stopSocketClient();
    Timer(Duration(seconds: 1), () {
      startSocketClient();
    });
  }
}
