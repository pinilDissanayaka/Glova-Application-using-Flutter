import 'package:flutter/material.dart';

class SignIn_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String imagePath = "assets/google_icon.png";

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/SignInBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const FractionallySizedBox(
              widthFactor: 0.7,
              child: Align(
                alignment: Alignment(-1, -0.5),
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF423838),
                    ),
                  ),
                ),
              ),
            ),

            //Email Text Field
            const Align(
              alignment: Alignment(0, -0.2),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            //Password Text Field
            const Align(
              alignment: Alignment(0, 0.1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            // Forgot Password?
            Align(
              alignment: const Alignment(0.7, 0.2),
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            //Sign In Button
            Align(
              alignment: const Alignment(0, 0.4),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004080),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Padding
                ), // Change button color here
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            //OR
            Align(
              alignment: const Alignment(0, 0.5),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            //Google Button
            Align(
              alignment: const Alignment(0, 0.7),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                child: Image.asset(
                  imagePath, //Image Path on the top of the code
                  height: 40,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
