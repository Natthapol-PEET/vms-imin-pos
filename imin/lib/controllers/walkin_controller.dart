import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/login_controller.dart';
import 'package:imin/controllers/screen_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/models/blacklist_model.dart';
import 'package:imin/models/visitor_model.dart';
import 'package:imin/models/whitelist_model.dart';
import 'package:imin/services/get_all_home_service.dart';
import 'package:imin/services/get_enteance_project_blacklist_service.dart';

class WalkinController extends GetxController {
  var loginController = Get.put(LoginController());
  var screenController = Get.put(ScreenController());

  var context;
  var dataEntrance = [].obs;
  var visitorList = <VisitorModel>[].obs;
  var whitelistList = <WhitelistModel>[].obs;
  var blacklistList = <BlacklistModel>[].obs;
  var dataRow = <DataRow>[];
  var dataBlacklistRow = <DataRow>[];
  var searchValue = '';
  var hasDataValue = false.obs;
  List<String>? homeListData = <String>[];

  String token = "";

  var startPaging = 1.obs;
  var selectPaging = 1.obs;
  var pagingRange = 4.obs;
  var displayRowNumber = 9.obs;
  var totalPagingNumber = 1.obs;

  @override
  void onInit() {
    token = loginController.dataProfile.token;

    getEntranceData();
    getAllHome();
    super.onInit();
  }

  void getAllHome() async {
    EasyLoading.show(status: 'โหลดข้อมูล ...');

    // var jSon = await getEntranceProjectApi(token);
    var response = await getAllHomeService(token);

    if (response.runtimeType is bool) return;

    print('responseHome');
    print(response);

    List homeList = [];

    response.forEach((v) => homeList.add(v['address'].split('/')));

    homeList.sort((a, b) => int.parse(a[0]).compareTo(int.parse(b[0])));

    // homeList = [[1, 12], [1, 24], [1, 28], [1, 32], [1, 56], [1, 88], [2, 200], [1, 205]]

    List group = [];
    List key = [];

    // get key
    homeList.forEach((v) {
      if (!key.contains(v[0])) {
        key.add(v[0]);
      }
    });

    key.forEach((v) {
      group.add(homeList.where((elem) => elem[0] == v).toList());
    });

    homeList = [];

    group.forEach((elem) {
      elem.sort((a, b) => int.parse(a[1]).compareTo(int.parse(b[1])));

      homeList = [...homeList, ...elem];
    });

    List<String> homeListStr = [];

    homeList.forEach((v) {
      homeListStr.add(v[0].toString() + '/' + v[1].toString());
    });
    homeListData = homeListStr;
    update(['update-walkin-home-data']);
    print("homeListData: $homeListData");

    EasyLoading.dismiss();
  }

// search
  void filterSearchResults(String query) {
    searchValue = query;
    List<String> dummySearchList = [];
    // dummySearchList.addAll(whitelistList);

    var listToShow = [];
    if (query.isNotEmpty) {
      query = query.toLowerCase();
      List result = [];
      blacklistList.forEach((p) {
        var homeNumber = p.homeNumber.toString().toLowerCase();
        if (homeNumber == (query)) {
          result.add(p);
        }
      });
      createRowSearch(result);
      return;
    } else {
      // if (blacklistList.length > 0) {
      //   hasDataValue.value = true;
      // } else {
      //   hasDataValue.value = false;
      // }
      hasDataValue.value = false;
      dataRow.clear();
      // blacklistList.forEach((item) => dataRow.add(createDataRow(item)));
      dataRow = mapToPaging();
      update(['update-walkin-data-row']);
    }
  }

  void createRowSearch(List AllListData) {
    if (AllListData.length > 0) {
      hasDataValue.value = true;
    } else {
      hasDataValue.value = false;
    }
    // print('hasDataValue.value: ${hasDataValue.value}');
    dataRow.clear();
    AllListData.forEach((item) => dataRow.add(createDataRow(item)));
    dataRow = mapToPaging();
    update(['update-walkin-data-row']);
  }

//3 List
  getEntranceData() async {
    EasyLoading.show(status: 'โหลดข้อมูล ...');

    // var jSon = await getEntranceProjectApi(token);
    var jSonBlacklist = await getEntranceProjectBlacklistApi(token);
    blacklistList.clear();
    // print('json: ${jSon}');
    jSonBlacklist
        .forEach((item) => blacklistList.add(BlacklistModel.fromJson(item)));

    // createRows(visitorList, whitelistList, blacklistList);
    filterSearchResults(searchValue);
    EasyLoading.dismiss();
  }

//////////// get to table
  DataRow createDataRow(item) {
    return DataRow(
      cells: [
        // DataCell(Center(
        //     child: Text(item.licensePlate == '' || item.licensePlate == null
        //         ? '-'
        //         : item.licensePlate))),
        DataCell(Container(
            // width: 350,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.licensePlate == '' || item.licensePlate == null
                ? "ทะเบียนรถ : -"
                : "ทะเบียนรถ : ${item.licensePlate}"),
            Text(item.firstname == null
                ? "ชื่อ-นามสกุล : -"
                : "ชื่อ-นามสกุล : ${item.firstname} ${item.lastname}"),
          ],
        ))),
      ],
    );
  }

//////////////

  ///
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

  /// create column table
  List<DataColumn> createColumns(Size size) {
    List headerItems = [
      'รายชื่อผู้ไม่มีสิทธิ์เข้าโครงการ',
    ];

    return headerItems
        .map((item) => DataColumn(
                label: Container(
              width: (screenController.DeviceCurrent == Device.iminM2Pro)
                  ? size.width * 0.582
                  : size.width * 0.282,
              child: Text(
                item,
                style: TextStyle(
                    fontFamily: fontRegular,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )))
        .toList();
  }

  List<DataColumn> createBlacklistColumns() {
    List headerItems = [
      'รายชื่อผู้ไม่มีสิทธิ์เข้าโครงการ',
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

  ////////////////////////////

/////////////////////////// onclick
  mapToPaging() {
    List<DataRow> newDataRow = [];
    totalPagingNumber.value =
        ((dataRow.length / displayRowNumber.value)).ceil();

    int calEnd = selectPaging.value * displayRowNumber.value;
    int startRow = calEnd - displayRowNumber.value;
    int endRow = calEnd > dataRow.length ? dataRow.length : calEnd;

    for (int i = startRow; i < endRow; i++) {
      newDataRow.add(dataRow[i]);
    }

    return newDataRow;
  }

  onClickPaging(int index) {
    selectPaging.value = index;
    filterSearchResults(searchValue);
  }

  onClickBackPaging() {
    if (startPaging.value == 1) return;
    startPaging.value -= 1;
  }

  onClickNextPaging() {
    if (totalPagingNumber.value < startPaging.value + pagingRange.value) return;

    startPaging.value += 1;
  }

  ///
}
