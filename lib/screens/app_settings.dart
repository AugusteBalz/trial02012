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

class _AppSettingsState extends State<AppSettings> {

  late File _userImageFile;


  Future<void> getUserData()
  async {


    var ref = await  FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

     userName = ref['username'];
     userPhoto = ref['image_url'];



  }

  void _pickedImage(File image) async {
    _userImageFile = mainProfilePic;

    //update user image

    var url;

    if(image!=null){
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image/')
          .child("images/")
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

      ref.delete();
      await ref.putFile(image);
      url = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'image_url': url,
    });


  }

  @override
  Widget build(BuildContext context) {

    getUserData();

    return Container(

      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child:
      Column(
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
                children:  [
                  Text(

                      userName

                  ),
                  ImagePickerForUserProfile(_pickedImage),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),


          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

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
                  icons:  const [

                    Icons.wb_sunny_rounded,
                    Icons.nights_stay_rounded,

                  ],
                  iconSize: 30.0,
                  activeBgColors:  const [[Colors.yellow, Colors.orange],[Colors.blue, Color(
                      0xFF00116B)] ],
                  //animate: true, // with just animate set to true, default curve = Curves.easeIn
                  //curve: Curves.linear, // animate must be set to true when using custom curve
                  onToggle: (index) {

                    //TODO: fix theming

                     if(previousIndex!=index){
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
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: const [
                Text("Customize colors"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child:
              TextButton(


                child:  Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app, color: Colors.black,),
                      SizedBox(width: 8),
                      Text('Logout', style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
                onPressed: () {

                    FirebaseAuth.instance.signOut();
                   // userId = null;

                }
              ),
            ),
          )

        ],
      ),
      
      
    );
  }
}


void _changeColorTheme(ThemeData mode) {




  if (mode.brightness == Brightness.light) {
    print('dod');
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



class displayProfilePhoto extends StatefulWidget {
  const displayProfilePhoto({Key? key}) : super(key: key);

  @override
  _displayProfilePhotoState createState() => _displayProfilePhotoState();
}

class _displayProfilePhotoState extends State<displayProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(


    );
  }
}
