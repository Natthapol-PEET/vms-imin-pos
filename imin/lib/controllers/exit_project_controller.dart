import 'dart:async';

import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/Functions/time_to_thai.dart';
import 'package:imin/controllers/mqtt_controller.dart';
import 'package:imin/functions/dialog_gate.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/visitor_model.dart';
import 'package:imin/models/whitelist_model.dart';
import 'package:imin/services/exit_service.dart';
import 'package:imin/services/gate_service.dart';
import 'package:imin/services/notification_service.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';

class ExitProjectController extends GetxController {
  var context;

  var startEndRange = "".obs;
  var rememStartEndRange = "";

  var visitorList = <VisitorModel>[].obs;
  var whitelistList = <WhitelistModel>[].obs;
  var dataRow = <DataRow>[];

  @override
  void onInit() {
    DateTime v = DateTime.now();
    startEndRange.value = dummyDatetime(v) + " - " + dummyDatetime(v);

    getExitData();

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
  }

  DataRow createDataRow(dynamic item) {
    print('item.firstname ${item.firstname}');

    return DataRow(
      onSelectChanged: (state) => item.firstname == null
          ? showDialogCard(item).show(context)
          : showDialogDetails(item).show(context),
      cells: [
        DataCell(Center(
            child: Text(
                item.idCard == '' || item.idCard == null ? '-' : item.idCard))),
        DataCell(Center(
            child: Text(item.licensePlate == '' || item.licensePlate == null
                ? '-'
                : item.licensePlate))),
        DataCell(Container(
            width: 100,
            child: Center(
                child: Text(item.firstname == null
                    ? "-"
                    : "${item.firstname} ${item.lastname}")))),
        DataCell(Center(child: Text(item.homeNumber ?? '-'))),
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
                : item.datetimeOut == null
                    ? 'ได้รับการสแตมป์แล้ว'
                    : 'ออกจาากโครงการแล้ว',
          ),
        ),
      ],
    );
  }

  EasyDialog showDialogExitProject(dynamic item) {
    return EasyDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      width: 400,
      height: 200,
      closeButton: false,
      contentListAlignment: CrossAxisAlignment.center,
      contentList: [
        Center(
          child: Text(
            'ยืนยันการออกจากโครงการ',
            style: TextStyle(
              fontFamily: fontRegular,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'เมื่อคุณกดยืนยันประตูจะถูกเปิดอัตโนมัติ',
            style: TextStyle(
              fontFamily: fontRegular,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundButtonOutline(
              title: 'ยกเลิก',
              press: () => Get.back(),
            ),
            RoundButton(
              title: 'ตกลง',
              press: () async {
                // call exit project api
                await exitProjectApi(item.logId);

                // notification
                sendNotification(item.licensePlate, "${item.firstname} ${item.lastname}", false);

                // ------------ mqtt ---------------
                final mqController = Get.put(MqttController());
                mqController.publishMessage('web-to-app/1', 'CHECKOUT');
                mqController.publishMessage('app-to-web', 'CHECKOUT');
                // ------------ mqtt ---------------

                Get.back();
                showDialogOpenGate(item).show(context);
                Timer(Duration(seconds: 3), () => Get.back());

                // ----------- gate ------------------
                gateController(gateBarrierOpenUrl);
                Future.delayed(Duration(seconds: 8),
                    () => gateController(gateBarrierCloseUrl));
                // ----------- gate ------------------
              },
            ),
          ],
        ),
      ],
    );
  }

  EasyDialog showDialogCard(dynamic item) {
    return EasyDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      width: 400,
      height: item.residentStamp != null && item.datetimeOut == null ? 550 : 500,
      closeButton: false,
      contentList: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ข้อมูลเพิ่มเติม',
              style: TextStyle(
                fontFamily: fontRegular,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Divider(color: dividerColor),
        // Image.network(ipServerIminService + '/card/' + item.qrGenId),
        Image.network(
          ipServerIminService + '/card/' + item.qrGenId,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),

        SizedBox(height: 20),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textDetial('เลขทะเบียนรถ'),
                textDetial('บ้านเลขที่'),
                textDetial('เวลาเข้า'),
                textDetial('เวลาออก'),
                textDetial('สถานะ'),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textDetial(item.licensePlate == '' || item.licensePlate == null
                    ? '-'
                    : item.licensePlate),
                textDetial(item.homeNumber == '' || item.homeNumber == null
                    ? '-'
                    : item.homeNumber),
                textDetial(item.datetimeIn != null
                    ? formatDateTime(item.datetimeIn)
                    : '-'),
                textDetial(item.datetimeOut != null
                    ? formatDateTime(item.datetimeOut)
                    : '-'),
                textDetial(
                  item.residentStamp == null
                      ? 'ยังไม่ได้รับการแสตมป์'
                      : item.datetimeOut == null
                          ? 'ได้รับการสแตมป์แล้ว'
                          : 'ออกจาากโครงการแล้ว',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        if (item.residentStamp != null && item.datetimeOut == null) ...[
          RoundButtonOutline(
            title: 'ออกจากโครงการ',
            press: () {
              Get.back();
              showDialogExitProject(item).show(context);
            },
          ),
        ],
      ],
    );
  }

  EasyDialog showDialogDetails(dynamic item) {
    return EasyDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      width: 400,
      height: item.residentStamp == null
          ? 300
          : item.datetimeOut != null
              ? 300
              : 350,
      closeButton: false,
      contentListAlignment: CrossAxisAlignment.center,
      contentList: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ข้อมูลเพิ่มเติม',
              style: TextStyle(
                fontFamily: fontRegular,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () => Get.back(),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Divider(color: dividerColor),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textDetial('เลขบัตรประจำตัวประชาชน'),
                textDetial('เลขทะเบียนรถ'),
                textDetial('ชื่อ - นามสกุล'),
                textDetial('บ้านเลขที่'),
                textDetial('เวลาเข้า'),
                textDetial('เวลาออก'),
                textDetial('สถานะ'),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textDetial(item.idCard == '' || item.idCard == null
                    ? '-'
                    : item.idCard),
                textDetial(item.licensePlate == '' || item.licensePlate == null
                    ? '-'
                    : item.licensePlate),
                textDetial(item.firstname == null
                    ? "-"
                    : "${item.firstname} ${item.lastname}"),
                textDetial(item.homeNumber == '' || item.homeNumber == null
                    ? '-'
                    : item.homeNumber),
                textDetial(item.datetimeIn != null
                    ? formatDateTime(item.datetimeIn)
                    : '-'),
                textDetial(item.datetimeOut != null
                    ? formatDateTime(item.datetimeOut)
                    : '-'),
                textDetial(
                  item.residentStamp == null
                      ? 'ยังไม่ได้รับการแสตมป์'
                      : 'ได้รับการสแตมป์แล้ว',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        if (item.residentStamp != null && item.datetimeOut == null) ...[
          RoundButtonOutline(
            title: 'ออกจากโครงการ',
            press: () {
              Get.back();
              showDialogExitProject(item).show(context);
            },
          ),
        ],
      ],
    );
  }

  Padding textDetial(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontRegular,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
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
