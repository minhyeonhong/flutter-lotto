import 'package:flutter/material.dart';
import 'package:lotto/models/lotto.dart';
import 'package:lotto/services/api_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  final Function(Future<LottoModel>) handleScanResult; // 결과값을 전달할 함수를 매개변수로 받음

  const QRScanScreen({Key? key, required this.handleScanResult})
      : super(key: key);

  @override
  QRScanScreenState createState() => QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Result: ${result!.code}')
                  : const Text('Scan a QR code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (scanData.code == null &&
            scanData.code!.contains("http://qr.645lotto.net")) {
          print("======================여기야=");
          print(scanData.code);
          Future<LottoModel> response =
              ApiService().getQRCodeNo(scanData.code!);
          // QR코드 스캔 결과를 이전 페이지로 전달
          widget.handleScanResult(response);
          // QRScanScreen이 이전 페이지를 호출한 후 종료됨
          Navigator.pop(context);
        } else {
          print("======================여기야=222222");
          print(scanData.code);
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
