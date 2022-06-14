import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/data/account.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/login_model.dart';
import 'package:imin/services/login_service.dart';
import 'package:imin/services/socket_service.dart';
import 'package:imin/views/widgets/not_connect_internet.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final loginController = Get.put(LoginController());
  final cameraController = Get.put(TakePictureController());

  Account acc = Account();

  @override
  void initState() {
    cameraController.initCamera();

    initAsync();

    super.initState();
  }

  initAsync() async {
    // Init Database
    // acc.dropTable();
    await acc.getDatabase();
    await acc.initAccount();
    // print(await acc.accounts());

    // login
    await loginController.getAccount();
    String path = '/login';

    if (loginController.isLogin.value == 1) {
      path = '/expansion_panel';

      loginController.dataProfile = await loginApi(
        loginController.username.value,
        loginController.password.value,
      );

      if (loginController.dataProfile is bool) {
        alertSystemOnConnectInternet().show(context);
        return;
      }

      if (!(loginController.dataProfile is LoginModel)) {
        path = '/login';
      } else {
        // init socket
        SocketService socketService = SocketService();
        socketService.startSocketClient();
      }
    }

    Timer(Duration(seconds: 2), () => Get.toNamed(path));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: themeBgColor,
          height: size.height,
          width: size.width,
          child: Image.asset(
            'assets/images/forgot_password.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          bottom: size.height * 0.3,
          child: Image.asset(
            'assets/images/Artani-Logo-Security.png',
            scale: 3,
          ),
        ),
        Positioned.fill(
          top: size.height * 0.3,
          child: SpinKitSpinningLines(
            color: Colors.white,
            // itemBuilder: (BuildContext context, int index) {
            //   return DecoratedBox(
            //     decoration: BoxDecoration(
            //       color: index.isEven ? Colors.white : Colors.white60,
            //     ),
            //   );
            // },
          ),
        ),
      ],
    );
  }
}
