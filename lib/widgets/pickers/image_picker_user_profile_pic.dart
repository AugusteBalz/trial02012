// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



String userPhoto = '';
// String userPhoto2 = 'assets/images/defaultuser.png';
String userPhoto2 = 'assets/images/defaultuser.png';


Future<void> getThePic() async {


  if (FirebaseAuth.instance.currentUser == null){
    return;
  }

  var ref = await  FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

  userPhoto = ref['image_url'];
  print(userPhoto);

  // TODO: add this line appropriately
  //setState((){});
}


class ImagePickerForUserProfile extends StatefulWidget {




  ImagePickerForUserProfile(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _ImagePickerForUserProfileState createState() => _ImagePickerForUserProfileState();
}

class _ImagePickerForUserProfileState extends State<ImagePickerForUserProfile> {
 // List<XFile>? _imageFileList;
  XFile? _imageFile;

  dynamic _pickImageError;



  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();



  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
            try {
              final pickedFile = await _picker.pickImage(
                source: source,

              );
              setState(() {
                _imageFile = pickedFile;
              });
              widget.imagePickFn(File(_imageFile!.path));


            } catch (e) {
              setState(() {
                _pickImageError = e;
              });
            }

  }

  @override
  void deactivate() {

    super.deactivate();
  }



  Widget _previewImages() {

    getThePic();

    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Semantics(
          child: Semantics(
            label: 'image_picker_example_picked_image',
            child: kIsWeb
                ? Image.network(_imageFile!.path)
                : Image.file(File(_imageFile!.path), fit: BoxFit.cover),
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const FindTheRightPicture();
    }
  }

  Widget _handlePreview() {

    
      return _previewImages();
    
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {

        setState(() {
          _imageFile = response.file;
         // _imageFileList = response.files;
        });

    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {


    return Container(

      height: 150,
      width: 150,
      // padding: EdgeInsets.all(8), // Border width
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: Stack(
        children:[Center(
            child: ClipOval(

              child: SizedBox.fromSize(
                size: Size.fromRadius(180),
                child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                    ? FutureBuilder<void>(
                  future: retrieveLostData(),
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Image(image: AssetImage('think.jpg'), fit: BoxFit.cover);
                      case ConnectionState.done:
                        return _handlePreview();
                      default:
                        if (snapshot.hasError) {
                          return Text(
                            'Pick image/video error: ${snapshot.error}}',
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return FindTheRightPicture();
                        }
                    }
                  },
                )
                    : _handlePreview(),
              ),
            )
        ),
          Align(
              alignment: Alignment.bottomRight
              ,child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(onPressed: (){

              _onImageButtonPressed(ImageSource.gallery, context: context);
            }, icon: Icon(Icons.add_a_photo_outlined, color: Colors.black,)),
          ))],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);


class FindTheRightPicture extends StatefulWidget {
  const FindTheRightPicture({Key? key}) : super(key: key);

  @override
  _FindTheRightPictureState createState() => _FindTheRightPictureState();
}

class _FindTheRightPictureState extends State<FindTheRightPicture> {



  @override
  Widget build(BuildContext context) {
    getThePic();

    if ((userPhoto == '') || (FirebaseAuth.instance.currentUser == null)) {

      print('object');
      return Image(image: AssetImage(userPhoto2));

    }


      return Image.network(userPhoto,  fit: BoxFit.cover,);
        //Image(image:  Image.network((userPhoto)));

  }
}

