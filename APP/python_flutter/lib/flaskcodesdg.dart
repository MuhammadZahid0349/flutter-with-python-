import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlaskSDGCode extends StatefulWidget {
  const FlaskSDGCode({super.key});

  @override
  State<FlaskSDGCode> createState() => _FlaskSDGCodeState();
}

class _FlaskSDGCodeState extends State<FlaskSDGCode> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _predictedSDGs = [];

  void _clearFields() {
    _textEditingController.clear();
    setState(() {
      _predictedSDGs = [];
    });
  }

  void _getPredictedSDGs(String text) async {
    var apiUrl =
        'http://192.168.0.173:5000/api'; // Replace with your Flask server IP

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _predictedSDGs = List<String>.from(data['predicted_labels']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SDG Predictor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  maxLines: 500,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    // fontFamily: "ES",
                    color: Colors.black,
                  ),
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String inputText = _textEditingController.text;
                    _getPredictedSDGs(inputText);
                  },
                  child: Text('Predict SDGs'),
                ),
                ElevatedButton(
                  onPressed: _clearFields, // Call the clear function
                  child: Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Customize button color
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: _predictedSDGs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_predictedSDGs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
