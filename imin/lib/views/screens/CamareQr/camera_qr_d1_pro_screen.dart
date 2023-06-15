import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imin/controllers/camera_qr_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraQrD1ProScreen extends StatefulWidget {
  const CameraQrD1ProScreen({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  State<CameraQrD1ProScreen> createState() => _CameraQrD1ProScreenState();
}

class _CameraQrD1ProScreenState extends State<CameraQrD1ProScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final scanQrController = Get.put(ScanQrController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: widget.size.width * 0.95,
          height: widget.size.height,
          // child: CameraPreview(c.controller),
          child: _buildQrView(context),
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
      onQRViewCreated: scanQrController.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

}
