// import 'package:c_minor/gptCode/google_sheets_api.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class QRScanPage extends StatefulWidget {
//   final String clientId;
//   final String clientSecret;

//   QRScanPage({required this.clientId, required this.clientSecret});

//   @override
//   _QRScanPageState createState() => _QRScanPageState();
// }

// class _QRScanPageState extends State<QRScanPage> {
//   GoogleSheetsApi? _sheetsApi;
//   final TextEditingController _sheetIdController = TextEditingController();
//   String? _spreadsheetId;

//   @override
//   void initState() {
//     super.initState();
//     _loadSpreadsheetId();
//   }

//   Future<void> _loadSpreadsheetId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _spreadsheetId = prefs.getString('spreadsheetId');
//       _sheetIdController.text = _spreadsheetId ?? '';
//       if (_spreadsheetId != null) {
//         _initializeGoogleSheetsApi();
//       }
//     });
//   }

//   Future<void> _initializeGoogleSheetsApi() async {
//     if (_spreadsheetId != null) {
//       try {
//         _sheetsApi = await GoogleSheetsApi.create(
//           _spreadsheetId!, // The spreadsheet ID
//           widget.clientId, // The client ID
//           widget.clientSecret, // The client secret
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to initialize Google Sheets API: $e')),
//         );
//       }
//     }
//   }

//   void _onQRCodeScanned(BarcodeCapture barcodeCapture) async {
//     if (barcodeCapture.barcodes.isNotEmpty && _sheetsApi != null) {
//       final String code = barcodeCapture.barcodes.first.rawValue ?? "";
//       try {
//         final cellValue = await _sheetsApi!.readCell('Sheet1', code);
//         await _sheetsApi!.updateCell('Sheet1', code, 'New Value');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('QR Code: $code\nValue: $cellValue')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update Google Sheet: $e')),
//         );
//       }
//     }
//   }

//   Future<void> _setSpreadsheetId() async {
//     String sheetId = _sheetIdController.text;
//     if (sheetId != null) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('spreadsheetId', sheetId);
//       setState(() {
//         _spreadsheetId = sheetId;
//         _initializeGoogleSheetsApi();
//       });
//     } else {
//       print('_setSpreadsheetud');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('QR Code Scanner')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _sheetIdController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Enter Google Sheet ID',
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _setSpreadsheetId,
//             child: Text('Set Sheet ID'),
//           ),
//           Expanded(
//             child: MobileScanner(
//               onDetect: _onQRCodeScanned,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
