import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormSlip extends StatelessWidget {
  const FormSlip({
    Key? key,
    required this.globalKey,
    required this.homeAddress,
    this.onDate,
    this.onTime,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> globalKey;
  final homeAddress;
  final onDate;
  final onTime;
  // final onDate = new DateFormat('dd/MM/yy');
  //   final onTime = new DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
          width: 350,
          color: Colors.white,
          child:
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [Text('ทดสอบ'), Text('data')],
              // ),
              Column(
            children: [
              Text(
                'บ้านเลขที่ ${homeAddress}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                  'วันที่ : ${onDate.format(DateTime.now())} เวลา : ${onTime.format(DateTime.now())}',
                  style: TextStyle(fontSize: 20))
            ],
          )),
    );
  }
}

class FormSlip2 extends StatelessWidget {
  const FormSlip2({
    Key? key,
    required this.globalKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> globalKey;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
          width: 350,
          color: Colors.white,
          child:
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [Text('ทดสอบ'), Text('data')],
              // ),
              Column(
            children: [
              Text(
                'แสกน QR นี้เพื่อแสกนเข้าโครงการ',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
    );
  }
}

class FormSlip3 extends StatelessWidget {
  const FormSlip3({
    Key? key,
    required this.globalKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> globalKey;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
          width: 350,
          color: Colors.white,
          child:
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [Text('ทดสอบ'), Text('data')],
              // ),
              Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'หมายเหตุ',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                  '1. หากมีการชำระเงินต้องทำการชำระเงินผ่าน Mobile Payment ให้เรียบร้อยก่อนออกจากโครงการ',
                  style: TextStyle(fontSize: 20)),
              Text(
                  '2. หากไม่ได้ E-Stamp ก่อนออกจากโครงการ ให้ติดต่อลูกบ้านหรือนิติบุคคลเพื่อทำการ E-Stamp',
                  style: TextStyle(fontSize: 20)),
            ],
          )),
    );
  }
}
