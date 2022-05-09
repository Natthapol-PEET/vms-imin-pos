/*
  DateTime now = DateTime.now()
  String m = now.month;
*/
String month_eng_to_thai(int m) {
  Map<int, String> month = {
    1: "มกราคม",
    2: "กุมภาพันธ์",
    3: "มีนาคม",
    4: "เมษายน",
    5: "พฤษภาคม",
    6: "มิถุนายน",
    7: "กรกฎาคม",
    8: "สิงหาคม",
    9: "กันยายน",
    10: "ตุลาคม",
    11: "พฤศจิกายน",
    12: "ธันวาคม",
  };

  return month[m] as String;
}

/*
  DateTime now = DateTime.now()
  String m = DateFormat('EEE').format(now);
*/
String day_eng_to_thai(int d) {
  Map<int, String> day = {
    1: "จันทร์",
    2: "อังคาร",
    3: "พุธ",
    4: "พฤหัสบดี",
    5: "ศุกร์",
    6: "เสาร์",
    7: "อาทิตย์",
  };

  return day[d] as String;
}

/*
  DateTime now = DateTime.now()
  String m = now.year;
*/
String christian_buddhist_year(int y) {
  return (y + 543).toString();
}
