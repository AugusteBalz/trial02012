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

class EmotionSelectionScreen extends StatefulWidget {
  const EmotionSelectionScreen({Key? key}) : super(key: key);

  @override
  _EmotionSelectionScreenState createState() => _EmotionSelectionScreenState();
}

class _EmotionSelectionScreenState extends State<EmotionSelectionScreen> {
  //big number here to ensure infinite scroll to both directions
  PageController controller = PageController(initialPage: 4242);
  var currentPageValue = 0.0;

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

  double? currentPage = 0;



  @override
  void initState() {
    //add
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    super.initState();
  }

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

        /*else {
          //add one new mood
          oneEntry.eachMood.add(OneMood(
              moodPrimary: PrimaryMoods.Happy,
              moodSecondary: SecondaryMoods.happy_cheerful,
              strength: 10,
              color: Colors.yellow));
        }

         */
      }
    });
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
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,

        //if this is left the list is not infinitely scrollable
        // itemCount: displayWidgets.length,
        itemBuilder: (context, index) {
          final index2 = index - 4242+ indexOfBigEmotion;

          controller.addListener(() {
            setState(() {
              currentPageValue = (controller.page)!;
            });
          });





          if (index == currentPageValue.floor()){
            return Transform(
                origin: Offset(
                    120, 700),
                transform: Matrix4.identity()..rotateZ(-(currentPageValue-index)),
                child: displayWidgets[index2 % (displayWidgets.length)]);

          }
          else if (index == currentPageValue.floor()+1){
            return Transform(
                origin: Offset(
                    120, 700),
                transform: Matrix4.identity()..rotateZ(-(currentPageValue-index)),
                child: displayWidgets[index2 % (displayWidgets.length)]);

          }
          else {


            return
                 displayWidgets[index2 % (displayWidgets.length)];

          }






          /*



Transform(
              alignment: Alignment.bottomCenter,
              transform: new Matrix4.identity()
                ..rotateZ(15 * 3.1415927 / 180),
              child: (displayWidgets[index]));


           //anothr
           Transform(

            alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()..rotateX(currentPage! - index),
              child: (displayWidgets[index]));
            */
        },
      ),

      /*
      Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller,
            children: [
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.amber,
              ),
              Container(
                color: Colors.green,
              ),
            ],
          ),
          Container(
            color: Colors.pink.withOpacity(.2),
            child: Text("OverLap Container"),
          ),
          Align(alignment: Alignment(0, .1), child: Text("Another OverLapText")),

          ///THis will controll the PageView
          GestureDetector(
            onTap: () {},
            onPanUpdate: (details) {
              // Swiping in right direction.
              if (details.delta.dx > 0) {
                controller.nextPage(
                    duration: Duration(milliseconds: 200), curve: Curves.easeIn);
              }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                controller.previousPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut);
              }
            },
          )
        ],
      )
      */
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
