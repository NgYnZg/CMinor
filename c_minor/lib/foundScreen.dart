// import 'package:flutter/material.dart';
// import 'package:googleapis/sheets/v4.dart' as sheets;

// class FoundScreen extends StatefulWidget {
//   final String value;
//   final Function() screenClose;
//   final sheets.SheetsApi sheetsApi;

//   const FoundScreen({
//     Key? key,
//     required this.value,
//     required this.screenClose,
//     required this.sheetsApi, // Add this line
//   }) : super(key: key);

//   @override
//   State<FoundScreen> createState() => _FoundScreenState();
// }

// class _FoundScreenState extends State<FoundScreen> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller.text = widget.value;
//   }

//   Future<void> _updateSheet() async {
//     try {
//       final update = sheets.ValueRange.fromJson({
//         'range': 'Sheet1!A1',
//         'values': [
//           [_controller.text],
//         ],
//       });
//       await widget.sheetsApi.spreadsheets.values.update(
//         update,
//         '10llTHTmMypNksFBq_836J4thTp0duIQWYAQa3SAU0tU',
//         'Sheet1!A1',
//         valueInputOption: 'RAW',
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sheet updated successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update sheet: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
//               onPressed: () {
//                 widget.screenClose();
//                 Navigator.pop(context, false);
//               },
//             );
//           },
//         ),
//         title: const Text(
//           "Result",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Result: ",
//                 style: TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 widget.value.isNotEmpty ? widget.value : 'No result available',
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const Text(
//                 "Edit Result:",
//                 style: TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Result',
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _controller.text = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _updateSheet,
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
