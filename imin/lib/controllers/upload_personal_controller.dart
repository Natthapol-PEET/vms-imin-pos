import 'package:get/get.dart';
import 'package:imin/services/register_walkin_service.dart';

class UploadPersonalController extends GetxController {
  var checkHomeNumber = true.obs;
  var checkLicensePlate = true.obs;

  var homeNumber = "".obs;
  var licensePlate = "".obs;

  initValue() {
    checkHomeNumber.value = true;
    checkLicensePlate.value = true;

    homeNumber.value = "";
    licensePlate.value = "";
  }

  checkInput(String fname, String lname, String idCard, String code) {
    // check home number is null
    if (homeNumber.value == "") {
      checkHomeNumber(false);
    } else {
      checkHomeNumber(true);
    }

    // check license plate is null
    if (licensePlate.value == "") {
      checkLicensePlate(false);
    } else {
      checkLicensePlate(true);
    }

    // call api
    if (checkHomeNumber.value && checkLicensePlate.value) {
      print("fname: $fname");
      print("lname: $lname");
      print("idCard: $idCard");
      print("checkHomeNumber: $checkHomeNumber");
      print("checkLicensePlate: $checkLicensePlate");

      return registerWalkinApi(
          fname, lname, idCard, homeNumber.value, code, licensePlate.value);
    }
  }
}
