import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/popup_item.dart';
import 'package:imin/views/widgets/title_content.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EntranceProjectScreen extends StatefulWidget {
  EntranceProjectScreen({Key? key}) : super(key: key);

  @override
  _EntranceProjectScreenState createState() => _EntranceProjectScreenState();
}

class _EntranceProjectScreenState extends State<EntranceProjectScreen> {
  final controller = Get.put(ExitProjectController());

  @override
  void initState() {
    super.initState();
  }

  List<DataColumn> _createColumns() {
    List headerItems = [
      'เลขประจำตัวประชาชน',
      'เลขทะเบียนรถ',
      'ชื่อ - นามสกุล',
      'บ้านเลขที่',
      //ระดับ
      //วันที่นัดหมาย
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

  List<DataRow> _createRows() {
    return [
      DataRow(
        cells: [
          DataCell(Text('18009880000')),
          DataCell(Text('ยน 2310')),
          DataCell(Container(width: 100, child: Text('จิรายุ เนียลกุล'))),
          DataCell(Text('1/2')),
          DataCell(Text('01/06/64 08:20')),
          DataCell(Text('01/06/64 08:55')),
          DataCell(Text('ยังไม่ได้รับการแสตมป์')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('18009770000')),
          DataCell(Text('พห 5417')),
          DataCell(Container(width: 100, child: Text('สิธาณี ลิ้นบุญ'))),
          DataCell(Text('2/5')),
          DataCell(Text('01/06/64 09:50')),
          DataCell(Text('01/06/64 10:50')),
          DataCell(Text('ออกจากโครงการแล้ว')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('18009770000')),
          DataCell(Text('พห 5417')),
          DataCell(Container(width: 100, child: Text('สิธาณี ลิ้นบุญ'))),
          DataCell(Text('2/5')),
          DataCell(Text('01/06/64 09:50')),
          DataCell(Text('01/06/64 10:50')),
          DataCell(Text('ออกจากโครงการแล้ว')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('18009770000')),
          DataCell(Text('พห 5417')),
          DataCell(Container(width: 100, child: Text('สิธาณี ลิ้นบุญ'))),
          DataCell(Text('2/5')),
          DataCell(Text('01/06/64 09:50')),
          DataCell(Text('01/06/64 10:50')),
          DataCell(Text('ออกจากโครงการแล้ว')),
        ],
      ),
    ];
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
              Row(
                children: [
               
                  Container(
                    margin: EdgeInsets.only(
                        top: 15, bottom: 15, left: 40, right: 15),
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
                        hintText: 'ค้นหาเลขทะเบียนรถ, บ้านเลขที่, ชื่อนามสกุล',
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textColor)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleBlueColor),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  child: DataTable(
                    dividerThickness: 0.5,
                    columnSpacing: 40,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => purpleBlueColor),
                    columns: _createColumns(),
                    rows: _createRows(),
                  ),
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
    required this.time_in,
    required this.time_out,
    required this.status,
  });

  String id_card;
  String license;
  String fullname;
  String home_number;
  String time_in;
  String time_out;
  String status;
}
