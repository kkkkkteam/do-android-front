import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AuthProfileImageEditor extends StatefulWidget {
  @override
  _AuthProfileImageEditorState createState() => _AuthProfileImageEditorState();
}

class _AuthProfileImageEditorState extends State<AuthProfileImageEditor> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _profileImage != null
            ? FileImage(_profileImage!)
            : AssetImage('assets/profile_image.jpeg') as ImageProvider,
      ),
    );
  }
}
