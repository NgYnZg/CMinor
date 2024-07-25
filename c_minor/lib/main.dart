// // import 'package:c_minor/scanner.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gsheets/gsheets.dart';

// // // create credentials
// // const _credentials = r'''{
// //   "type": "service_account",
// //   "project_id": "c-minor-429914",
// //   "private_key_id": "0cda3939a54e97f9625021cf267dae59be8fb787",
// //   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCyan4qHuwXsOP0\nNemXVfwC6cql/VEZLj3yjW+YTgZ+EnCwH9x4j1l7p2eev9itC5nJOrFMdCJBuMM8\nWo74sewF4GMLXBMANpIZi8j0/Gbu8YWqZXL+IarhaOrgnEIyEklHYT8H2bUBQ7B3\np2nwXGMv75XuTGRkWg76GEwkecSOkzKZojpx2sC8OVu7Hf2rE5G8D954RPqM1M6U\nme1R9nhsYt84mkjIKlSP664MnJRQpUWFk3PfwENZ0ciyIw/hia/LBWJPxNfi74TQ\n2XIg3UhnE1w4aOZlfd5xOZCudqqyIleZRXrRHKH7Bk5sHaGPHOY8baLak2pPK7mL\n0ssS0y7HAgMBAAECggEAQJ3oDqo/WH80t/Q0ox49lPKGdeKOVh/UyL1nvtH3cP6N\nuIP5jeJhBrNFCI4z08xhSKuMngNrisD3WKr1n+WUdTZkuK8CpK+e70icofmt7/ki\nL2npoVehM10TwABnywmrZ4I1WUsETq5swZEtAaP8Ola7xt/89glV5kcZgJZnVTko\nm8+Ay8yIz4ujNkBZBfqY8VLr1LOdmZv/4VTORSRNZIBK/dYlOX0cvk2fTxzNFSxL\nY8BljiT7Uar8vt9PiNhkmp51MmoEo4rZtHkSz4hlAbAwfnnnJNcHKKnO02uT0SdR\nMJgXL+IN8QvfnN6FvZVEoepJkhs38ZlMQs4a6SfocQKBgQDbqGX4Z1t9qtdeSYES\n3wRXCM1dBZDpoHzAqUApf+2Rl1Z02FxIYyHyJoPZIwU3yD3jvj89CiK8CEt61q3l\nv4IpyH9qnMmJYX2hgkd2LJYV75ZodeupKElIXGUkiOMNVdS/ORRBn8N+Qdhh+f/S\nbseHe+X0MOd6b2h+A7ITXDJ69wKBgQDP70xVKRYy7S6DZrwv1lCyxWGF7vryA80p\n7mKAB08i/vxtEiiqxxSUkh312rYgBVhCjHKZYEHwMKF+0dd97I41Vt7zQGIQtDJB\niWAXuG1OsQxhseLQ6Xb13vpcVS365UXEQJOtFWZ47C5HH1zswid0K4+kZAVb/B18\nxbbybVCmsQKBgE/DSLP5JDnv7aDpZBtsLHFGWvxqZwLPKj3zt77aG3SA1f48Ctam\nWM9LuRkCJITrC75FeUU7Bv3srSwABMmmzydJDSuzn2NpqWsamcSJ0D5K7/0ixN56\nKJJEKt4nbvuKrWR636Ys05pnYqHBXGoXnBDQpuITWBsXlYQc528sTZBlAoGAdJpd\ntNfQgghtb/RZjX3iTQ3QrXmhMbwd/eiXRfJTV22kAkoPkg0HpnT15huazAQTRWZb\nEVVgRKAQv/xOmmfgK1smtUQiefmCwSuXPlYGvf0c02AcsEhrlF9RCBwgJ7UQVYhd\nB8+bYi4XmXyl8ILD+yo+Z9JLCxUrN//rorDYbFECgYA3DaZa7M1/1OPF9sRIF8Wp\nYs7tH64QgdTiGBTwYZBOzqc8f4sTS3+XS642kZQgrwbg1Gt72KDGOxIjTPs++iog\nTx9enb7e18hkqTyMtxvl4p60p0c23rG7YYc7ay2cRiB+IE4ofE/tS7t7Zxc6Q/oN\n1A14Ws5UvuvcUraWOcurjA==\n-----END PRIVATE KEY-----\n",
// //   "client_email": "c-minor@c-minor-429914.iam.gserviceaccount.com",
// //   "client_id": "111073505508377276110",
// //   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
// //   "token_uri": "https://oauth2.googleapis.com/token",
// //   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
// //   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/c-minor%40c-minor-429914.iam.gserviceaccount.com",
// //   "universe_domain": "googleapis.com"
// // }
// // ''';

// // const _spreadsheetid = '1XXt4misyXWJPn7awuImlkKsNN9ev95I5_myiE9fYl5g';

// // void main() async {
// //   //int Gsheets
// //   final gsheets = GSheets(_credentials);

// //   //fetch sreadsheet by its id
// //   final ss = await gsheets.spreadsheet(_spreadsheetid);
// //   //get worksheet by its name

// //   var sheet = ss.worksheetByTitle('Sheet1');

// //   //update cell
// //   await sheet!.values.insertValue('wl', column: 1, row: 1);
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         title: 'Flutter Demo',
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //         ),
// //         home: Scanner());
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/sheets/v4.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

// void main() {
//   runApp(QRCodeScannerApp());
// }

// class QRCodeScannerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: QRCodeScannerPage(),
//     );
//   }
// }

// class QRCodeScannerPage extends StatefulWidget {
//   @override
//   _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
// }

// class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
//   MobileScannerController controller = MobileScannerController();
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'https://www.googleapis.com/auth/spreadsheets',
//     ],
//   );

//   @override
//   void initState() {
//     super.initState();
//     _handleSignIn();
//   }

//   // void _onQRCodeScanned(BarcodeCapture capture) async {
//   //   final String spreadSheetId = '10llTHTmMypNksFBq_836J4thTp0duIQWYAQa3SAU0tU';
//   //   final barcode = capture.barcodes.first;
//   //   if (barcode.rawValue != null) {
//   //     String qrCodeValue = barcode.rawValue!;
//   //     print('testing 1');
//   //     print(qrCodeValue.toString());
//   //     print("testing2");

//   //     //  await _fetchGoogleSheetData(spreadSheetId, 'Sheet1!A19:A20');
//   //     final user = _googleSignIn.currentUser;
//   //     final client = await getAuthenticatedClient(user);

//   //     final sheetsApi = SheetsApi(client);
//   //     final response = await sheetsApi.spreadsheets.values
//   //         .get(spreadSheetId, 'Sheet1!A19:A20');
//   //     print(response.values);
//   //   } else {
//   //     print('testing 3');
//   //   }
//   // }
//   bool _isLoading = false; // State variable to track loading
//   final String spreadSheetId = '10llTHTmMypNksFBq_836J4thTp0duIQWYAQa3SAU0tU';
//   void _onQRCodeScanned(BarcodeCapture capture) async {
//     final barcode = capture.barcodes.first;
//     if (barcode.rawValue != null) {
//       String qrCodeValue = barcode.rawValue!;
//       print('testing 1');
//       print(qrCodeValue.toString());
//       print("testing2");

//       setState(() {
//         _isLoading = true; // Show spinner
//       });

//       try {
//         final user = _googleSignIn.currentUser;
//         final client = await getAuthenticatedClient(user);

//         final sheetsApi = SheetsApi(client);
//         final response = await sheetsApi.spreadsheets.values
//             .get(spreadSheetId, 'Sheet1!A19:A20');
//         print(response.values);
//       } catch (error) {
//         print('Error fetching data: $error');
//       } finally {
//         setState(() {
//           _isLoading = false; // Hide spinner
//         });
//       }
//     } else {
//       print('testing 3');
//     }

//     try {
//       final String spreadSheetId = 'your-spreadsheet-id';
//       final String range = 'Sheet1!A1:B2'; // Adjust the range as needed
//       final List<List<Object>> values = [
//         ['Hello', 'World'],
//         ['Foo', 'Bar'],
//       ];
//       final user = _googleSignIn.currentUser;
//       final client = await getAuthenticatedClient(user);
//       final updateRequest = ValueRange(
//         range: range,
//         majorDimension: 'ROWS', // 'ROWS' or 'COLUMNS'
//         values: values,
//       );
//       final sheetsApi = SheetsApi(client);
//       final response = await sheetsApi.spreadsheets.values.update(
//         updateRequest,
//         spreadSheetId,
//         range,
//         valueInputOption: 'RAW', // or 'USER_ENTERED'
//       );
//       print('Update successful: ${response.updatedCells} cells updated.');
//     } catch (error) {
//       print('Error updating data: $error');
//     }
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print('handleSignIn error: $error');
//     }
//   }

//   Future<http.Client> getAuthenticatedClient(GoogleSignInAccount? user) async {
//     final authHeaders = await user?.authHeaders;
//     final authClient = http.Client();

//     final jsonString = await rootBundle.loadString('assets/credentials.json');
//     final Map<String, dynamic> credentials = json.decode(jsonString);

//     return authenticatedClient(
//       authClient,
//       AccessCredentials(
//         AccessToken(
//           'Bearer',
//           authHeaders?['Authorization']?.split(" ").last ?? '',
//           DateTime.now().toUtc().add(Duration(hours: 1)),
//         ),
//         null,
//         ['https://www.googleapis.com/auth/spreadsheets'],
//       ),
//     );
//   }

//   // Future<void> _fetchGoogleSheetData(String spreadsheetId, String range) async {
//   //   final user = _googleSignIn.currentUser;
//   //   final client = await getAuthenticatedClient(user);

//   //   final sheetsApi = SheetsApi(client);
//   //   final response =
//   //       await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
//   //   print(response.values);

//   //   //edit
//   //   await sheetsApi.values.set(key, value)
//   // }

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
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(QRCodeScannerApp());
}

class QRCodeScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRCodeScannerPage(),
    );
  }
}

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  MobileScannerController controller = MobileScannerController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive.file', // Add this if you need to access Google Drive
    ],
  );

  bool _isLoading = false; // State variable to track loading
  bool _isSignedIn = false; // State variable to track sign-in status
  final String spreadSheetId = '10llTHTmMypNksFBq_836J4thTp0duIQWYAQa3SAU0tU';

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    final user = _googleSignIn.currentUser;
    setState(() {
      _isSignedIn = user != null;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Sign-in error: $error');
      _showDialog('Sign-in Error', 'Error during sign-in: $error');
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      _checkSignInStatus();
      _showDialog('Sign Out', 'User signed out');
    } catch (error) {
      _showDialog('Sign Out Error', 'handleSignOut error: $error');
    }
  }

  Future<http.Client> getAuthenticatedClient(GoogleSignInAccount? user) async {
    final authHeaders = await user?.authHeaders;
    final authClient = http.Client();

    final jsonString = await rootBundle.loadString('assets/credentials.json');
    final Map<String, dynamic> credentials = json.decode(jsonString);

    return authenticatedClient(
      authClient,
      AccessCredentials(
        AccessToken(
          'Bearer',
          authHeaders?['Authorization']?.split(" ").last ?? '',
          DateTime.now().toUtc().add(Duration(hours: 1)),
        ),
        null,
        ['https://www.googleapis.com/auth/spreadsheets'],
      ),
    );
  }

  Future<void> _onQRCodeScanned(BarcodeCapture capture) async {
    final barcode = capture.barcodes.first;
    if (barcode.rawValue != null) {
      String qrCodeValue = barcode.rawValue!;
      _showDialog('QR Code Scanned', 'QR Code Value: $qrCodeValue');
      setState(() {
        _isLoading = true; // Show spinner
      });

      try {
        final user = _googleSignIn.currentUser;
        final client = await getAuthenticatedClient(user);

        final sheetsApi = SheetsApi(client);
        final response = await sheetsApi.spreadsheets.values
            .get(spreadSheetId, 'Sheet1!A19:A20');
        _showDialog('Fetch Data', 'Response Values: ${response.values}');
      } catch (error) {
        _showDialog('Fetch Data Error', 'Error fetching data: $error');
      } finally {
        setState(() {
          _isLoading = false; // Hide spinner
        });
      }

      try {
        final String spreadSheetId = 'your-spreadsheet-id';
        final String range = 'Sheet1!A1:B2'; // Adjust the range as needed
        final List<List<Object>> values = [
          ['Hello', 'World'],
          ['Foo', 'Bar'],
        ];
        final user = _googleSignIn.currentUser;
        final client = await getAuthenticatedClient(user);
        final updateRequest = ValueRange(
          range: range,
          majorDimension: 'ROWS', // 'ROWS' or 'COLUMNS'
          values: values,
        );
        final sheetsApi = SheetsApi(client);
        final response = await sheetsApi.spreadsheets.values.update(
          updateRequest,
          spreadSheetId,
          range,
          valueInputOption: 'RAW', // or 'USER_ENTERED'
        );
        _showDialog('Update Successful',
            'Update successful: ${response.updatedCells} cells updated.');
      } catch (error) {
        print('Error updating data: $error');
        _showDialog('Update Data Error', 'Error updating data: $error');
      }
    } else {
      _showDialog('QR Code Error', 'QR Code value is null');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onQRCodeScanned,
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Spinner
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _isSignedIn ? 'Signed In' : 'Signed Out',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 16), // Space between text and button
          FloatingActionButton(
            onPressed: _isSignedIn ? _handleSignOut : _handleSignIn,
            child: Icon(_isSignedIn ? Icons.logout : Icons.login),
            tooltip: _isSignedIn ? 'Sign Out' : 'Sign In',
          ),
        ],
      ),
    );
  }
}
