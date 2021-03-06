import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:trial0201/globals/defaults.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/theming.dart';
import 'package:trial0201/screens/mood_history.dart';
import 'package:trial0201/widgets/pickers/image_picker_user_profile_pic.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

String userName = 'Loading...';
String userPhoto = 'error';
String userSamplePhoto = '';
String imageId = '';

class _AppSettingsState extends State<AppSettings> {
  late File _userImageFile;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    var ref = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      try {
        userName = ref['username'];
      } catch (e) {
        print(e);
        print('failed to get userName');
      }

      try {
        if (ref['image_url'] != null) {
          userPhoto = ref['image_url'];
        }

        ImagePickerForUserProfile(
            _pickedImage, userPhoto, _pickedImageFromSamples, userSamplePhoto);
      } catch (e) {
        print(e);
        print('failed to get image_url');
      }

      try {
        userSamplePhoto = ref['image_sample'];

        ImagePickerForUserProfile(
            _pickedImage, userPhoto, _pickedImageFromSamples, userSamplePhoto);
      } catch (e) {
        print(e);
        print('failed to get image_sample');
      }
    });
  }

  void _pickedImage(File image) async {
    _userImageFile = mainProfilePic;

    //update user image

    var url;
    var ref;

    if (image != null) {
      try {
        ref = FirebaseStorage.instance
            .ref()
            .child('user_image/')
            .child("images/")
            .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

        ref.delete();
      } catch (e) {
        print('no previous photo was available');
      }

      await ref.putFile(image);
      url = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'image_url': url,
      'image_sample': '',
    });
  }

  void _pickedImageFromSamples(File image) async {
    imageId = image.path;

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image/')
        .child("images/")
        .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

    ref.delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'image_sample': imageId,
      'image_url': '',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userName),
                  ImagePickerForUserProfile(_pickedImage, userPhoto,
                      _pickedImageFromSamples, userProfileSample),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Theme"),
                    //ToggleButtons(children: children, isSelected: isSelected)

                    ToggleSwitch(
                      minWidth: 60.0,
                      minHeight: 50.0,
                      initialLabelIndex: previousIndex,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      icons: const [
                        Icons.wb_sunny_rounded,
                        Icons.nights_stay_rounded,
                      ],
                      iconSize: 30.0,
                      activeBgColors: const [
                        [Colors.yellow, Colors.orange],
                        [Colors.blue, Color(0xFF00116B)]
                      ],
                      //animate: true, // with just animate set to true, default curve = Curves.easeIn
                      //curve: Curves.linear, // animate must be set to true when using custom curve
                      onToggle: (index) {
                        //TODO: fix theming

                        if (previousIndex != index) {
                          currentModel.toggleMode();
                          previousIndex = index!;

                          //TODO: color sceheme!!!!
                          // _changeColorTheme(Theme.of(context));

                          //rebuild all the widgets
                          // ShowMoodHistory();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/setUpNotifications');
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Notifications',
                            style: Theme.of(context).textTheme.bodyText2),
                        Icon(Icons.arrow_forward_outlined,
                            color: Theme.of(context).primaryColorDark),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(10),
            child: TextButton(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  // userId = null;
                }),
          )
        ],
      ),
    );
  }
}

void _changeColorTheme(ThemeData mode) {
  if (mode.brightness == Brightness.light) {
    angryMoodColor = angryMoodColorLight;
    scaredMoodColor = scaredMoodColorLight;
    sadMoodColor = sadMoodColorLight;
    happyMoodColor = happyMoodColorLight;
    surprisedMoodColor = surprisedMoodColorLight;
    powerfulMoodColor = powerfulMoodColorLight;
    disgustedMoodColor = disgustedMoodColorLight;
    peacefulMoodColor = peacefulMoodColorLight;
  } else {
    angryMoodColor = angryMoodColorDark;
    scaredMoodColor = scaredMoodColorDark;
    sadMoodColor = sadMoodColorDark;
    happyMoodColor = happyMoodColorDark;
    surprisedMoodColor = surprisedMoodColorDark;
    powerfulMoodColor = powerfulMoodColorDark;
    disgustedMoodColor = disgustedMoodColorDark;
    peacefulMoodColor = peacefulMoodColorDark;
  }
}
