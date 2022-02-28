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
String userPhoto2 = 'assets/images/stories/default.jpg';

List<dynamic> images = [];
List<String> _listImagesProfiles = [
  'assets/images/profiles/autumn_bunny.png',
  'assets/images/profiles/autumn_deer.png',
  'assets/images/profiles/autumn_hegdehog.png',
  'assets/images/profiles/autumn_racoon.png',
  'assets/images/profiles/autumn_squirrel.png',
  'assets/images/profiles/round_animal_1.png',
  'assets/images/profiles/round_animal_2.png',
  'assets/images/profiles/round_animal_3.png',
  'assets/images/profiles/round_animal_4.png',
  'assets/images/profiles/round_animal_5.png',
  'assets/images/profiles/round_animal_6.png',
  'assets/images/profiles/round_animal_7.png',
  'assets/images/profiles/round_animal_8.png',
  'assets/images/profiles/round_animal_9.png',
  'assets/images/profiles/winter_1.png',
  'assets/images/profiles/winter_2.png',
  'assets/images/profiles/winter_3.png',
  'assets/images/profiles/winter_4.png',
  'assets/images/profiles/winter_5.png',
  'assets/images/profiles/winter_6.png',
  'assets/images/profiles/fish_1.png',
  'assets/images/profiles/fish_2.png',
  'assets/images/profiles/fish_3.png',
  'assets/images/profiles/fish_4.png',
  'assets/images/profiles/fish_5.png',
  'assets/images/profiles/fish_6.png',
  'assets/images/profiles/fish_7.png',
  'assets/images/profiles/fish_8.png',
  'assets/images/profiles/fish_9.png',
  'assets/images/profiles/monster_1.png',
  'assets/images/profiles/monster_2.png',
  'assets/images/profiles/monster_3.png',
  'assets/images/profiles/monster_4.png',
  'assets/images/profiles/monster_5.png',
  'assets/images/profiles/monster_6.png',
];

List<String> _listImagesStories = [
  'assets/images/stories/595.jpg',
  'assets/images/stories/129.jpg',
  'assets/images/stories/rain_1.png',
  'assets/images/stories/2902348.jpg',
  'assets/images/stories/storyimage1.jpg',
  'assets/images/stories/hands.jpg',
  'assets/images/stories/abstract_1.png',
  'assets/images/stories/abstract_2.png',
  'assets/images/stories/abstract_3.png',
  'assets/images/stories/abstract_4.png',
  'assets/images/stories/girl.jpg',
  'assets/images/stories/sunset.jpg',
  'assets/images/stories/weather_1.png',
  'assets/images/stories/weather_2.png',
  'assets/images/stories/weather_3.png',
  'assets/images/stories/weather_4.png',
  'assets/images/stories/weather_5.png',
  'assets/images/stories/weather_6.png',
  'assets/images/stories/weather_7.png',
  'assets/images/stories/weather_8.png',
  'assets/images/stories/weather_9.png',
  'assets/images/stories/weather_10.png',
  'assets/images/stories/lights.jpg',
];

Future<void> getThePic() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return;
  }

  var ref = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  userPhoto = ref['image_url'];
  print(userPhoto);

  // TODO: add this line appropriately
  //setState((){});
}

class ImagePickerForStories extends StatefulWidget {
  ImagePickerForStories({required this.imagePickFn, required this.imagePickFnFromSamples});

  final void Function(File pickedImage) imagePickFn;
  final void Function(File pickedImage) imagePickFnFromSamples;

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
      //TODO: do not add const!!
      return FindTheRightPicture();
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

  Widget _buildPopupDialog(BuildContext context) {
    // getDeffaultImages(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.all( 10.0),
      title: Text('Pick a picture'),
      content: Container(
        height: 400,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //TODO: good avatar if needed
            /*
          CircleAvatar(
            minRadius: 20,
            maxRadius: 50,
            child: Image(
                image: AssetImage(
              'assets/images/profiles/autumn_bunny.png',
            )),
            backgroundColor: Colors.transparent,
          ),
           */

            Flexible(
              child: GridView.builder(
                  //  shrinkWrap: true,

                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      // childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: _listImagesStories.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      //height: 100,

                      alignment: Alignment.center,
                      child: IconButton(
                        icon: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage(_listImagesStories[index]),
                          backgroundColor: Colors.transparent,
                        ),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.pop(context);

                          setState(() {
                            userPhoto = _listImagesStories[index];
                            widget.imagePickFnFromSamples(File(userPhoto));
                          });
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
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

          //TODO: this is a selection from camera
          /*
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
                  onPressed: () async {
                    final ww = await showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog(
                        context,
                      ),
                    );
                    setState(() {});
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
  bool _validURL = Uri.parse(userPhoto).isAbsolute;

  @override
  Widget build(BuildContext context) {
    // getThePic();

    if ((userPhoto == '') || (FirebaseAuth.instance.currentUser == null)) {
      print('object');
      return Image(
        image: AssetImage(userPhoto2),
        fit: BoxFit.fill,
      );
    } else if (_validURL) {
      return Image.network(
        userPhoto,
        fit: BoxFit.cover,
      );
    } else if (userPhoto!='') {
      return Image(
        image: AssetImage(userPhoto),
        fit: BoxFit.fill,
      );
    }
    return Image(
      image: AssetImage(userPhoto2),
      fit: BoxFit.fill,
    );

    //Image(image:  Image.network((userPhoto)));
  }
}
