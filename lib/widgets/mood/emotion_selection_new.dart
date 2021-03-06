import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/widgets/widget_for_mood_display_inner.dart';

import '../widget_for_mood_display.dart';
import 'dart:ui' as ui;

import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/blueprint_mood.dart';
import 'package:trial0201/models/mood/mood_entries.dart';

import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/screens/graphs.dart';
import 'package:uuid/uuid.dart';

import 'package:trial0201/globals/mood/colors_of_mood.dart';

import 'package:trial0201/widgets/widget_for_mood_display.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
MediaQueryData queryData = new MediaQueryData();

class EmotionSelectionNew extends StatefulWidget {
  @override
  _EmotionSelectionNewState createState() => _EmotionSelectionNewState();
}

class _EmotionSelectionNewState extends State<EmotionSelectionNew> {
  PageController _controller1 = PageController(initialPage: 4242);
  PageController _controller2 = PageController(initialPage: 4242);

  var currentPageValue = 0.0;

  //for displaying colours and name of primary emotion
  final List<dynamic> displayWidgets = [
    WidgetForMoodDisplay(
      newMood: angrySelection,
      colorToLeft: awfulAndAngry,
      colorToRight: angryAndScared,
    ),
    WidgetForMoodDisplay(
      newMood: scaredSelection,
      colorToLeft: angryAndScared,
      colorToRight: scaredAndSurprised,
    ),
    WidgetForMoodDisplay(
      newMood: surpriseSelection,
      colorToLeft: scaredAndSurprised,
      colorToRight: surprisedAndPowerful,
    ),
    WidgetForMoodDisplay(
      newMood: powerfulSelection,
      colorToLeft: surprisedAndPowerful,
      colorToRight: powerfulAndHappy,
    ),
    Container(
      child: WidgetForMoodDisplay(
        newMood: happySelection,
        colorToLeft: powerfulAndHappy,
        colorToRight: happyAndPeaceful,
      ),
    ),
    WidgetForMoodDisplay(
      newMood: peacefulSelection,
      colorToLeft: happyAndPeaceful,
      colorToRight: peacefulAndSad,
    ),
    WidgetForMoodDisplay(
      newMood: sadSelection,
      colorToLeft: peacefulAndSad,
      colorToRight: sadAndAwful,
    ),
    WidgetForMoodDisplay(
        newMood: disgustedSelection,
        colorToLeft: sadAndAwful,
        colorToRight: awfulAndAngry),
  ];

  //for displaying secondary emotion widgets

  final List<dynamic> displayInnerWidgets = [
    WidgetForMoodDisplayInner(newMood: angrySelection),
    WidgetForMoodDisplayInner(newMood: scaredSelection),
    WidgetForMoodDisplayInner(newMood: surpriseSelection),
    WidgetForMoodDisplayInner(newMood: powerfulSelection),
    Container(
      child: WidgetForMoodDisplayInner(newMood: happySelection),
    ),
    WidgetForMoodDisplayInner(newMood: peacefulSelection),
    WidgetForMoodDisplayInner(newMood: sadSelection),
    WidgetForMoodDisplayInner(newMood: disgustedSelection),
  ];

  double? currentPage = 0;

  void _addNewMoodEntry() {
    //default blueprint

    BlueprintMood? temporaryMood = defaultBlueprint;

    final MoodEntry newEntry =

        // ids calculated dynamically
        MoodEntry(id: new Uuid().v1(), dateTime: DateTime.now(), eachMood: []);

    oneEntry = newEntry;

    setState(() {
      for (String emotion in selectedDisplayMoods) {
        if (nameToBlueprint.containsKey(emotion)) {
          temporaryMood = nameToBlueprint[emotion];
          oneEntry.eachMood.add(
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

  @override
  void initState() {
    super.initState();
    _controller1 = PageController(initialPage: 4242);
    _controller2 = PageController(initialPage: 4242);

    _controller2.addListener(() {
      _controller1.jumpTo(_controller2.offset);
    });

    _controller2.addListener(() {
      setState(() {
        currentPage = _controller2.page;
      });
    });

//     _controller1.addListener(() {
//       _controller2.animateToPage(
//         _controller1.page.toInt(),
//         duration: Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     });
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("How are you feeling?",
              style: Theme.of(context).textTheme.headline2),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 15),
                child: GestureDetector(
                  onTap: () async {
                    _addNewMoodEntry();

                    if (oneEntry.eachMood.isEmpty) {
                      //display a pop up saying "please add at least one emotion!

                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    } else {
                      //if a person presses "Next", he goes to the next screen to rate the strength of his/her emotions
                      await Navigator.pushNamed(context, "/logmood3");

                      //TODO: I want this part to re-load when new emotion is added
                      GraphScreen();
                      //delete all previous
                      moodSelection.clear();
                    }
                  },
                  child: Text(
                    "Next",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )),
          ],
        ),
        body: Stack(
          children: [
            GestureDetector(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller1,
                itemBuilder: (context, index) {
                  final index2 = index - 4242 + indexOfBigEmotion;
                  return displayWidgets[index2 % (displayWidgets.length)];
                },
              ),
            ),
            /*Align(
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                scale: 1.2,
                child: Container(
                  height: queryData.size.height * 0.80,
                  decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.light)
                          ? Colors.white
                          : Colors.black87,
                      borderRadius: BorderRadius.circular(200)),
                ),
              ),
            ),


             */
            Align(
              child: CustomPaint(
                size: Size(queryData.size.width, (queryData.size.width * 2.5).toDouble()),
                //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(color:  (Theme.of(context).brightness == Brightness.light)
                    ? Colors.white
                    : Colors.black87,),
              ),
            ),
            Column(
              children: [
                SizedBox(),
                Expanded(
                  child: Container(
                    //margin: EdgeInsets.all(30),
                    child: GestureDetector(
                      child: PageView.builder(
                        controller: _controller2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final index2 = index - 4242 + indexOfBigEmotion;

                          return displayInnerWidgets[
                              index2 % (displayInnerWidgets.length)];
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
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

class RPSCustomPainter extends CustomPainter {

  Color color;

  RPSCustomPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0,size.height*0.4006429);
    path0.quadraticBezierTo(size.width*0.1067500,size.height*0.3481857,size.width*0.2548000,size.height*0.3759429);
    path0.cubicTo(size.width*0.4791750,size.height*0.4153571,size.width*0.4656000,size.height*0.3326143,size.width*0.7030000,size.height*0.3781000);
    path0.quadraticBezierTo(size.width*0.8739250,size.height*0.4232000,size.width,size.height*0.3842286);
    path0.lineTo(size.width,size.height);
    path0.lineTo(0,size.height);
    path0.lineTo(0,size.height*0.4006429);
    path0.close();

    canvas.drawPath(path0, paint0);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
