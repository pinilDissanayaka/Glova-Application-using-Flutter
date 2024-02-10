import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glova/Screens/chatBot.dart';
import 'package:glova/Screens/upload_image.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color(0xFFADD8E6),
        actions: [
          //back Button
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [

            //Hello Text
            const Align(
              alignment: Alignment(-0.7, -0.95),
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Text("Hello,",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ),

            //Notification Icon
            const Align(
              alignment: Alignment(0.8, -0.93),
              child: Icon(Icons.notifications),
            ),

            //Api test button
            Align(
              alignment: const Alignment(-0.65, 0.7),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Upload_Images()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Padding
                ), // Change button color here
                child: const Text(
                  'Api test',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
