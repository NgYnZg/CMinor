// import 'package:c_minor/QRscannerOverlay.dart';
// import 'package:c_minor/foundScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class Scanner extends StatefulWidget {
//   const Scanner({Key? key}) : super(key: key);

//   @override
//   State<Scanner> createState() => _ScannerState();
// }

// class _ScannerState extends State<Scanner> {
//   MobileScannerController cameraController = MobileScannerController();
//   bool _screenOpened = false;

//   @override
//   void initState() {
//     super.initState();
//     _screenWasClosed();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black.withOpacity(0.5),
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: Text(
//           "Scanner",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         elevation: 0.0,
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: cameraController,
//             onDetect: _foundBarcode,
//           ),
//           QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
//         ],
//       ),
//     );
//   }

//   void _foundBarcode(BarcodeCapture barcodeCapture) {
//     if (!_screenOpened) {
//       final String code = barcodeCapture.barcodes.first.rawValue ?? "___";
//       _screenOpened =
//           true; // Set _screenOpened to true to prevent re-triggering
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FoundScreen(
//             value: code,
//             screenClose: _screenWasClosed,
//           ),
//         ),
//       ).then((value) {
//         _screenWasClosed(); // Reset _screenOpened when returning to this screen
//       });
//     }
//   }

//   void _screenWasClosed() {
//     setState(() {
//       _screenOpened = false;
//     });
//   }
// }
