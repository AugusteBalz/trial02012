import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/widgets/mood/display_multi_selection.dart';

List<String> selectedChoices = [];


class WidgetForMoodDisplay extends StatelessWidget {
  final MoodSelect newMood;


  const WidgetForMoodDisplay({Key? key, required this.newMood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Container(
      color: newMood.color,

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
