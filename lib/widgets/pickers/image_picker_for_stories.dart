// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerForStories extends StatefulWidget {
  ImagePickerForStories({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ImagePickerForStoriesState createState() => _ImagePickerForStoriesState();
}

class _ImagePickerForStoriesState extends State<ImagePickerForStories> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

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

      height: 100,
      width: 100,
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
                          return const Image(image: AssetImage('think.jpg'));
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
