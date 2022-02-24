import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/widgets/mood/display_multi_selection.dart';

List<String> selectedChoices = [];


class WidgetForMoodDisplay extends StatelessWidget {
  final MoodSelect newMood;
  final Color colorToLeft;
  final Color colorToRight;



  const WidgetForMoodDisplay({Key? key, required this.newMood, required this.colorToLeft, required this.colorToRight })
      : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Container(
      decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            stops: [
              0.05,
              0.5,
              0.95,
            ],
            colors: [
              colorToLeft,
              newMood.color,
              colorToRight,
            ],
          )),

      child: Stack(children: [

        Column(
          children: [

            //name of the emotion

            Container(
                margin: const EdgeInsets.only(top: 200),
                child: Center(child: Text(newMood.moodP))),


          ],
        ),


      ]),
    );
  }
}
