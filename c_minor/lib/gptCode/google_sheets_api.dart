// import 'dart:math';

// import 'package:crypto/crypto.dart';
// import 'package:googleapis/sheets/v4.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class GoogleSheetsApi {
//   static const _scopes = [SheetsApi.spreadsheetsScope];
//   final SheetsApi _sheetsApi;
//   final String _spreadsheetId;

//   GoogleSheetsApi._(this._sheetsApi, this._spreadsheetId);

//   static Future<GoogleSheetsApi> create(
//     String spreadsheetId,
//     String clientId,
//     String clientSecret,
//   ) async {
//     final clientIdObject = ClientId(clientId, clientSecret);

//     // Generate a unique state for security
//     final state = Uri.encodeComponent(DateTime.now().toIso8601String());

//     // Generate a code verifier
//     final codeVerifier = createCodeVerifier();
//     final codeChallenge = _codeVerifierShaEncode(codeVerifier);

//     // Construct the authorization URL
//     final authUrl = Uri.parse(
//       'https://accounts.google.com/o/oauth2/auth'
//       '?client_id=${clientIdObject.identifier}'
//       '&redirect_uri=com.example.c_minor:/oauth2redirect'
//       '&response_type=code'
//       '&scope=${_scopes.join(' ')}'
//       '&code_challenge=$codeChallenge'
//       '&code_challenge_method=S256'
//       '&state=$state'
//       '&access_type=offline',
//     );

//     final result = await FlutterWebAuth.authenticate(
//       url: authUrl.toString(),
//       callbackUrlScheme: "com.example.c_minor",
//     );

//     final code = Uri.parse(result).queryParameters['code'];
//     if (code == null) {
//       throw Exception("Authorization code not found");
//     }

//     final client = http.Client();
//     final credentials = await obtainAccessCredentialsViaCodeExchange(
//       client,
//       clientIdObject,
//       code,
//       redirectUrl: 'com.example.c_minor:/oauth2redirect',
//       codeVerifier: codeVerifier,
//     );

//     client.close(); // Close the client after usage

//     final authClient = authenticatedClient(
//       http.Client(),
//       credentials,
//     );

//     final sheetsApi = SheetsApi(authClient);
//     return GoogleSheetsApi._(sheetsApi, spreadsheetId);
//   }

//   Future<void> updateCell(String sheetName, String cell, String value) async {
//     final range = '$sheetName!$cell';
//     final valueRange = ValueRange.fromJson({
//       'range': range,
//       'values': [
//         [value]
//       ],
//     });
//     await _sheetsApi.spreadsheets.values.update(
//       valueRange,
//       _spreadsheetId,
//       range,
//       valueInputOption: 'RAW',
//     );
//   }

//   Future<String> readCell(String sheetName, String cell) async {
//     if (_spreadsheetId == null) {
//       throw ArgumentError('Spreadsheet ID cannot be null');
//     }
//     if (sheetName.isEmpty || cell.isEmpty) {
//       throw ArgumentError('Sheet name and cell cannot be empty');
//     }

//     final range = '$sheetName!$cell';
//     try {
//       final response =
//           await _sheetsApi.spreadsheets.values.get(_spreadsheetId, range);
//       final value = response.values?.first.first; // Access the cell value

//       // Ensure the value is a String, or return an empty string if null or not a String
//       if (value is String) {
//         return value;
//       } else {
//         return ''; // Return a default value if the value is not a String
//       }
//     } catch (e) {
//       print('Failed to read cell: $e');
//       return ''; // Handle exception and return default value
//     }
//   }

//   // Helper method to create a code verifier
//   static String createCodeVerifier() {
//     final rnd = Random.secure();
//     return List.generate(128, (index) => _safe[rnd.nextInt(_safe.length)])
//         .join();
//   }

//   // Helper method to encode code verifier
//   static String _codeVerifierShaEncode(String codeVerifier) {
//     final asciiBytes = ascii.encode(codeVerifier);
//     final sha26Bytes = sha256.convert(asciiBytes).bytes;
//     final output = base64UrlEncode(sha26Bytes);
//     return _stripBase64Equals(output);
//   }

//   // Helper method to strip trailing '=' characters from Base64 encoded strings
//   static String _stripBase64Equals(String value) {
//     while (value.endsWith('=')) {
//       value = value.substring(0, value.length - 1);
//     }
//     return value;
//   }

//   // Safe characters for code verifier
//   static const _safe = '0123456789-._~'
//       'abcdefghijklmnopqrstuvwxyz'
//       'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
// }
