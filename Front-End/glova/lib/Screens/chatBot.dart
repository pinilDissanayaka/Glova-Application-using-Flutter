import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBots extends StatefulWidget {
  const ChatBots({Key? key}) : super(key: key);

  @override
  ChatBot createState() => ChatBot();
}

class ChatBot extends State<ChatBots> {
  String url = 'http://10.0.2.2:5000/chat-bot'; // Default URL
  var data;
  String output = 'Initial Output';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Bot')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  url = 'http://127.0.0.1:5000/$value';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Make a GET request to the Flask backend
                    final response = await http.get(Uri.parse(url));

                    if (response.statusCode == 200) {
                      // Decode the JSON response
                      // var decoded = jsonDecode(response.body);

                      setState(() {
                        output = response.body;
                      });
                    } else {
                      print('Error: ${response.statusCode}');
                    }
                  } catch (e) {
                    print('Error fetching data: $e');
                    output = '$e';
                  }
                },
                child: const Text(
                  'get return value',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Text(
                output,
                style: const TextStyle(fontSize: 40, color: Colors.blueAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
