// import 'package:c_minor/gptCode/screens/qr_scan_page..dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

// Future<Map<String, dynamic>> loadCredentials() async {
//   final String response =
//       await rootBundle.loadString('assets/credentials.json');
//   final data = json.decode(response) as Map<String, dynamic>;
//   return data['installed'] as Map<String, dynamic>;
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   Future<Map<String, dynamic>> loadCredentials() async {
//     final String response =
//         await rootBundle.loadString('assets/credentials.json');
//     final data = json.decode(response) as Map<String, dynamic>;
//     return data['installed'] as Map<String, dynamic>;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'QR Code Scanner',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder<Map<String, dynamic>>(
//         future: loadCredentials(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (snapshot.hasError) {
//             return Scaffold(
//               body: Center(child: Text('Error loading credentials')),
//             );
//           } else {
//             final credentials = snapshot.data!;
//             return QRScanPage(
//               clientId: credentials['client_id'],
//               clientSecret: credentials['client_secret'],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
