import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/EntranceProject/upload_personal_screen.dart';
import 'package:imin/views/widgets/title_content.dart';

class EntranceProjectScreen extends StatefulWidget {
  EntranceProjectScreen({Key? key}) : super(key: key);

  @override
  _EntranceProjectScreenState createState() => _EntranceProjectScreenState();
}

class _EntranceProjectScreenState extends State<EntranceProjectScreen> {
  final controller = Get.put(EntranceProjectController());
  final uploadController = Get.put(UploadPersonalController());

  syncFunction() async {
    controller.getEntranceData();
  }

  List<dynamic> values = <dynamic>[];
  final List<Map<String, String>> _data = [
    {'Country': 'China', 'Population': '1400'},
    {'Country': 'India', 'Population': '1360'},
  ];
  // final List _data = Get.put(EntranceProjectController()).dataEntrance;
  late List<String> _columnNames;

  void _addColumn(String newColumn) {
    if (_columnNames.contains(newColumn)) {
      return;
    }
    setState(() {
      for (var i = 0; i <= _data.length - 1; i++) {
        _data[i][newColumn] = '';
      }
      _columnNames.add(newColumn);
    });
  }

  void _removeColumn(String oldColumn) {
    if (_columnNames.length == 1 || !_columnNames.contains(oldColumn)) {
      return;
    }
    setState(() {
      for (var i = 0; i <= _data.length - 1; i++) {
        _data[i].remove(oldColumn);
      }
      _columnNames.remove(oldColumn);
    });
  }

  void _addRow(Map<String, String> newRow) {
    _columnNames.forEach((colName) {
      if (!newRow.containsKey(colName)) {
        newRow[colName] = '';
      }
    });

    setState(() {
      _data.add(newRow);
    });
  }

  @override
  void initState() {
    _columnNames = _data[0].keys.toList();
    syncFunction();
    super.initState();
  }

  List<DataColumn> _createColumns() {
    List headerItems = [
      'เลขประจำตัวประชาชน',
      'เลขทะเบียนรถ',
      'ชื่อ - นามสกุล',
      'บ้านเลขที่',
      'ระดับ',
      'วันที่นัดหมาย',
      'สถานะ',
      // 'สถานะ2',
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

  TextEditingController findControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleContent(text: 'เวลาเข้าโครงการ'),
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
                    TextButton(
                        onPressed: () => controller.getDataEntrance(),
                        // onPressed: () => controller.getEntranceData(),
                        child: Text('pulldata')),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GetBuilder<ExpansionPanelController>(
                          builder: (c) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: purpleBlueColor,
                              side: BorderSide(
                                width: 1,
                                color: purpleBlueColor,
                              ),
                            ),
                            onPressed: () {
                              uploadController.initValue();
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
                      ],
                    ),
                  ],
                ),
              ),
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
                    vertical: size.height * 0.01),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: dividerTableColor),
                  child: GetBuilder<EntranceProjectController>(
                    id: 'update-enteance-data-row',
                    builder: (c) => DataTable(
                      showCheckboxColumn: false,
                      dividerThickness: 0.5,
                      columnSpacing: 30,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => purpleBlueColor),
                      columns: c.createColumns(),
                      // columns: _createColumns(),
                      rows: c.dataRow,
                      // rows: controller.dataEntrance
                      //     .map(
                      //       (entry) => DataRow(
                      //         cells: [
                      //           DataCell(Text(entry['id_card'] != null &&
                      //                   entry['id_card'] != ""
                      //               ? '${entry['id_card']}'
                      //               : '-')),
                      //           DataCell(
                      //               // Text('${entry['license_plate'] ?? "-"}')),
                      //               Text(entry['license_plate'] != null
                      //                   ? '${entry['license_plate']}'
                      //                   : '-')),
                      //           DataCell(Text(
                      //               '${entry['firstname'] ?? "-"} ${entry['lastname'] ?? ""}')),
                      //           DataCell(
                      //               Text('${entry['home_number'] ?? "-"}')),
                      //           DataCell(Text(entry['visitor_id'] != null
                      //               ? 'นัดหมายเข้าโครงการ'
                      //               : entry['whitelist_id'] != null
                      //                   ? 'รับเชิญพิเศษ'
                      //                   : 'ไม่มีสิทธิ์เข้าโครงการ')),
                      //           DataCell(Text((entry['visitor_id'] != null)
                      //               ? entry['invite_date']
                      //               : (entry['whitelist_id'] != null)
                      //                   ? '-'
                      //                   : '-')),
                      //           DataCell(Text((entry['visitor_id'] != null)
                      //               ? (entry['datetime_in'] != null)
                      //                   ? (entry['datetime_out'] != null)
                      //                       ? 'ออกจากโครงการ'
                      //                       : 'อยู่ในโครงการ'
                      //                   : 'รอดำเนินการ'
                      //               : (entry['whitelist_id'] != null)
                      //                   ? (entry['datetime_in'] != null)
                      //                       ? (entry['datetime_out'] != null)
                      //                           ? 'รอดำเนินการ'
                      //                           : 'อยู่ในโครงการ'
                      //                       : 'รอดำเนินการ'
                      //                   : '-')),
                      //         ],
                      //       ),
                      //     )
                      //     .toList(),
                    ),
                  ),
                  // DataTable(
                  //   dividerThickness: 0.5,
                  //   columnSpacing: 40,
                  //   headingRowColor: MaterialStateColor.resolveWith(
                  //       (states) => purpleBlueColor),
                  //   columns: _createColumns(),
                  //   ///////////////////////////
                  //   rows: controller.dataEntrance
                  //       .map(
                  //         (entry) => DataRow(
                  //           cells: [
                  //             DataCell(Text(entry['id_card'] != null &&
                  //                     entry['id_card'] != ""
                  //                 ? '${entry['id_card']}'
                  //                 : '-')),
                  //             DataCell(
                  //                 // Text('${entry['license_plate'] ?? "-"}')),
                  //                 Text(entry['license_plate'] != null
                  //                     ? '${entry['license_plate']}'
                  //                     : '-')),
                  //             DataCell(Text(
                  //                 '${entry['firstname'] ?? "-"} ${entry['lastname'] ?? ""}')),
                  //             DataCell(Text('${entry['home_number'] ?? "-"}')),
                  //             DataCell(Text(entry['visitor_id'] != null
                  //                 ? 'นัดหมายเข้าโครงการ'
                  //                 : entry['whitelist_id'] != null
                  //                     ? 'รับเชิญพิเศษ'
                  //                     : 'ไม่มีสิทธิ์เข้าโครงการ')),
                  //             DataCell(Text((entry['visitor_id'] != null)
                  //                 ? entry['invite_date']
                  //                 : (entry['whitelist_id'] != null)
                  //                     ? '-'
                  //                     : '-')),
                  //             DataCell(Text((entry['visitor_id'] != null)
                  //                 ? (entry['datetime_in'] != null)
                  //                     ? (entry['datetime_out'] != null)
                  //                         ? 'ออกจากโครงการ'
                  //                         : 'อยู่ในโครงการ'
                  //                     : 'รอดำเนินการ'
                  //                 : (entry['whitelist_id'] != null)
                  //                     ? (entry['datetime_in'] != null)
                  //                         ? (entry['datetime_out'] != null)
                  //                             ? 'รอดำเนินการ'
                  //                             : 'อยู่ในโครงการ'
                  //                         : 'รอดำเนินการ'
                  //                     : '-')),
                  //           ],
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Item {
  Item({
    required this.id_card,
    required this.license,
    required this.fullname,
    required this.home_number,
    required this.level_status,
    required this.date_in,
    required this.status,
  });

  String id_card;
  String license;
  String fullname;
  String home_number;
  String level_status;
  String date_in;
  String status;
}
