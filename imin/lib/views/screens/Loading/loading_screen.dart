import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/helpers/constance.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    loginController.getAccount();
    Timer(Duration(seconds: 2), () => Get.toNamed('/login'));
    super.initState();
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
