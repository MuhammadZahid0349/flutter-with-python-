import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:python_flutter/function.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  var data;
  String output = 'Initial Output';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Flask App')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              onChanged: (value) {
                url =
                    "http://192.168.0.173:5000//api?query=" + value.toString();
              },
            ),
            TextButton(
                onPressed: () async {
                  try {
                    data = await fetchData(url);
                    var decoded = jsonDecode(data);
                    print("Zahid");
                    setState(() {
                      output = decoded['output'];
                    });
                  } catch (e) {
                    print("Error fetching data: $e");
                    setState(() {
                      output = 'Error fetching data';
                    });
                  }
                },
                child: const Text(
                  'Fetch ASCII Value',
                  style: TextStyle(fontSize: 20),
                )),
            Text(
              output,
              style: TextStyle(fontSize: 40, color: Colors.green),
            ),
          ]),
        ),
      ),
    );
  }
}
