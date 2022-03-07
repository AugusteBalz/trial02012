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
import 'package:trial0201/globals/defaults.dart';



String userPhoto = '';
String userProfileSample = '';
String userPhoto2 = 'assets/images/defaultuser.png';

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

class ImagePickerForUserProfile extends StatefulWidget {


final image;
final userSamplePhoto;

  ImagePickerForUserProfile(this.imagePickFn, this.image, this.imagePickFnFromSamples, this.userSamplePhoto);

  final void Function(File pickedImage) imagePickFn;
  final void Function(File pickedImage) imagePickFnFromSamples;

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
                imageQuality: 50,
                maxHeight: 450,

              );
              setState(() {
                _imageFile = pickedFile;
                mainProfilePic = (pickedFile!= null) ? File(pickedFile.path): mainProfilePic;
              });
              widget.imagePickFn(File(_imageFile!.path));


            } catch (e) {
              setState(() {
                _pickImageError = e;
              });
            }

  }


  void getThePic()  {

    userPhoto = widget.image;

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
      return  FindTheRightPicture();
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
      decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
      child: Stack(
        children:[Center(

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
          Align(
              alignment: Alignment.bottomRight
              ,child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(onPressed: () async{

              final ww = await showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(
                  context,
                ),
              );
              setState(() {});


             // _onImageButtonPressed(ImageSource.gallery, context: context);
            }, icon: Icon(Icons.add_photo_alternate_outlined, color: Colors.black, size: 23,)),
          ))],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    // getDeffaultImages(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.all( 10.0),
      title: Text('Which one represents you the most?'),
      content: Container(
        height: 400,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Flexible(
              child: GridView.builder(
                //  shrinkWrap: true,

                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      // childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: _listImagesProfiles.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      //height: 100,

                      alignment: Alignment.center,
                      child: IconButton(
                        icon: CircleAvatar(
                          radius: 100,
                          child:
                          Image(image: AssetImage(_listImagesProfiles[index])),
                          backgroundColor: Colors.transparent,
                        ),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.pop(context);

                          setState(() {
                            userProfileSample = _listImagesProfiles[index];
                            widget.imagePickFnFromSamples(File(userProfileSample));
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


  Future<void> getThePic() async {


    if (FirebaseAuth.instance.currentUser == null){
      return;
    }

    var ref = await  FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    if(ref['image_url'] != null){
      userPhoto = ref['image_url'];
    }



    userProfileSample = ref['image_sample'];

  }



  @override
  void initState() {
    super.initState();
    getThePic();

  }
  @override
  Widget build(BuildContext context) {
    getThePic();
    bool _validURL = Uri.parse(userPhoto).isAbsolute;


    if ( userProfileSample=='' &&(FirebaseAuth.instance.currentUser == null)) {

      return

        ClipOval(

            child: SizedBox.fromSize(
              size: Size.fromRadius(180),

              child:   Image(image: AssetImage(userPhoto2),fit: BoxFit.fill,),
            )

        );




    }
    else if (_validURL) {
      return
        ClipOval(

          child: SizedBox.fromSize(
            size: Size.fromRadius(180),

            child:  Image.network(
                userPhoto,
                fit: BoxFit.cover,
          ),
        )

      );
    } else if (userProfileSample!='') {

      return Image(
        image: AssetImage(userProfileSample),
        fit: BoxFit.fill,
      );
    }

      return Image(image: AssetImage(userPhoto2),fit: BoxFit.fill,);

  }
}

