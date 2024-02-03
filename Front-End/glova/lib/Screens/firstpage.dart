import 'package:flutter/material.dart';
import 'package:glova/Screens/login.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/firstPageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login_Page()), // Corrected class name
              );
            },
            child: const Text('Continue'), // Updated button text
          ),
        ),
      ),
    );
  }
}
