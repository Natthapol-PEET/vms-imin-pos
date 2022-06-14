import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_controller.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/expansion_panel_controller.dart';
import 'package:imin/controllers/upload_personal_controller.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/screens/EntranceProject/upload_personal_screen.dart';
import 'package:imin/views/screens/ExitProject/exit_project_screen.dart';
import 'package:imin/views/widgets/title_content.dart';

class EntranceProjectScreen extends StatefulWidget {
  EntranceProjectScreen({Key? key}) : super(key: key);

  @override
  _EntranceProjectScreenState createState() => _EntranceProjectScreenState();
}

class _EntranceProjectScreenState extends State<EntranceProjectScreen> {
  final entranceController = Get.put(EntranceProjectController());
  final uploadPersonalController = Get.put(UploadPersonalController());
  final cameraController = Get.put(TakePictureController());

  syncFunction() async {
    // controller.getDataEntrance(); //Allist
    entranceController.getEntranceData(); // 3 list
  }

  @override
  void initState() {
    // syncFunction();
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
                              primary: purpleBlueColor,
                              side: BorderSide(
                                width: 1,
                                color: purpleBlueColor,
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
          ),
        ),
      ],
    );
  }
}
