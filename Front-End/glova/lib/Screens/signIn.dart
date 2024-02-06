import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glova/Screens/home_page.dart';

import 'auth_page.dart';

class SignIn_Page extends StatefulWidget {
  @override
  State<SignIn_Page> createState() => _SignIn_PageState();
}

class _SignIn_PageState extends State<SignIn_Page> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      String errorMessage = 'An error occurred';
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        errorMessage = 'user-not-found';
        showErrorDialog(errorMessage);
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        errorMessage = 'wrong-password';
        showErrorDialog(errorMessage);
      }
      // show error to user
      showErrorDialog(errorMessage);
    }
  }

  //error showing method
  void showErrorDialog(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF423838),
                    ),
                  ),
                ),
              ),
            ),

            //Email Text Field
            Align(
              alignment: const Alignment(0, -0.15),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email Address',
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
            const SizedBox(height: 20),

            //Password Text Field
            Align(
              alignment: const Alignment(0, 0.06),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: TextField(
                  controller: passwordController,
                  decoration:  InputDecoration(
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
                onPressed: signUserIn,
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
                padding: const EdgeInsets.all(10),
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
