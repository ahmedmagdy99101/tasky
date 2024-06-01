import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';

class QRScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture barcode){
      if (barcode.raw != null) {
            final String code = barcode.raw.toString()!;
            context.go('/todo/$code');
          }
        },
        // onDetect: (barcode, args) {
        //   if (barcode.rawValue != null) {
        //     final String code = barcode.rawValue!;
        //     context.go('/todo/$code');
        //   }
        // },
      ),
    );
  }
}
