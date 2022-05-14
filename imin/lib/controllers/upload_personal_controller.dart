import 'package:get/get.dart';

class UploadPersonalController extends GetxController {
  var checkHomeNumber = true.obs;
  var checkLicensePlate = true.obs;

  var homeNumber = "".obs;
  var licensePlate = "".obs;

  checkInput(String fname, String lname, String idCard) {
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
    }
  }
}
