import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadStoryImageToFirebase extends StatefulWidget {



  const UploadStoryImageToFirebase({Key? key}) : super(key: key);

  @override
  _UploadStoryImageToFirebaseState createState() => _UploadStoryImageToFirebaseState();
}

class _UploadStoryImageToFirebaseState extends State<UploadStoryImageToFirebase> {

  File imageFile = File('assets/images/lights.jpg');

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              height: 90,

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: (FileImage(imageFile)),

                  ))),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              color: Colors.black,

              onPressed: () {
                getFromGallery();
              },
              icon: Icon(Icons.camera_alt)

            ),
          ),
        ),
      ]
    ),);
  }
}
