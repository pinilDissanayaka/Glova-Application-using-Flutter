import 'dart:convert';

import 'package:glova/Function/function.dart';
import 'package:flutter/material.dart';

class ApiTest extends StatefulWidget {
  const ApiTest({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ApiTest> {
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
                url = 'http://127.0.0.1:5000/api?query=' + value.toString();
              },
            ),
            TextButton(
                onPressed: () async {
                  // try {
                  //   data = await fetchdata(url);
                  //   var decoded = jsonDecode(data);
                  //   setState(() {
                  //     output = decoded['output'];
                  //   });
                  // } catch (e) {
                  //   print('Error fetching data: $e');
                  // }
                  data = await fetchdata(url);
                  var decoded = jsonDecode(data);
                  setState(() {
                    output = decoded['output'];
                  });
                },
                child: Text(
                  'Fetch ASCII Value',
                  style: TextStyle(fontSize: 20),
                )),
            Text(
              output,
              style: TextStyle(fontSize: 40, color: Colors.green),
            )
          ]),
        ),
      ),
    );
  }
}