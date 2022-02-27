import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/blueprint_mood.dart';
import 'package:trial0201/models/mood/mood_entries.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/models/story/story_entry.dart';
import 'package:trial0201/widgets/mood/multi_select_chip2.dart';
import 'package:trial0201/widgets/pickers/image_picker_for_stories.dart';
import 'package:trial0201/widgets/story/multi_select_chip_for_tags.dart';
import 'package:trial0201/widgets/story/upload_story_image_to_firebase.dart';
import 'package:trial0201/widgets/story/widget_for_mood_display_inner_in_stories.dart';
import 'package:trial0201/widgets/widget_for_mood_display_inner.dart';
import 'package:uuid/uuid.dart';

class StoryScreenNew extends StatefulWidget {
  @override
  _StoryScreenNewState createState() => _StoryScreenNewState();
}

class _StoryScreenNewState extends State<StoryScreenNew> {
  String choiceChipsValue = '1';
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? _storyImageFile;
  String uniqueStoryID = '';
  String imageId = '';

  List<String> listOfSelectedTags = [];

  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  var url;

  CollectionReference storyCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('StoryEntries');

  void _pickedImage(File image) async {
    //add story image to firebase

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_images/')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('stories')
        .child(uniqueStoryID + '.jpg');
    print(image.path);


    ref.delete();
    print(image.path);
    await ref.putFile(image);
    print('worjs');
    url = await ref.getDownloadURL();
  }

  void _pickedImageFromSamples(File image) async {
    imageId = image.path;
  }

  void _addNewMoodEntry() {
    //default blueprint

    BlueprintMood? temporaryMood = defaultBlueprint;

    final StoryEntry newEntry =

    // ids calculated dynamically
    StoryEntry(id: new Uuid().v1(), dateTime: DateTime.now(), eachMood: [], story: '', tags: [], title: '');

    oneStoryEntry = newEntry;

    setState(() {
      for (String emotion in selectedDisplayMoodsForStories) {
        if (nameToBlueprint.containsKey(emotion)) {
          temporaryMood = nameToBlueprint[emotion];
          oneStoryEntry.eachMood.add(
            OneMood(
              moodPrimary: temporaryMood!.moodPrimary,
              moodSecondary: temporaryMood!.moodSecondary,
              strength: 0,
              color: temporaryMood!.color,
            ),
          );
        }
      }
    });
  }

  Future<void> addAStory() {
    // Call the user's CollectionReference to add a new user


    //add moods to one place
    _addNewMoodEntry();

    List<Map<String, dynamic>> temporaryArray = [];

    for (OneMood mood in oneStoryEntry.eachMood) {
      temporaryArray.add({
        'moodPrimary': primaryMoodToString[mood.moodPrimary],
        'moodSecondary': secondaryMoodToString[mood.moodSecondary],
        'strength': mood.strength,
      });
    }

    //delete previous adds
    oneStoryEntry.eachMood.clear();
    moodSelectionForStories.clear();
    selectedDisplayMoodsForStories.clear();

    return storyCollection
        .add({
          'id': uniqueStoryID, // John Doe
          'dateTime': Timestamp.fromDate(DateTime.now()), // Stokes and Sons

          'title': textController1.text,
          'story': textController2.text,
          'tag': listOfSelectedTags,

          'image_url': url,
          'image_sample' : imageId,
          'OneMood': temporaryArray,
        })
        .then((value) => print("Story Added"))
        .catchError((error) => print("Failed to add story: $error"));
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();

  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_storyImageFile != null &&
        _storyImageFile!.path != 'assets/images/stories/storyimage1.jpg') {
      return Semantics(
          child: Semantics(
            label: 'image_picker_example_picked_image',
            child: Image.network(_storyImageFile!.path),
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      print('Pick image error: $_pickImageError');
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Image(image: AssetImage('assets/images/stories/storyimage1.jpg'));
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  void _generateNewUUID() {
    uniqueStoryID = new Uuid().v1();
  }

  @override
  Widget build(BuildContext context) {
    _generateNewUUID();
    print(uniqueStoryID);
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


                    //TODO: fix here
                    if (textController1.text.isEmpty) {
                      //display a pop up saying "please add at least one emotion!

                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, 'No title', 'Please write a short title, this way it will be easier for you to find it later!'),
                      );
                    }

                    else if (textController2.text.isEmpty) {
                      //display a pop up saying "please add at least one emotion!

                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, 'No story', 'Hmm, didn\'t you really write a story? If you would like to log just a mood, you can do it via "Mood Logging" on the main screen:)'),
                      );
                    }

                    else {
                      //if a person presses "Next", he goes to the next screen to rate the strength of his/her emotions

                      addAStory();
                      moodSelectionForStories.clear();
                      Navigator.pop(context);

                      // await UploadStoryImageToFirebase();
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
        body: GestureDetector(
          onTap: (){

            FocusScopeNode currentFocus = FocusScope.of(context);

            if(!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }

          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,

                        //height: 80,
                        child: CustomPaint(
                          //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: PartialPainter(
                            radius: 0,
                            strokeWidth: 2,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment(-0.2, -0.4),
                              stops: [0.0, 0.4],
                              colors: [
                                Colors.orangeAccent,
                                Colors.deepOrangeAccent,
                              ],
                            ),
                          ),

                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Title',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Container(
                                  child: SingleChildScrollView(
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: textController1,
                                      obscureText: false,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ImagePickerForStories(imagePickFn: _pickedImage, imagePickFnFromSamples: _pickedImageFromSamples,),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: CustomPaint(
                      //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: PartialPainter(
                        radius: 0,
                        strokeWidth: 2,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(-0.2, -0.4),
                          stops: [0.0, 0.4],
                          colors: [
                            Colors.orangeAccent,
                            Colors.deepOrangeAccent,
                          ],
                        ),
                      ),

                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: Container(
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
                    ),
                  ),
                  Container(
                    child: CustomPaint(
                      //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: PartialPainter(
                        radius: 0,
                        strokeWidth: 2,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(-0.2, -0.4),
                          stops: [0.0, 0.4],
                          colors: [
                            Colors.orangeAccent,
                            Colors.deepOrangeAccent,
                          ],
                        ),
                      ),

                      child: Container(
                        padding: EdgeInsets.all(10),
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
                              style: Theme.of(context).textTheme.subtitle2,
                              obscureText: false,
                              decoration: const InputDecoration(
                                hintMaxLines: 5,
                                hintText:
                                    'Had an issue at work? Got in a fight? Spilled coffee on your notes? Or maybe you won a lottery ticket...? \n'
                                        'Write here how your day has been!',
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
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: CustomPaint(
                      //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: PartialPainter(
                        radius: 0,
                        strokeWidth: 2,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(-0.2, -0.4),
                          stops: [0.0, 0.4],
                          colors: [
                            Colors.orangeAccent,
                            Colors.deepOrangeAccent,
                          ],
                        ),
                      ),

                      child: GFAccordion(
                        margin: EdgeInsets.all(0),
                        textStyle: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline3!.fontSize),
                        contentBackgroundColor: Colors.transparent,
                        expandedTitleBackgroundColor: Colors.transparent,
                        collapsedTitleBackgroundColor: Colors.transparent,
                        title: 'How did that make you feel?',
                        contentChild: Column(
                          children: [
                            SizedBox(height: 10,),
                          CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.red,
                                    Colors.redAccent,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Angry',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: angrySelection),),
                              ),
                            ),

                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.deepOrange,
                                    Colors.deepOrange,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Scared',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: scaredSelection),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.orange,
                                    Colors.deepOrangeAccent,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Surprised',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: surpriseSelection),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.orangeAccent,
                                    Colors.yellow,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Powerful',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: powerfulSelection),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.green,
                                    Colors.lightGreenAccent,

                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Happy',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: happySelection),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.teal,
                                    Colors.tealAccent,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Peaceful',

                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: peacefulSelection),

                      ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.blue,
                                    Colors.blueAccent,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Sad',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: sadSelection),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            CustomPaint(
                              //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: PartialPainterSmall(
                                radius: 0,
                                strokeWidth: 2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(-0.2, -0.4),
                                  stops: [0.0, 0.4],
                                  colors: [
                                    Colors.deepPurple,
                                    Colors.deepPurpleAccent,
                                  ],
                                ),
                              ),

                              child: GFAccordion(

                                margin: EdgeInsets.all(0),
                                textStyle: TextStyle(
                                    fontSize:
                                    Theme.of(context).textTheme.headline3!.fontSize),
                                contentBackgroundColor: Colors.transparent,
                                expandedTitleBackgroundColor: Colors.transparent,
                                collapsedTitleBackgroundColor: Colors.transparent,
                                title: 'Disgusted',
                                contentChild:   Container(child: WidgetForMoodDisplayInnerInStories(newMood: disgustedSelection),


                                ),
                              ),
                            ),
                            SizedBox(height: 20,),



                          ],
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String alertTitle, String message) {
  return AlertDialog(
    title: Text(alertTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  <Widget>[
        Text(message),
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

class PartialPainter extends CustomPainter {
  PartialPainter(
      {required this.radius,
      required this.strokeWidth,
      required this.gradient});

  final Paint paintObject = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    Rect topLeftTop = Rect.fromLTRB(0, 0, 25, strokeWidth);
    Rect topLeftLeft = Rect.fromLTRB(0, 0, strokeWidth, 25);

    // Rect bottomRightBottom = Rect.fromLTRB(size.width - size.height / 4, size.height - strokeWidth, size.width, size.height);
    // Rect bottomRightRight = Rect.fromLTRB(size.width - strokeWidth, size.height * 3 / 4, size.width, size.height);

    paintObject.shader = gradient.createShader(Offset.zero & size);

    Path topLeftPath = Path()
      ..addRect(topLeftTop)
      ..addRect(topLeftLeft);

    //Path bottomRightPath = Path()
    // ..addRect(bottomRightBottom)
    //..addRect(bottomRightRight);

    Path finalPath = topLeftPath;
    //Path.combine(PathOperation.union, topLeftPath, bottomRightPath);

    canvas.drawPath(finalPath, paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PartialPainterSmall extends CustomPainter {
  PartialPainterSmall(
      {required this.radius,
        required this.strokeWidth,
        required this.gradient});

  final Paint paintObject = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    Rect topLeftTop = Rect.fromLTRB(0, 0, 10, strokeWidth);
    Rect topLeftLeft = Rect.fromLTRB(0, 0, strokeWidth, 10);

    // Rect bottomRightBottom = Rect.fromLTRB(size.width - size.height / 4, size.height - strokeWidth, size.width, size.height);
    // Rect bottomRightRight = Rect.fromLTRB(size.width - strokeWidth, size.height * 3 / 4, size.width, size.height);

    paintObject.shader = gradient.createShader(Offset.zero & size);

    Path topLeftPath = Path()
      ..addRect(topLeftTop)
      ..addRect(topLeftLeft);

    //Path bottomRightPath = Path()
    // ..addRect(bottomRightBottom)
    //..addRect(bottomRightRight);

    Path finalPath = topLeftPath;
    //Path.combine(PathOperation.union, topLeftPath, bottomRightPath);

    canvas.drawPath(finalPath, paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}