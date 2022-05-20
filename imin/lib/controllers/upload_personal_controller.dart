import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/services/register_walkin_service.dart';

class UploadPersonalController extends GetxController {
  var checkHomeNumber = true.obs;
  var checkLicensePlate = true.obs;

  var homeNumber = "".obs;
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
    checkLicensePlate.value = true;

    homeNumber.value = "";
    licensePlate.value = "";

    selectedValue.value = "บัตรประจำตัวประชาชน";
    screenOne.value = true;
  }

  Future checkInput(String code, int guardId) async {
    // check home number is null
    if (homeNumber.value == "") {
      checkHomeNumber(false);
    } else {
      checkHomeNumber(true);
    }

    // check license plate is null
    // if (licensePlate.value == "") {
    //   checkLicensePlate(false);
    // } else {
    //   checkLicensePlate(true);
    // }

    print("code: $code");

    // call api
    if (checkHomeNumber.value) {
      print("checkHomeNumber: $checkHomeNumber");
      print("checkLicensePlate: $checkLicensePlate");

      return await registerWalkinApi(
        code,
        homeNumber.value,
        licensePlate.value,
        guardId,
      );
    }

    return 401;
  }
}
