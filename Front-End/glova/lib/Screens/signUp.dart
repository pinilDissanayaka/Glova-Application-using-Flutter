import 'package:flutter/material.dart';

class SignUp_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(

        child: Stack(
          children: [
            Positioned(
              top: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back to Home Page'),
              ),
            ),
            Positioned(
              top: 100,
              child: ElevatedButton(
                onPressed: () {
                  // Add your logic for the second button
                },
                child: const Text('Second Button'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
