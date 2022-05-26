import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
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

  syncFunction() async {
    // controller.getDataEntrance(); //Allist
    controller.getEntranceData(); // 3 list
  }

  @override
  void initState() {
    syncFunction();
    super.initState();
  }

  TextEditingController findControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.context = context;

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
                        onChanged: (v) => controller.filterSearchResults(v),
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
                              primary: purpleBlueColor,
                              side: BorderSide(
                                width: 1,
                                color: purpleBlueColor,
                              ),
                            ),
                            onPressed: () {
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
                    builder: (c) => Obx(
                      () => Row(
                        children: [
                          DataTable(
                            showCheckboxColumn: false,
                            dividerThickness: 0.5,
                            columnSpacing:
                                (controller.hasDataValue.value == true)
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
            ],
          ),
        ),
      ],
    );
  }
}
