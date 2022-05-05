import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/title_content.dart';

class ExitProjectScreen extends StatefulWidget {
  ExitProjectScreen({Key? key}) : super(key: key);

  @override
  _ExitProjectScreenState createState() => _ExitProjectScreenState();
}

class _ExitProjectScreenState extends State<ExitProjectScreen> {
  // List<Item> _items = [];

  // List<Item> _generateItems() {
  //   return List.generate(5, (int index) {
  //     return Item(
  //       id_card: index,
  //       name: 'Item $index',
  //       price: index * 1000.00,
  //       description: 'Details of item $index',
  //     );
  //   });
  // }

  // TableRow _buildTableRow(Item item) {
  //   return TableRow(
  //       key: ValueKey(item.id),
  //       decoration: BoxDecoration(
  //         color: Colors.lightBlueAccent,
  //       ),
  //       children: [
  //         TableCell(
  //           verticalAlignment: TableCellVerticalAlignment.bottom,
  //           child: SizedBox(
  //             height: 50,
  //             child: Center(
  //               child: Text(item.id.toString()),
  //             ),
  //           ),
  //         ),
  //         TableCell(
  //           verticalAlignment: TableCellVerticalAlignment.middle,
  //           child: Padding(
  //             padding: const EdgeInsets.all(5),
  //             child: Text(item.name),
  //           ),
  //         ),
  //         TableCell(
  //           verticalAlignment: TableCellVerticalAlignment.middle,
  //           child: Padding(
  //             padding: const EdgeInsets.all(5),
  //             child: Text(item.price.toString()),
  //           ),
  //         ),
  //         TableCell(
  //           child: Padding(
  //             padding: const EdgeInsets.all(5),
  //             child: Text(item.description),
  //           ),
  //         ),
  //       ]);
  // }

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
                color: Colors.white
              ),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContent(text: 'เวลาออกจากโครงการ'),
        // child: Theme(
        //   data: Theme.of(context)
        //       .copyWith(dividerColor: Colors.transparent),
        //   child:
        Container(
          // padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.black,
            //   width: 8,
            // ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.01),
          child: DataTable(
            dividerThickness: 0.0,
            columnSpacing: 40,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => purpleBlueColor),
            columns: _createColumns(),
            // columns: _columnItem.map((item) => _createColumns(item)).toList(),
            rows: _createRows(),
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
