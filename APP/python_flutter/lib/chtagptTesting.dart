import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GPTResponse {
  final String text;

  GPTResponse({required this.text});

  factory GPTResponse.fromJson(Map<String, dynamic> json) {
    return GPTResponse(text: json['choices'][0]['text']);
  }
}

class GPTService {
  static const String apiKey =
      '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';
  static const String apiUrl =
      'https://api.openai.com/v1/engines/davinci-codex/completions';

  static Future<String> generateReason(
      String projectSummary, String sdgs) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt':
            'Given the project summary: "$projectSummary" and the SDGs: "$sdgs", provide a reason why this project aligns with the SDGs.',
        'max_tokens': 50, // Adjust token limit as needed
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final gptResponse = GPTResponse.fromJson(jsonResponse);
      return gptResponse.text;
    } else {
      throw Exception('Failed to generate response');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT-SDG Alignment',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GPT-SDG Alignment'),
        ),
        body: GPTScreen(),
      ),
    );
  }
}

class GPTScreen extends StatefulWidget {
  @override
  _GPTScreenState createState() => _GPTScreenState();
}

class _GPTScreenState extends State<GPTScreen> {
  String generatedReason = '';

  void generateReason(String projectSummary, String sdgs) async {
    try {
      final reason = await GPTService.generateReason(projectSummary, sdgs);
      setState(() {
        generatedReason = reason;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Project Summary/Abstract'),
            onChanged: (value) {
              // Store the project summary input
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'SDGs'),
            onChanged: (value) {
              // Store the SDGs input
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Call the generateReason function with project summary and SDGs inputs
            },
            child: Text('Generate Reason'),
          ),
          SizedBox(height: 16.0),
          Text('Generated Reason:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text(generatedReason, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
