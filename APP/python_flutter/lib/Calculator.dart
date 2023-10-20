import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = '';

  void calculateSum() async {
    final response = await http.post(
      Uri.parse(
          'https://32e5-35-226-186-63.ngrok-free.app/'), // Replace with your ngrok URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "num1": int.parse(num1Controller.text),
        "num2": int.parse(num2Controller.text),
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        result = data['result'].toString();
      });
    } else {
      setState(() {
        result = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number 1'),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateSum,
              child: Text('Calculate Sum'),
            ),
            SizedBox(height: 20),
            Text('Result: $result'),
          ],
        ),
      ),
    );
  }
}
