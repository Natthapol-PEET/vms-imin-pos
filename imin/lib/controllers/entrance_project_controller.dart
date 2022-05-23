import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/blacklist_model.dart';
import 'package:imin/models/entrance_list_all_model.dart';
import 'package:imin/models/login_model.dart';
import 'package:imin/models/visitor_model.dart';
import 'package:imin/models/whitelist_model.dart';
import 'package:imin/services/get_enteance_project_blacklist_service.dart';
import 'package:imin/services/get_enteance_project_service.dart';
import 'package:imin/services/get_enteance_project_visitor_service.dart';
import 'package:imin/services/get_enteance_project_whitelist_service.dart';

class EntranceProjectController extends GetxController {
  var dataEntrance = [].obs;
  var visitorList = <VisitorModel>[].obs;
  var whitelistList = <WhitelistModel>[].obs;
  var blacklistList = <BlacklistModel>[].obs;
  var dataRow = <DataRow>[];

  var logg = Get.put(LoginController());

  String token = "";

  @override
  void onInit() {
    token = logg.dataProfile.token;

    super.onInit();
  }

//allList
  getDataEntrance() async {
    try {
      EasyLoading.show(status: 'โหลดข้อมูล ...');
      dataEntrance.value = await getEntranceProjectApi(token);
      // List<dynamic> values = <dynamic>[];
      // values = dataEntrance;
      // Map<String, dynamic> map = dataEntrance[0];
      // print('/${dataEntrance[0]['license_plate']}/');
      dataRow.clear();
      dataEntrance.forEach((item) => dataRow.add(createDataRowAllList(item)));
      update(['update-enteance-data-row']);
      EasyLoading.dismiss();
    } catch (e) {
      print('error:${e}');
    }
  }

//3 List
  getEntranceData() async {
    EasyLoading.show(status: 'โหลดข้อมูล ...');

    // var jSon = await getEntranceProjectApi(token);
    var jSonVisitor = await getEntranceProjectVisitorApi(token);
    var jSonWhitelist = await getEntranceProjectWhitelistApi(token);
    var jSonBlacklist = await getEntranceProjectBlacklistApi(token);
    visitorList.clear();
    whitelistList.clear();
    blacklistList.clear();
    // print('json: ${jSon}');
    jSonVisitor.forEach((item) => visitorList.add(VisitorModel.fromJson(item)));
    jSonWhitelist
        .forEach((item) => whitelistList.add(WhitelistModel.fromJson(item)));
    jSonBlacklist
        .forEach((item) => blacklistList.add(BlacklistModel.fromJson(item)));

    createRows(visitorList, whitelistList, blacklistList);
  }

  void createRows(
      List visitorListData, List whitelistListData, List blackListData) {
    dataRow.clear();

    whitelistListData.forEach((item) => dataRow.add(createDataRow(item)));
    visitorListData.forEach((item) => dataRow.add(createDataRow(item)));
    blackListData.forEach((item) => dataRow.add(createDataRow(item)));

    update(['update-enteance-data-row']);
    EasyLoading.dismiss();
  }

  DataRow createDataRow(item) {
    return DataRow(
      onSelectChanged: (state) => print('พห 5417'),
      cells: [
        DataCell(Center(
          child: Text(item.idCard != null && item.idCard != ""
              ? '${item.idCard}'
              : '-'),
        )),
        DataCell(Center(
            child: Text(item.licensePlate == '' || item.licensePlate == null
                ? '-'
                : item.licensePlate))),
        DataCell(Container(
            width: 120,
            child: Text(item.firstname == null
                ? "-"
                : "${item.firstname} ${item.lastname}"))),
        DataCell(Center(child: Text(item.homeNumber))),
        DataCell(Container(
            width: 150,
            child: Text(item.listStatus == 'visitor'
                ? 'นัดหมายเข้าโครงการ'
                : item.listStatus == 'whitelist'
                    ? 'รับเชิญพิเศษ'
                    : 'ไม่มีสิทธิ์เข้าโครงการ'))),
        DataCell(Center(
          child: Text((item.listStatus == 'visitor')
              ? item.inviteDate
              : (item.listStatus == 'whitelist')
                  ? '-'
                  : '-'),
        )),
        DataCell(
          Text((item.listStatus == 'visitor')
              ? (item.datetimeIn != null)
                  ? (item.datetimeOut != null)
                      ? 'ออกจากโครงการ'
                      : 'อยู่ในโครงการ'
                  : 'รอดำเนินการ'
              : (item.listStatus == 'whitelist')
                  ? (item.datetimeIn != null)
                      ? (item.datetimeOut != null)
                          ? 'รอดำเนินการ'
                          : 'อยู่ในโครงการ'
                      : 'รอดำเนินการ'
                  : '-'),
        ),
      ],
    );
  }

// all List
  DataRow createDataRowAllList(item) {
    return DataRow(
      onSelectChanged: (state) => print('พห 5418'),
      cells: [
        DataCell(Text(item['id_card'] != null && item['id_card'] != ""
            ? '${item['id_card']}'
            : '-')),
        DataCell(
            // Text('${item['license_plate'] ?? "-"}')),
            Text(item['license_plate'] != null
                ? '${item['license_plate']}'
                : '-')),
        DataCell(Text('${item['firstname'] ?? "-"} ${item['lastname'] ?? ""}')),
        DataCell(Text('${item['home_number'] ?? "-"}')),
        DataCell(Text(item['visitor_id'] != null
            ? 'นัดหมายเข้าโครงการ'
            : item['whitelist_id'] != null
                ? 'รับเชิญพิเศษ'
                : 'ไม่มีสิทธิ์เข้าโครงการ')),
        DataCell(Text((item['visitor_id'] != null)
            ? item['invite_date']
            : (item['whitelist_id'] != null)
                ? '-'
                : '-')),
        DataCell(Text((item['visitor_id'] != null)
            ? (item['datetime_in'] != null)
                ? (item['datetime_out'] != null)
                    ? 'ออกจากโครงการ'
                    : 'อยู่ในโครงการ'
                : 'รอดำเนินการ'
            : (item['whitelist_id'] != null)
                ? (item['datetime_in'] != null)
                    ? (item['datetime_out'] != null)
                        ? 'รอดำเนินการ'
                        : 'อยู่ในโครงการ'
                    : 'รอดำเนินการ'
                : '-')),
      ],
    );
  }

//
  List<DataColumn> createColumns() {
    List headerItems = [
      'เลขประจำตัวประชาชน',
      'เลขทะเบียนรถ',
      'ชื่อ - นามสกุล',
      'บ้านเลขที่',
      'ระดับ',
      'วันที่นัดหมาย',
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
              textAlign: TextAlign.center,
            )))
        .toList();
  }
}
