import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:imin/controllers/exit_project_controller_m2.dart';
import 'package:imin/helpers/constance.dart';
import 'package:imin/views/widgets/popup_item.dart';
import 'package:imin/views/widgets/round_button_icon.dart';
import 'package:imin/views/widgets/round_button_number.dart';
import 'package:imin/views/widgets/title_content.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ExitProjectM2ProScreen extends StatelessWidget {
  const ExitProjectM2ProScreen({
    Key? key,
    required this.size,
    required this.exitController,
  }) : super(key: key);

  final Size size;
  final ExitProjectControllerM2 exitController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleContent(
                text: 'เวลาออกจากโครงการ',
                fontSize: titleM2FontSize,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 15),
                    width: size.width * 0.53,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: textColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 10,
                              ),
                              SizedBox(width: 5),
                              Obx(
                                () => Text(
                                  // 'ช่วงวัน : 1 มิถุนายน 2564 - 1 กรกฎาคม 2564',
                                  'ช่วงวัน : ' +
                                      exitController.startEndRange.value,
                                  style: TextStyle(
                                      fontFamily: fontRegular,
                                      fontWeight: FontWeight.bold,
                                      fontSize: normalM2FontSize),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // color: Colors.amber,
                            width: 20,
                            child: PopupMenuButton(
                              offset: Offset(70, size.height * 0.06),
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.expand_more,
                                color: Colors.black,
                                size: 15,
                              ),
                              iconSize: 1,
                              itemBuilder: (_) {
                                return [
                                  PopupItem(
                                    child: Container(
                                      width: size.width * 0.8,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: size.height * 0.3,
                                            child: SfDateRangePicker(
                                              showActionButtons: false,
                                              // enableMultiView: true,
                                              // viewSpacing: 20,
                                              // era: EraMode.BUDDHIST_YEAR,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .range,
                                              view: DateRangePickerView.month,
                                              selectionShape:
                                                  DateRangePickerSelectionShape
                                                      .rectangle,
                                              selectionTextStyle: TextStyle(
                                                fontSize: normalM2FontSize,
                                                fontFamily: fontRegular,
                                                color: Colors.white,
                                              ),
                                              todayHighlightColor:
                                                  purpleBlueColor,
                                              headerStyle:
                                                  DateRangePickerHeaderStyle(
                                                textAlign: TextAlign.center,
                                                textStyle: TextStyle(
                                                  fontFamily: fontRegular,
                                                  fontSize: normalM2FontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),

                                              monthViewSettings:
                                                  DateRangePickerMonthViewSettings(
                                                viewHeaderStyle:
                                                    DateRangePickerViewHeaderStyle(
                                                  textStyle: TextStyle(
                                                    fontFamily: fontRegular,
                                                    color: Colors.black,
                                                    fontSize: normalM2FontSize,
                                                  ),
                                                ),
                                              ),

                                              rangeTextStyle: TextStyle(
                                                  fontSize: normalM2FontSize,
                                                  fontFamily: fontRegular,
                                                  color: Colors.black),
                                              selectionColor: purpleBlueColor,
                                              startRangeSelectionColor:
                                                  purpleBlueColor,
                                              endRangeSelectionColor:
                                                  purpleBlueColor,
                                              // rangeSelectionColor: Colors.purpleAccent,

                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                textStyle: TextStyle(
                                                    fontSize: normalM2FontSize,
                                                    fontFamily: fontRegular,
                                                    color: Colors.black),
                                                todayTextStyle: TextStyle(
                                                  fontSize: normalM2FontSize,
                                                  fontFamily: fontRegular,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              yearCellStyle:
                                                  DateRangePickerYearCellStyle(
                                                textStyle: TextStyle(
                                                  fontSize: normalM2FontSize,
                                                  fontFamily: fontRegular,
                                                  color: Colors.black,
                                                ),
                                              ),

                                              // confirmText: 'ตกลง',
                                              // onSubmit: (v) => exitController
                                              //     .submitSelectRangeTime(),
                                              // cancelText: 'ยกเลิก',
                                              // onCancel: () => Get.back(),
                                              onSelectionChanged: (v) =>
                                                  exitController
                                                      .cleanAndCreateDummy(
                                                          v.value.startDate,
                                                          v.value.endDate),
                                            ),
                                          ),
                                          Container(
                                            height: size.height * 0.05,
                                            // color: Colors.amber,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    exitController
                                                        .submitSelectRangeTime();
                                                  },
                                                  child: Text(
                                                    "ตกลง",
                                                    style: TextStyle(
                                                        fontSize:
                                                            normalM2FontSize),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text("ยกเลิก",
                                                      style: TextStyle(
                                                          fontSize:
                                                              normalM2FontSize)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.36,
                    height: size.height * 0.05,
                    child: TextFormField(
                      style: TextStyle(fontSize: normalM2FontSize),
                      initialValue: exitController.searchValue.value,
                      onChanged: exitController.searchOnchange,
                      decoration: InputDecoration(
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 25, maxHeight: 20),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20,
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'ค้นหาเลขทะเบียนรถ, บ้านเลขที่, ชื่อนามสกุล',
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
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
              // table list
              Container(
                width: size.width,
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
                margin: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                  top: size.height * 0.01,
                  // bottom: size.height * 0.02,
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: dividerTableColor),
                  child: GetBuilder<ExitProjectControllerM2>(
                    id: 'update-exit-data-row',
                    builder: (c) => DataTable(
                      showCheckboxColumn: false,
                      dividerThickness: 0.5,
                      columnSpacing: 30,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => purpleBlueColor),
                      columns: c.createColumns(),
                      rows: c.dataRow,
                    ),
                  ),
                ),
              ),
              // show nodata
              GetBuilder<ExitProjectControllerM2>(
                id: 'update-exit-data-row',
                builder: (c) => (c.dataRow.length <= 0)
                    ? Container(
                        color: themeBgColor,
                        height: size.height * 0.5,
                        width: size.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          // vertical: size.height * 0.01
                        ),
                        child: Image.asset(
                          'assets/images/NodataTable.png',
                          fit: BoxFit.cover,
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
                          width: smallM2FontSize * 2,
                          height: smallM2FontSize * 2,
                          size: smallM2FontSize,
                          icon: Icons.arrow_back_ios_new,
                          onClick: () => exitController.onClickBackPaging(),
                        ),
                        for (int i = exitController.startPaging.value - 1;
                            i <
                                (exitController.totalPagingNumber.value <
                                        (exitController.startPaging.value +
                                            exitController.pagingRange.value)
                                    ? exitController.totalPagingNumber.value ==
                                            1
                                        ? 1
                                        : exitController.totalPagingNumber.value
                                    : (exitController.startPaging.value +
                                        exitController.pagingRange.value));
                            i++) ...[
                          RoundButtonNumber(
                            width: smallM2FontSize * 2,
                            height: smallM2FontSize * 2,
                            fontSize: smallM2FontSize,
                            index: (i + 1).toString(),
                            selectd:
                                exitController.selectPaging.value == (i + 1)
                                    ? true
                                    : false,
                            onClick: () =>
                                exitController.onClickPaging((i + 1)),
                          ),
                        ],
                        RoundButtonIcon(
                          width: smallM2FontSize * 2,
                          height: smallM2FontSize * 2,
                          size: smallM2FontSize,
                          icon: Icons.arrow_forward_ios,
                          onClick: () => exitController.onClickNextPaging(),
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
