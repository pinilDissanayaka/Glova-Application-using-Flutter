// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:glova/Screens/chatBot.dart';
// import 'package:glova/Screens/skin_select.dart';
//
// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//
//   final user = FirebaseAuth.instance.currentUser!;
//
//   // sign user out method
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFADD8E6),
//         actions: [
//           IconButton(
//             onPressed: signUserOut,
//             icon: Icon(Icons.logout),
//           )
//         ],
//       ),
//       body: Center(
//         child: Stack(
//           children: [
//
//             //Hello Text
//             Align(
//               alignment: const Alignment(-0.7, -0.95),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: Row(
//                   children: [
//                     const Text("Hello,",
//                         style: TextStyle(
//                           fontSize: 20,
//                         )),
//                     Text(user.email!,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//
//             //Notification Icon
//             const Align(
//               alignment: Alignment(0.8, -0.93),
//               child: Icon(Icons.notifications),
//             ),
//
//             //Api test button
//             Align(
//               alignment: const Alignment(-0.65, 0.7),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Skin_Select()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffffffff),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10), // Border radius
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 30, vertical: 15), // Padding
//                 ), // Change button color here
//                 child: const Text(
//                   'Api test',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
