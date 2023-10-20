// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SDG Predictor',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _textFieldController = TextEditingController();
//   String _predictedLabels = "";

//   Future<void> _predictSDG() async {
//     final response = await http.post(
//       Uri.parse(
//           "https://1019-34-124-131-151.ngrok-free.app/predict"), // Replace with your ngrok URL
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'text': _textFieldController.text,
//       }),
//     );

//     if (response.statusCode == 200) {
//       Map<String, dynamic> responseData = json.decode(response.body);
//       List<dynamic> predictedLabels = responseData['predicted_labels'];

//       setState(() {
//         _predictedLabels = predictedLabels.join(", ");
//       });
//     } else {
//       // Handle error
//       print("Error: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SDG Predictor"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 height: 350,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: TextField(
//                   maxLines: 500,
//                   style: TextStyle(
//                     fontSize: 18,
//                     // fontFamily: "ES",
//                     color: Colors.black,
//                   ),
//                   controller: _textFieldController,
//                   decoration: const InputDecoration(
//                     isDense: true,
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _predictSDG,
//                 child: Text("Predict"),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Predicted Labels: $_predictedLabels",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
