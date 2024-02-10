import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glova/Screens/chatBot.dart';
import 'package:glova/Screens/upload_image.dart';

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
              child: FloatingActionButton(
                onPressed: _getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
