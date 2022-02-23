import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/widgets/widget_for_mood_display_inner.dart';

import '../widget_for_mood_display.dart';

import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/blueprint_mood.dart';
import 'package:trial0201/models/mood/mood_entries.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/screens/graphs.dart';
import 'package:uuid/uuid.dart';

import 'package:trial0201/widgets/widget_for_mood_display.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

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
    WidgetForMoodDisplay(newMood: angrySelection),
    WidgetForMoodDisplay(newMood: scaredSelection),
    WidgetForMoodDisplay(newMood: surpriseSelection),
    WidgetForMoodDisplay(newMood: powerfulSelection),
    Container(
      child: WidgetForMoodDisplay(newMood: happySelection),
    ),
    WidgetForMoodDisplay(newMood: peacefulSelection),
    WidgetForMoodDisplay(newMood: sadSelection),
    WidgetForMoodDisplay(newMood: disgustedSelection),
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
    _controller1 = PageController(viewportFraction: 0.9, initialPage: 4242);
    _controller2 = PageController(viewportFraction: 0.9, initialPage: 4242);

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
                    } else  {
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
        
        children: [GestureDetector(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller1,


            itemBuilder: (context, index) {
              final index2 = index - 4242+ indexOfBigEmotion;
              return
                displayWidgets[index2 % (displayWidgets.length)];

              },

          ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.scale(
              scale:1.8,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black87,
                    borderRadius: BorderRadius.circular(200)),
              ),
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
                          final index2 = index - 4242+ indexOfBigEmotion;

                          return
                            displayInnerWidgets[index2 % (displayInnerWidgets.length)];








                        }








                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
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
