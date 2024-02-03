import 'package:flutter/material.dart';
import 'package:glova/Screens/login.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login_page()),
            );
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}