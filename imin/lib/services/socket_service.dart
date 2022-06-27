import 'dart:async';
import 'package:get/get.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/controllers/socket_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService extends GetxController {
  final socketController = Get.put(SocketController());
  final exitController = Get.put(ExitProjectController());
  final entranceController = Get.put(EntranceProjectController());

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
        if (msg == "COMING_WALK_IN" || msg == "REGISTER_WALKIN") {
          entranceController.getEntranceData();
        }

        // เวลาออกโครงการ screen
        if (msg == "COMING_WALK_IN" ||
            msg == "ADMIN_STAMP" ||
            msg == "ADMIN_OPERATION" ||
            msg == "CHECKOUT") {
          exitController.getExitData();
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
