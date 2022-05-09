import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDateRangePicker(
        enableMultiView: true,
        viewSpacing: 20,
        headerStyle: DateRangePickerHeaderStyle(textAlign: TextAlign.center),
      ),
    );
  }
}
