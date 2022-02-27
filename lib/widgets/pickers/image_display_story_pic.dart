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

   var url;
  ImageDisplayStoryPick({Key? key, this.title, required this.url}) : super(key: key);

  final String? title;

  @override
  _ImageDisplayStoryPickState createState() => _ImageDisplayStoryPickState();
}

class _ImageDisplayStoryPickState extends State<ImageDisplayStoryPick> {


  String? _retrieveDataError;




  @override
  void deactivate() {

    super.deactivate();
  }




  Widget _previewImages() {

    if (widget.url == null){
      print('url is empty');
    return  Image(image: AssetImage('assets/images/stories/storyimage1.jpg'), fit: BoxFit.cover);
    }
    return Image.network(widget.url, fit: BoxFit.cover,);
  }

  Widget _handlePreview() {
      return _previewImages();
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
              child: _handlePreview(),
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

