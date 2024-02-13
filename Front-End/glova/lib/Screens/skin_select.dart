import 'package:flutter/material.dart';
import 'package:glova/Screens/dash_board.dart';
import 'package:http/http.dart' as http;

class Skin_Select extends StatefulWidget {
  Skin_Select({super.key});

  @override
  _Skin_SelectState createState() => _Skin_SelectState();
}

class _Skin_SelectState extends State<Skin_Select> {
  List<String> skinTypes = [
    'Dry',
    'Oily',
    'Normal',
    'Combination',
    'Sensitive'
  ];
  List<String> skinTones = [
    "Light",
    "Medium",
    "Dark",
    "Medium Light",
    "Medium Dark"
  ];
  List<String> skinConcerns = [
    "Acne Scars",
    "Black/White Heads",
    "Dark Undereyes",
    "Duliness",
    "Hyper-Pigmentation",
    "Roughness",
    "Large Pores",
    "Sensitivity",
    "Wrinkles"
  ];

  List<bool> isHighlightedTypes = [false, false, false, false, false];
  List<bool> isHighlightedTones = [false, false, false, false, false];
  List<bool> isHighlightedConcerns = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<ImageProvider> imagesTypes = [
    AssetImage('assets/Acne Prone.png'),
    AssetImage('assets/Combination.png'),
    AssetImage('assets/Dry.png'),
    AssetImage('assets/Normal.png'),
    AssetImage('assets/Oily.png'),
  ];

  List<ImageProvider> imagesTones = [
    AssetImage('assets/Acne Prone.png'),
    AssetImage('assets/Combination.png'),
    AssetImage('assets/Dry.png'),
    AssetImage('assets/Normal.png'),
    AssetImage('assets/Oily.png'),
  ];

  List<ImageProvider> imagesConcerns = [
    AssetImage('assets/Acne Prone.png'),
    AssetImage('assets/Combination.png'),
    AssetImage('assets/Dry.png'),
    AssetImage('assets/Normal.png'),
    AssetImage('assets/Oily.png'),
    AssetImage('assets/Dry.png'),
    AssetImage('assets/Normal.png'),
    AssetImage('assets/Oily.png'),
    AssetImage('assets/Acne Prone.png'),
  ];


  void sendSkinDataToBackend() async {
    // Replace the placeholders with actual values
    String skinType = getHighlightedIndex(isHighlightedTypes);
    String skinTone = getHighlightedIndex(isHighlightedTones);
    String skinConcern = getHighlightedIndex(isHighlightedConcerns);

    // Your Flask backend URL
    final String backendUrl = 'http://10.0.2.2:5000/skin-data';

    // Perform the HTTP request
    try {
      final response = await http.get(Uri.parse('$backendUrl?skinType=$skinType&skinTone=$skinTone&skinConcern=$skinConcern'));

      if (response.statusCode == 200) {
        // Handle the response from the server if needed
        print('Response: ${response.body}');
      } else {
        // Handle errors if the request was not successful
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  String getHighlightedIndex(List<bool> highlightedList) {
    for (int i = 0; i < highlightedList.length; i++) {
      if (highlightedList[i]) {
        return i.toString();
      }
    }
    return '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            // Glova Text
            const FractionallySizedBox(
              child: Align(
                alignment: Alignment(0, -0.9),
                child: Text(
                  'Glova',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF423838),
                  ),
                ),
              ),
            ),

            // What is your skin type
            Align(
              alignment: const Alignment(0, -0.7),
              child: Text(
                'What is your skin type?',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),

            // Skin types
            Align(
              alignment: Alignment(0, -0.6),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  skinTypes.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isHighlightedTypes = List.generate(
                              skinTypes.length, (i) => i == index);
                        });
                        // Perform actions based on the selected button
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(
                          color: isHighlightedTypes[index]
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                      child: Ink.image(
                        image: imagesTypes[index],
                        // Replace with your image path
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // What is your skin tones
            Align(
              alignment: const Alignment(0, -0.3),
              child: Text(
                'What is your skin tones?',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),

            // Skin tones
            Align(
              alignment: Alignment(0, -0.1),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  skinTones.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isHighlightedTones = List.generate(
                              skinTones.length, (i) => i == index);
                        });
                        // Perform actions based on the selected button
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(
                          color: isHighlightedTones[index]
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                      child: Ink.image(
                        image: imagesTones[index],
                        // Replace with your image path
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),


            // What is your skin concerns
            Align(
              alignment: const Alignment(0, 0.1),
              child: Text(
                'What is your skin concerns?',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),

            // Skin concerns
            Align(
              alignment: Alignment(0, 0.5),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  skinConcerns.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isHighlightedConcerns = List.generate(
                              skinConcerns.length, (i) => i == index);
                        });
                        // Perform actions based on the selected button
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(
                          color: isHighlightedConcerns[index]
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                      child: Ink.image(
                        image: imagesConcerns[index],
                        // Replace with your image path
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Start My Journey button
            Align(
              alignment: const Alignment(0, 0.8),
              child: ElevatedButton(
                onPressed: () {
                  // Send skin data to the backend
                  sendSkinDataToBackend();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashBoard()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004080), // Default color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Start My Journey',
                  style: TextStyle(
                    color: Colors.white,
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
