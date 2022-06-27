import 'dart:async';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/Functions/time_to_thai.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/functions/dialog_gate.dart';
import 'package:imin/helpers/configs.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/visitor_model.dart';
import 'package:imin/models/whitelist_model.dart';
import 'package:imin/services/exit_service.dart';
import 'package:imin/services/gate_service.dart';
import 'package:imin/views/widgets/round_button.dart';
import 'package:imin/views/widgets/round_button_outline.dart';

class ExitProjectControllerM2 extends GetxController {
  final loginController = Get.put(LoginController());

  var context;

  // String searchValue = "";
  var searchValue = "".obs;
  var visitorList = <VisitorModel>[].obs;
  var whitelistList = <WhitelistModel>[].obs;
  var dataRow = <DataRow>[];

  var startEndRange = "".obs;
  DateTime? startDatetime;
  DateTime? endDatetime;

  var startPaging = 1.obs;
  var selectPaging = 1.obs;
  var pagingRange = 4.obs;
  var displayRowNumber = 9.obs;
  var totalPagingNumber = 1.obs;

  @override
  void onInit() {
    DateTime v = DateTime.now();
    startEndRange.value = dummyDatetime(v) + " - " + dummyDatetime(v);

    searchValue.value = "";
    visitorList.value = [];
    whitelistList.value = [];
    dataRow = [];

    DateTime now = DateTime.now();
    startDatetime = DateTime(now.year, now.month, now.day - 1);
    endDatetime = DateTime(now.year, now.month, now.day + 1);

    getExitData();

    super.onInit();
  }

  onClickPaging(int index) {
    selectPaging.value = index;
    createRows(visitorList, whitelistList);
  }

  onClickBackPaging() {
    if (startPaging.value == 1) return;
    startPaging.value -= 1;
  }

  onClickNextPaging() {
    if (totalPagingNumber.value < startPaging.value + pagingRange.value) return;

    startPaging.value += 1;
  }

  getExitData() async {
    EasyLoading.show(status: 'โหลดข้อมูล ...');

    var jSon = await getExitDataApi(loginController.dataProfile.token);
    visitorList.clear();
    whitelistList.clear();

    jSon['resultVisitor']
        .forEach((item) => visitorList.add(VisitorModel.fromJson(item)));
    jSon['resultWhitelist']
        .forEach((item) => whitelistList.add(WhitelistModel.fromJson(item)));

    createRows(visitorList, whitelistList);
  }

  void createRows(List visitorList, List whitelistList) {
    dataRow.clear();

    // search data rows
    whitelistList = searchDataRows(whitelistList);
    visitorList = searchDataRows(visitorList);

    // search by submitSelectRangeTime
    whitelistList = searchByDateTime(whitelistList);
    visitorList = searchByDateTime(visitorList);

    // map to data_row
    whitelistList.forEach((item) => dataRow.add(createDataRow(item)));
    visitorList.forEach((item) => dataRow.add(createDataRow(item)));

    // map to paging
    dataRow = mapToPaging();

    update(['update-exit-data-row']);
    EasyLoading.dismiss();
  }

  mapToPaging() {
    List<DataRow> newDataRow = [];
    totalPagingNumber.value = (dataRow.length / displayRowNumber.value).ceil();

    int calEnd = selectPaging.value * displayRowNumber.value;
    int startRow = calEnd - displayRowNumber.value;
    int endRow = calEnd > dataRow.length ? dataRow.length : calEnd;

    // print("dataRow: ${dataRow.length}");
    // print("totalPagingNumber: $totalPagingNumber");
    // print("selectPaging: $pagingRange");
    // print("startRow: $startRow");
    // print("endRow: $endRow");

    for (int i = startRow; i < endRow; i++) {
      newDataRow.add(dataRow[i]);
    }

    return newDataRow;
  }

  searchByDateTime(list) {
    if (endDatetime == null) {
      endDatetime = startDatetime;
      startEndRange.value =
          dummyDatetime(startDatetime!) + " - " + dummyDatetime(startDatetime!);
    } else {
      if (startDatetime!.day > endDatetime!.day) {
        startEndRange.value =
            dummyDatetime(endDatetime) + " - " + dummyDatetime(startDatetime);
      } else {
        startEndRange.value =
            dummyDatetime(startDatetime) + " - " + dummyDatetime(endDatetime);
      }
    }

    return list.where((item) {
      DateTime strToDatetime =
          DateTime.parse(item.datetimeIn.replaceAll("T", " "));
      if (startDatetime!.isBefore(strToDatetime) &&
          endDatetime!.isAfter(strToDatetime)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  searchDataRows(list) {
    return list
        .where((item) =>
            item.idCard.toString().contains(searchValue.value) ||
            item.licensePlate.toString().contains(searchValue.value) ||
            item.firstname.toString().contains(searchValue.value) ||
            item.homeNumber.toString().contains(searchValue.value))
        .toList();
  }

  searchOnchange(value) {
    searchValue.value = value;
    createRows(visitorList, whitelistList);
  }

  void cleanAndCreateDummy(DateTime start, DateTime? end) {
    startDatetime = start;
    endDatetime = end;
  }

  void submitSelectRangeTime() {
    createRows(visitorList, whitelistList);

    Get.back();
  }

  String dummyDatetime(DateTime? v) {
    // 18 พฤษภาคม 2565
    v = v as DateTime;
    // return "${v.day} ${month_eng_to_thai(v.month)} ${christian_buddhist_year(v.year)}";
    return "${v.day}/${v.month}/${v.year}";
  }

  String formatDateTime(String dateStr) {
    // 01/06/64 08:20
    DateTime dt = DateTime.parse(dateStr.replaceAll('T', ' '));

    return "${dt.day}/${dt.month}/${dt.year + 543} ${dt.hour}:${dt.minute}";
  }

  DataRow createDataRow(dynamic item) {
    return DataRow(
      onSelectChanged: (state) => item.firstname == null
          ? showDialogCard(item).show(context)
          : showDialogDetails(item).show(context),
      cells: [
        DataCell(Center(
            child: Text(
          item.idCard == '' || item.idCard == null ? '-' : item.idCard,
          style: TextStyle(fontSize: normalM2FontSize),
        ))),
        DataCell(Center(
            child: Text(
          item.licensePlate == '' || item.licensePlate == null
              ? '-'
              : item.licensePlate,
          style: TextStyle(fontSize: normalM2FontSize),
        ))),
        DataCell(Center(
            child: Text(
          item.homeNumber ?? '-',
          style: TextStyle(fontSize: normalM2FontSize),
        ))),
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
                await exitProjectApi(
                    item.logId, loginController.dataProfile.token);

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
      height:
          item.residentStamp != null && item.datetimeOut == null ? 490 : 440,
      closeButton: false,
      contentList: [
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ข้อมูลเพิ่มเติม',
                style: TextStyle(
                  fontFamily: fontRegular,
                  fontSize: normalM2FontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, alignment: Alignment.centerRight),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Divider(color: dividerColor),
        FadeInImage(
          height: 230,
          placeholder: AssetImage('assets/images/id-card-image.png'),
          image: NetworkImage(
            ipServerIminService + '/card/' + item.qrGenId + '/',
            headers: <String, String>{
              'Authorization': 'Bearer ${loginController.dataProfile.token}'
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                          : 'ออกจากโครงการแล้ว',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        if (item.residentStamp != null && item.datetimeOut == null) ...[
          RoundButtonOutline(
            title: 'ออกจากโครงการ',
            fontSize: normalM2FontSize,
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
      width: 300,
      height: item.residentStamp == null
          ? 220
          : item.datetimeOut != null
              ? 220
              : 280,
      closeButton: false,
      contentListAlignment: CrossAxisAlignment.center,
      contentList: [
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ข้อมูลเพิ่มเติม',
                style: TextStyle(
                  fontFamily: fontRegular,
                  fontSize: normalM2FontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, alignment: Alignment.centerRight),
                onPressed: () => Get.back(),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Divider(color: dividerColor),
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(width: 40),
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
                      : item.datetimeOut == null
                          ? 'ได้รับการสแตมป์แล้ว'
                          : 'ออกจากโครงการแล้ว',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        if (item.residentStamp != null && item.datetimeOut == null) ...[
          RoundButtonOutline(
            title: 'ออกจากโครงการ',
            fontSize: normalM2FontSize,
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
          fontSize: normalM2FontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<DataColumn> createColumns() {
    List headerItems = [
      'เลขประจำตัวประชาชน',
      'เลขทะเบียนรถ',
      'บ้านเลขที่',
      // ''
    ];

    return headerItems
        .map((item) => DataColumn(
                label: Text(
              item,
              style: TextStyle(
                  fontFamily: fontRegular,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white),
            )))
        .toList();
  }
}
