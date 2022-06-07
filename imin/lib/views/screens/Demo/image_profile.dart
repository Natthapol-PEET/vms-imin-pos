import 'package:flutter/material.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/helpers/configs.dart';
import 'package:get/get.dart';

class ImageProfile extends StatefulWidget {
  const ImageProfile({Key? key}) : super(key: key);

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage('assets/images/people-icon.png'),
      image: NetworkImage(
        ipServer + '/guard/profile_image/guard_profile.jpg',
        headers: <String, String>{
          'Authorization': 'Bearer ${loginController.dataProfile.token}'
        },
      ),
    );

    // return Image.network(
    //   ipServer + '/guard/profile_image/guard_profile.jpg',
    // );
  }
}
