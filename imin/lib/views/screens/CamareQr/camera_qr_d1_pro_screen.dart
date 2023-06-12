import 'dart:developer';

import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imin/helpers/constance.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraQrD1ProScreen extends StatefulWidget {
  const CameraQrD1ProScreen({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  State<CameraQrD1ProScreen> createState() => _CameraQrD1ProScreenState();
}

class _CameraQrD1ProScreenState extends State<CameraQrD1ProScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrReaderController;
  Barcode? resultQrReader;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: widget.size.width * 0.95,
          height: widget.size.height,
          // child: CameraPreview(c.controller),
          child:
              // showDialogCard('item').show(context),
              _buildQrView(context),
        ),
        // Container(
        //   height: widget.size.height,
        //   width: widget.size.width * 0.1,
        //   color: Colors.black87,
        //   child: Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: MaterialButton(
        //       color: purpleBlueColor,
        //       // padding: EdgeInsets.all(20),
        //       shape: CircleBorder(),
        //       child: Icon(
        //         Icons.camera_alt,
        //         size: 40,
        //         color: Colors.white,
        //       ),
        //       onPressed: () async {
        //         // c.takePicture(uploadController.selectedValue.value);
        //         // cameraController.stopCamera();
        //       },
        //     ),
        //   ),
        // ),
      ],
    );

    // showDialogCard([]).show(context);
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

  ////////// dialog detail when clck
  EasyDialog showDialogCard(dynamic item) {
    return EasyDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      // width: 400,
      // height: (item.listStatus == 'visitor')
      //     ? (item.datetimeIn != null)
      //         ? (item.datetimeOut != null)
      //             ? 440
      //             : 440
      //         : 490
      //     : (item.listStatus == 'whitelist')
      //         ? (item.datetimeIn != null)
      //             ? (item.datetimeOut != null)
      //                 ? 490
      //                 : 440
      //             : 490
      //         : 440,
      width: widget.size.width,
      height: widget.size.height,
      closeButton: false,
      contentList: [
        // Row(
        //   children: [
        //     Container(
        //       width: widget.size.width * 0.9,
        //       height: widget.size.height,
        //       // child: CameraPreview(c.controller),
        //       child:
        //           // showDialogCard('item').show(context),
        //           _buildQrView(context),
        //     ),
        //     Container(
        //       height: widget.size.height,
        //       width: widget.size.width * 0.1,
        //       color: Colors.black87,
        //       child: Padding(
        //         padding: const EdgeInsets.all(15),
        //         child: MaterialButton(
        //           color: purpleBlueColor,
        //           // padding: EdgeInsets.all(20),
        //           shape: CircleBorder(),
        //           child: Icon(
        //             Icons.camera_alt,
        //             size: 40,
        //             color: Colors.white,
        //           ),
        //           onPressed: () async {
        //             // c.takePicture(uploadController.selectedValue.value);
        //             // cameraController.stopCamera();
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // )

        Text(
          'แสกน QR Code',
          style: TextStyle(
            color: textColorContrast,
            fontSize: 18,
            fontFamily: fontRegular,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
