// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/sheets/v4.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;

// class QRCodeScannerPage extends StatefulWidget {
//   @override
//   _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
// }

// class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
//   MobileScannerController controller = MobileScannerController();
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'https://www.googleapis.com/auth/spreadsheets.readonly',
//     ],
//   );

//   void _onQRCodeScanned(BarcodeCapture capture) async {
//     final barcode = capture.barcodes.first;
//     if (barcode.rawValue != null) {
//       String qrCodeValue = barcode.rawValue!;
//       await _handleSignIn();
//       await _fetchGoogleSheetData(qrCodeValue, 'Sheet1!A1:E10');
//     }
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<http.Client> getAuthenticatedClient(GoogleSignInAccount? user) async {
//     final authHeaders = await user?.authHeaders;
//     final authClient = http.Client();

//     return authenticatedClient(
//       authClient,
//       AccessCredentials(
//         AccessToken(
//           'Bearer',
//           authHeaders!['Authorization']!.split(" ").last,
//           DateTime.now().add(Duration(hours: 1)),
//         ),
//         null,
//         ['https://www.googleapis.com/auth/spreadsheets.readonly'],
//       ),
//     );
//   }

//   Future<void> _fetchGoogleSheetData(String spreadsheetId, String range) async {
//     final user = _googleSignIn.currentUser;
//     final client = await getAuthenticatedClient(user);

//     final sheetsApi = SheetsApi(client);
//     final response =
//         await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
//     print(response.values);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('QR Code Scanner')),
//       body: MobileScanner(
//         controller: controller,
//         onDetect: _onQRCodeScanned,
//       ),
//     );
//   }
// }
