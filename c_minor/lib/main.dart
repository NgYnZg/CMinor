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
    final user = await _googleSignIn.signInSilently();
    setState(() {
      _isSignedIn = user != null;
    });
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await _googleSignIn.signIn();
      if (user == null) {
        _showDialog('Sign-in Error', 'User canceled sign-in');
      } else {
        setState(() {
          _isSignedIn = true;
        });
      }
    } catch (error) {
      _showDialog('Sign-in Error', 'Error during sign-in: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSignOut() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _googleSignIn.signOut();
      setState(() {
        _isSignedIn = false;
      });
      _showDialog('Sign Out', 'User signed out');
    } catch (error) {
      _showDialog('Sign Out Error', 'Error during sign-out: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<http.Client> getAuthenticatedClient(GoogleSignInAccount? user) async {
    if (user == null) {
      throw Exception('User is not signed in');
    }
    final authHeaders = await user.authHeaders;
    final authClient = http.Client();

    final jsonString = await rootBundle.loadString('assets/credentials.json');
    final Map<String, dynamic> credentials = json.decode(jsonString);

    return authenticatedClient(
      authClient,
      AccessCredentials(
        AccessToken(
          'Bearer',
          authHeaders['Authorization']?.split(" ").last ?? '',
          DateTime.now().toUtc().add(const Duration(hours: 1)),
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
              child: const Text('OK'),
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
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onQRCodeScanned,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(), // Spinner
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _isSignedIn ? 'Signed In' : 'Signed Out',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16), // Space between text and button
          FloatingActionButton(
            onPressed: _isSignedIn ? _handleSignOut : _handleSignIn,
            tooltip: _isSignedIn ? 'Sign Out' : 'Sign In',
            child: Icon(_isSignedIn ? Icons.logout : Icons.login),
          ),
        ],
      ),
    );
  }
}
