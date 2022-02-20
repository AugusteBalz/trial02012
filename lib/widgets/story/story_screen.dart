import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/widgets/mood/multi_select_chip2.dart';
import 'package:trial0201/widgets/pickers/image_picker_for_stories.dart';
import 'package:trial0201/widgets/story/multi_select_chip_for_tags.dart';
import 'package:trial0201/widgets/story/upload_story_image_to_firebase.dart';

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  String choiceChipsValue = '1';
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();



  List<String> listOfSelectedTags = [];

  File imageFile = File('assets/images/lights.jpg');

  CollectionReference storyCollection = FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('StoryEntries');

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

  Future<void> addAStory() {
    // Call the user's CollectionReference to add a new user

    List<Map<String, dynamic>> temporaryArray = [];

    for (OneMood mood in oneStoryEntry.eachMood) {
      temporaryArray.add({
        'moodPrimary': primaryMoodToString[mood.moodPrimary],
        'moodSecondary': secondaryMoodToString[mood.moodSecondary],
        'strength': mood.strength,
      });
    }

    return storyCollection
        .add({
          'id': oneStoryEntry.id, // John Doe
          'dateTime':
              Timestamp.fromDate(oneStoryEntry.dateTime), // Stokes and Sons

          'title': textController1.text,
          'story': textController2.text,
          'tag': listOfSelectedTags,

          'OneMood': temporaryArray,
        })
        .then((value) => print("Story Added"))
        .catchError((error) => print("Failed to add story: $error"));
  }

  Future uploadImageToFirebase(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref =
        storage.ref().child("image" + oneStoryEntry.dateTime.toString());
    UploadTask uploadTask = ref.putFile(imageFile);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    print('refreshing');
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF130101)),
          automaticallyImplyLeading: true,
          title:
              Text('Story/Event', style: Theme.of(context).textTheme.headline1),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 15),
                child: GestureDetector(
                  onTap: () async {
                    //_addNewMoodEntry();

                    if (textController1.toString() == '') {
                      //display a pop up saying "please add at least one emotion!

                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    } else {
                      //if a person presses "Next", he goes to the next screen to rate the strength of his/her emotions

                      addAStory();
                      Navigator.pop(context);

                     await UploadStoryImageToFirebase();
                    }
                  },
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )),
          ],
          centerTitle: true,
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 40, left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 2.0, color: Colors.pinkAccent),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Title',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              /*  decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(width: 2.0, color: Colors.lightBlue.shade600),

                                ),

                              ),

                             */
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: textController1,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  hintMaxLines: 5,
                                  hintText:
                                      'Can you describe what happened in a few words?',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                // style: FlutterFlowTheme.bodyText1,
                                validator: (val) {
                                  if (val != null) {
                                    return 'Field is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                     /*
                      Expanded(
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                 height: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(imageFile),
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
                                  uploadImageToFirebase(context);
                                },
                                icon: Icon(Icons.camera_alt)
                                ,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      */
                      ImagePickerForStories(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                width: 2.0, color: Colors.lightBlueAccent),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Which area of your life was this event concerning?',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: MultiSelectChipForTags(
                          onSelectionChanged: (selectedList) {
                            setState(() {
                              //add all selected moods to the list
                              listOfSelectedTags = [...selectedList];
                            });
                          },
                          selectedChoices: listOfSelectedTags,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(top: 30),

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Text(
                          'What happened?',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      TextFormField(
                        controller: textController2,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,

                        obscureText: false,
                        decoration: const InputDecoration(
                          hintMaxLines: 5,
                          hintText:
                              'Had an issue at work? Got in a fight? Spilled coffee on your notes?',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        //  style: FlutterFlowTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Hi there!'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
            "It seems like you haven't selected any emotions... Please select at least one:)"),
      ],
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
