// import 'dart:async';
//
// import 'package:Alegny_provider/src/core/constants/app_assets.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//
// Future<void> startBarcodeScanStream() async {
//   FlutterBarcodeScanner.getBarcodeStreamReceiver(
//           '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
//       .listen((barcode) => print(barcode));
// }
//
// Future<String> scanQR(Function(String barcodeScanRes) onSuccess) async {
//   String barcodeScanRes;
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.QR);
//     print(barcodeScanRes);
//   } on PlatformException {
//     barcodeScanRes = 'Failed to get platform version.';
//   }
//
//   // If the widget was removed from the tree while the asynchronous platform
//   // message was in flight, we want to discard the reply rather than calling
//   // setState to update our non-existent appearance.
//   return barcodeScanRes;
// }
//
// // Platform messages are asynchronous, so we initialize in an async method.
// Future<String> scanBarcodeNormal() async {
//   String barcodeScanRes;
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
//     printDM("barcodeScanRes is => $barcodeScanRes");
//   } on PlatformException {
//     barcodeScanRes = 'Failed to get platform version.';
//   }
//
//   // If the widget was removed from the tree while the asynchronous platform
//   // message was in flight, we want to discard the reply rather than calling
//   // setState to update our non-existent appearance.
//   return barcodeScanRes;
// }
