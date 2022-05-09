import 'package:get/get.dart';
import 'package:imin/Functions/time_to_thai.dart';

class ExitProjectController extends GetxController {
  var startEndRange = "".obs;
  var rememStartEndRange = "";

  @override
  void onInit() {
    DateTime v = DateTime.now();

    startEndRange.value = dummyDatetime(v) + " - " + dummyDatetime(v);

    super.onInit();
  }

  void cleanAndCreateDummy(DateTime start, DateTime? end) {
    if (end == null) {
      rememStartEndRange = dummyDatetime(start) + " - " + dummyDatetime(start);
    } else {
      if (start.day > end.day) {
        rememStartEndRange = dummyDatetime(end) + " - " + dummyDatetime(start);
      } else {
        rememStartEndRange = dummyDatetime(start) + " - " + dummyDatetime(end);
      }
    }
  }

  void submitSelectRangeTime() {
    startEndRange.value = rememStartEndRange;
    Get.back();
  }

  String dummyDatetime(DateTime v) {
    return "${v.day} ${month_eng_to_thai(v.month)} ${christian_buddhist_year(v.year)}";
  }
}
