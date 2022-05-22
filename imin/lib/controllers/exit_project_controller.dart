import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/Functions/time_to_thai.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/visitor_model.dart';
import 'package:imin/models/whitelist_model.dart';
import 'package:imin/services/exit_service.dart';

class ExitProjectController extends GetxController {
  var startEndRange = "".obs;
  var rememStartEndRange = "";

  var visitorList = <VisitorModel>[].obs;
  var whitelistList = <WhitelistModel>[].obs;
  var dataRow = <DataRow>[];

  @override
  void onInit() {
    DateTime v = DateTime.now();
    startEndRange.value = dummyDatetime(v) + " - " + dummyDatetime(v);

    // getExitData();

    super.onInit();
  }

  getExitData() async {
    EasyLoading.show(status: 'โหลดข้อมูล ...');

    var jSon = await getExitDataApi();
    visitorList.clear();
    whitelistList.clear();

    jSon['resultVisitor']
        .forEach((item) => visitorList.add(VisitorModel.fromJson(item)));
    jSon['resultWhitelist']
        .forEach((item) => whitelistList.add(WhitelistModel.fromJson(item)));

    // print(visitorList);
    // print(whitelistList);

    createRows(visitorList, whitelistList);
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
    // 18 พฤษภาคม 2565
    return "${v.day} ${month_eng_to_thai(v.month)} ${christian_buddhist_year(v.year)}";
  }

  String formatDateTime(String dateStr) {
    // 01/06/64 08:20
    DateTime dt = DateTime.parse(dateStr.replaceAll('T', ' '));

    return "${dt.day}/${dt.month}/${dt.year + 543} ${dt.hour}:${dt.minute}";
  }

  void createRows(List visitorList, List whitelistList) {
    dataRow.clear();

    whitelistList.forEach((item) => dataRow.add(createDataRow(item)));
    visitorList.forEach((item) => dataRow.add(createDataRow(item)));

    update(['update-exit-data-row']);
    EasyLoading.dismiss();
    // return [
    // DataRow(
    //   onSelectChanged: (state) => print('พห 5417'),
    //   cells: [
    //     DataCell(Text('18009880000')),
    //     DataCell(Text('ยน 2310')),
    //     DataCell(Container(width: 100, child: Text('จิรายุ เนียลกุล'))),
    //     DataCell(Text('1/2')),
    //     DataCell(Text('01/06/64 08:20')),
    //     DataCell(Text('01/06/64 08:55')),
    //     DataCell(Text('ยังไม่ได้รับการแสตมป์')),
    //   ],
    // ),
    // ];
  }

  DataRow createDataRow(item) {
    return DataRow(
      onSelectChanged: (state) => print('พห 5417'),
      cells: [
        DataCell(Center(
            child: Text(
                item.idCard == '' || item.idCard == null ? '-' : item.idCard))),
        DataCell(Center(
            child: Text(item.licensePlate == '' || item.licensePlate == null
                ? '-'
                : item.licensePlate))),
        DataCell(Container(
            width: 100, child: Center(child: Text(item.firstname == null ? "-" : "${item.firstname} ${item.lastname}")))),
        DataCell(Center(child: Text(item.homeNumber))),
        DataCell(Center(
          child: Text(
              item.datetimeIn != null ? formatDateTime(item.datetimeIn) : '-'),
        )),
        DataCell(Center(
          child: Text(item.datetimeOut != null
              ? formatDateTime(item.datetimeOut)
              : '-'),
        )),
        DataCell(
          Text(
            item.residentStamp == null
                ? 'ยังไม่ได้รับการแสตมป์'
                : 'ได้รับการสแตมป์แล้ว',
          ),
        ),
      ],
    );
  }

  List<DataColumn> createColumns() {
    List headerItems = [
      'เลขประจำตัวประชาชน',
      'เลขทะเบียนรถ',
      'ชื่อ - นามสกุล',
      'บ้านเลขที่',
      'เวลาเข้า',
      'เวลาออก',
      'สถานะ',
    ];

    return headerItems
        .map((item) => DataColumn(
                label: Text(
              item,
              style: TextStyle(
                  fontFamily: fontRegular,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            )))
        .toList();
  }
}
