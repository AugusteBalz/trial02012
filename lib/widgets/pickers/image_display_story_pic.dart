// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial0201/globals/defaults.dart';


class ImageDisplayStoryPick extends StatefulWidget {
  ImageDisplayStoryPick({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ImageDisplayStoryPickState createState() => _ImageDisplayStoryPickState();
}

class _ImageDisplayStoryPickState extends State<ImageDisplayStoryPick> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

  CollectionReference moodCollection = FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('MoodEntries');


  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  late File _storyImageFile;
  

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
            try {
              final pickedFile = await _picker.pickImage(
                source: source,
                imageQuality: 50,
                maxHeight: 400,

              );
              setState(() {
                _imageFile = pickedFile;
              });
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
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: Semantics(
            label: 'image_picker_example_picked_image',
            child: kIsWeb
                ? Image.network(_imageFileList![0].path)
                : Image.file(File(_imageFileList![0].path), fit: BoxFit.cover),
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const  Image(image: AssetImage('assets/images/storyimage1.jpg'));
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
          _imageFileList = response.files;
        });

    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 90,
      width: 90,
      // padding: EdgeInsets.all(8), // Border width
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: Center(
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
                        return const Image(image: AssetImage('think.jpg'));
                      }
                  }
                },
              )
                  : _handlePreview(),
            ),
          )
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

