import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glova/Screens/chatBot.dart';
import 'package:glova/Screens/upload_image.dart';
import 'package:http/http.dart' as http;

class Upload_Images extends StatefulWidget {
  Upload_Images({Key? key}) : super(key: key);

  @override
  _Upload_ImagesState createState() => _Upload_ImagesState();
}

class _Upload_ImagesState extends State<Upload_Images> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

    Future<void> _uploadImage() async {
      if (_image == null) {
        return;
      }

      const url = 'http://127.0.0.1:5000/solution'; // Replace with your Flask backend URL

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));


      // Add the image to the request
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

      try {
        // Send the request
        print(request);
        var response = await request.send();

        // Check the response status
        if (response.statusCode == 200) {
          // Successful upload
          print('Image uploaded successfully');
        } else {
          // Handle error
          print('Failed to upload image. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle error
        print('Error uploading image: $error');
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color(0xFFADD8E6),
        actions: [
          // Back Button
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
            // Display Image
            _image != null
                ? Image.file(
              _image!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            )
                : Container(),
            // Upload Button
            Positioned(
              bottom: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: _getImage,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                  SizedBox(width: 16), // Add some space between buttons
                  ElevatedButton(
                    onPressed: _uploadImage,
                    child: Text('Upload Image'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
