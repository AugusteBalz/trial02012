// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial0201/globals/defaults.dart';

String userPhoto = '';
String userPhoto2 = 'assets/images/storyimage1.jpg';

List<dynamic> images = [];
List<String> _listImages = [
  "assets/images/default_images_for_profiles/autumn_bunny.png",
  'assets/images/default_images_for_profiles/autumn_deer.png',
];

/*
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

*/
class ImagePickerForStories extends StatefulWidget {
  ImagePickerForStories({required this.imagePickFn});

  final void Function(File pickedImage) imagePickFn;

  @override
  _ImagePickerForStoriesState createState() => _ImagePickerForStoriesState();
}

class _ImagePickerForStoriesState extends State<ImagePickerForStories> {
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
        imageQuality: 50,
        maxHeight: 450,
      );
      setState(() {
        _imageFile = pickedFile;
        mainProfilePic =
            (pickedFile != null) ? File(pickedFile.path) : mainProfilePic;
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
    // getThePic();

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
      height: 100,
      width: 100,
      // padding: EdgeInsets.all(8), // Border width
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      child: Stack(
        children: [
          Center(
              child: ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(180),
              child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Image(
                                image: AssetImage('storyimage1.jpg'),
                                fit: BoxFit.cover);
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
          )),
         /*
         //TODO: this is a selection from camera
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery,
                        context: context);
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.black,
                  )),
            ),
          ),
          */
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context, ),
                    );

                  },
                  icon: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
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
    // getThePic();

    if ((userPhoto == '') || (FirebaseAuth.instance.currentUser == null)) {
      print('object');
      return Image(image: AssetImage(userPhoto2));
    }

    return Image.network(
      userPhoto,
      fit: BoxFit.cover,
    );
    //Image(image:  Image.network((userPhoto)));
  }
}


Widget _buildPopupDialog(BuildContext context) {


 // getDeffaultImages(context);

  return AlertDialog(
    title: Text('ha'),
    content: Container(
      height: 100,
      width: 100,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[

           GridView.builder(
             shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: _listImages.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    height: 10,

                    alignment: Alignment.center,
                    child:
                    CircleAvatar(
                      backgroundImage: AssetImage(_listImages[index]),),


                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  );
                }),

          //  getTextWidgets(context, ['1','5','33']),
          ],
        ),
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Okay!'),
      ),
    ],
  );
}

void getDeffaultImages(BuildContext context ) {

  final manifestJson = DefaultAssetBundle.of(context).loadString('AssetManifest.json').toString();
  print(manifestJson);
//  List<String> received = json.decode(manifestJson).keys;
 //Map<int, String> received2 = received.asMap();
print(images);

 // images
}

Widget getTextWidgets(BuildContext context, List<String> strings)
{
  getDeffaultImages(context);
  List<Widget> list = [];
  for(var i = 0; i < strings.length; i++){
    list.add(new Text(strings[i]));
  }
  return new Row(children: list);
}


