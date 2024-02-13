import 'package:flutter/material.dart';
import 'package:glova/Screens/chatBot.dart';
import 'package:glova/Screens/dash_board.dart';
import 'package:glova/Screens/skin_select.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'home_page.dart';

class SignUp_Page extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp_Page> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Function to send sign-up data to Flask server
  Future<Widget> signUp() async {
    // Replace parameters with user input
    var username = usernameController.text;
    var email = emailController.text;
    var phoneNumber = phoneNumberController.text;
    var password = passwordController.text;

    var url =
        'http://10.0.2.2:5000/sign-up?username=$username&emailAddress=$email&phoneNumber=$phoneNumber&password=$password';

    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response: $data');

      var responce = data['responce'];
      print(responce['status']);

      // Check the response data to determine success
      if (responce['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Skin_Select()),
        );
      } else {
        // Handle other cases when the server response indicates failure
        print('Error: ${responce['error']}');
      }
    }
    return SignUp_Page();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate back to the first screen when the button is pressed
              Navigator.pop(context);
            },
            child: Text('Go Back'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
               const Align(
                  alignment: Alignment(-1, -0.5),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF423838),
                      ),
                    ),
                  ),
                ),
              //Username
              Align(
                alignment: const Alignment(0, 0.06),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Username',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF282635).withOpacity(0.5),
                    ),
                  ),
                ),
              ),

              //Email Address
              Align(
                alignment: const Alignment(0, 0.06),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF282635).withOpacity(0.5),
                    ),
                  ),
                ),
              ),

              //Phone Number
              Align(
                alignment: const Alignment(0, 0.06),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Phone Number',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF282635).withOpacity(0.5),
                    ),
                  ),
                ),
              ),

              //Password
              Align(
                alignment: const Alignment(0, 0.06),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF282635).withOpacity(0.5),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004080),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Padding
                ), // Change button color here
                child: Text('Sign Up '),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
