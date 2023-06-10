import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/EntranceProject/upload_personal_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_d1_pro_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_screen.dart';
import 'package:imin/views/widgets/round_button_icon.dart';
import 'package:imin/views/widgets/round_button_number.dart';
import 'package:imin/views/widgets/title_content.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class EntranceProjectScreenD1Pro extends StatefulWidget {
  EntranceProjectScreenD1Pro({Key? key}) : super(key: key);

  @override
  _EntranceProjectScreenD1ProState createState() =>
      _EntranceProjectScreenD1ProState();
}

class _EntranceProjectScreenD1ProState
    extends State<EntranceProjectScreenD1Pro> {
  final entranceController = Get.put(EntranceProjectController());
  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrReaderController;
  Barcode? resultQrReader;
  syncFunction() async {
    // controller.getDataEntrance(); //Allist
    entranceController.getEntranceData(); // 3 list
  }

  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    entranceController.totalValue.value = batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _getValue() async {
    String totalValue;
    try {
      var result = await platform.invokeMethod('setInitPrinter');
      totalValue = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      totalValue = "Failed to get battery level: '${e.message}'.";
    }
    entranceController.totalValue.value = totalValue;
    setState(() {
      _batteryLevel = totalValue;
    });
  }

  @override
  void initState() {
    // syncFunction();

    _getBatteryLevel();
    super.initState();
  }

  TextEditingController findControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    entranceController.context = context;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleContent(text: 'เวลาเข้าโครงการ'),
              // Text(entranceController.totalValue.value),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, bottom: 15, left: 0, right: 0),
                      width: size.width * 0.33,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(color: textColor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        onChanged: (v) =>
                            entranceController.filterSearchResults(v),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: OutlineInputBorder(),
                          hintText:
                              'ค้นหาเลขทะเบียนรถ, บ้านเลขที่, ชื่อนามสกุล',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleBlueColor),
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () => controller.getDataEntrance(),
                    //     // onPressed: () => controller.getEntranceData(),
                    //     child: Text('pulldata')),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GetBuilder<ExpansionPanelController>(
                          builder: (c) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: redAlertColor,
                              side: BorderSide(
                                width: 1,
                                color: redAlertColor,
                              ),
                            ),
                            onPressed: () {
                              cameraController.imageUrl.value = "";
                              uploadPersonalController.initValue();
                              c.currentContent = UploadPersonalScreen();
                              c.update(['aopbmsbbffdgkb']);
                            },
                            child: Text(
                              'เพิ่มผู้เข้าโครงการ',
                              style: TextStyle(
                                color: textColorContrast,
                                fontSize: 18,
                                fontFamily: fontRegular,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //   'แสกน QR Code',
                        //   style: TextStyle(
                        //     color: textColorContrast,
                        //     fontSize: 18,
                        //     fontFamily: fontRegular,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // TextButton(
                        //     onPressed: () => [],
                        //     // onPressed: () => controller.getEntranceData(),
                        //     child: Text('แสกน QR Code')),
                      ],
                    ),
                  ],
                ),
              ),
              // table list
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  // vertical: size.height * 0.01
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: dividerTableColor),
                  child: GetBuilder<EntranceProjectController>(
                    id: 'update-enteance-data-row',
                    builder: (c) => Obx(
                      () => Row(
                        children: [
                          DataTable(
                            showCheckboxColumn: false,
                            dividerThickness: 0.5,
                            columnSpacing:
                                (entranceController.hasDataValue.value == true)
                                    ? 30
                                    : 65.5,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => purpleBlueColor),
                            columns: c.createColumns(),
                            // columns: _createColumns(),
                            rows: c.dataRow,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // show nodata
              GetBuilder<EntranceProjectController>(
                id: 'update-enteance-data-row',
                builder: (c) => (c.dataRow.length <= 0)
                    ? Container(
                        // color: whi,
                        height: size.height * 0.57,
                        width: size.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          // vertical: size.height * 0.01
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empty_box.png',
                              fit: BoxFit.none,
                            ),
                            Text('ไม่มีข้อมูล')
                          ],
                        ),
                      )
                    : Container(),
              ),
              // space
              Container(
                // color: themeBgColor,
                height: size.height * 0.02,
                width: size.width,
              ),
              // Button Group
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    padding: EdgeInsets.only(bottom: size.height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RoundButtonIcon(
                          icon: Icons.arrow_back_ios_new,
                          onClick: () => entranceController.onClickBackPaging(),
                          // onClick: () {},
                        ),
                        for (int i = entranceController.startPaging.value - 1;
                            i <
                                (entranceController.totalPagingNumber.value <
                                        (entranceController.startPaging.value +
                                            entranceController
                                                .pagingRange.value)
                                    ? entranceController
                                                .totalPagingNumber.value ==
                                            1
                                        ? 1
                                        : entranceController
                                            .totalPagingNumber.value
                                    : (entranceController.startPaging.value +
                                        entranceController.pagingRange.value));
                            i++) ...[
                          RoundButtonNumber(
                            index: (i + 1).toString(),
                            selectd:
                                entranceController.selectPaging.value == i + 1
                                    ? true
                                    : false,
                            onClick: () =>
                                entranceController.onClickPaging(i + 1),
                          ),
                        ],
                        RoundButtonIcon(
                          icon: Icons.arrow_forward_ios,
                          onClick: () => entranceController.onClickNextPaging(),
                          // onClick: () {},
                        ),
                      ],
                    ),
                  )),
            ],

            // children: [
            //   Expanded(flex: 4, child: _buildQrView(context)),
            // ],
          ),
        ),
      ],
    );
  }

  // qrreader
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController qrReaderController) {
    setState(() {
      this.qrReaderController = qrReaderController;
    });
    qrReaderController.scannedDataStream.listen((scanData) {
      setState(() {
        resultQrReader = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    qrReaderController?.dispose();
    super.dispose();
  }
}
