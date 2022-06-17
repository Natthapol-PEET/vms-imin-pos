import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/register_walkin_service.dart';

class UploadPersonalController extends GetxController {
  final loginController = Get.put(LoginController());

  var checkHomeNumber = true.obs;
  var checkIdCard = true.obs;

  var homeNumber = "".obs;
  var idCard = "".obs;
  var licensePlate = "".obs;

  var screenOne = true.obs;

  var selectedValue = "บัตรประจำตัวประชาชน".obs;
  List<DropdownMenuItem<String>> items = [
    'บัตรประจำตัวประชาชน',
    'ใบอนุญาตขับขี่',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: fontRegular,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }).toList();

  initValue() {
    checkHomeNumber.value = true;
    checkIdCard.value = true;

    homeNumber.value = "";
    idCard.value = "";
    licensePlate.value = "";

    screenOne.value = true;

    selectedValue.value = "บัตรประจำตัวประชาชน";
    List<DropdownMenuItem<String>> items = [
      'บัตรประจำตัวประชาชน',
      'ใบอนุญาตขับขี่',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: fontRegular,
            // fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }

  Future checkInput(String code, int guardId) async {
    // check home number is null
    if (homeNumber.value == "") {
      checkHomeNumber(false);
    } else {
      checkHomeNumber(true);
    }
    // if (idCard.value == "" || idCard.value.length != 13) {
    //   checkIdCard(false);
    // } else {
    //   checkIdCard(true);
    // }

    print("checkHomeNumber.value: ${checkHomeNumber.value}");
    print("checkIdCard.value: ${checkIdCard.value}");

    // call api
    if (checkHomeNumber.value && checkIdCard.value) {
      print("code: $code");
      print("homeNumber: $homeNumber");
      print("idCard: $idCard");
      print("licensePlate: $licensePlate");

      return await registerWalkinApi(code, idCard.value, homeNumber.value,
          licensePlate.value, guardId, loginController.dataProfile.token);
    }

    return 401;
  }
}
