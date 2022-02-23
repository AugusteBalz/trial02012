import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/widgets/mood/display_multi_selection.dart';

List<String> selectedChoices = [];


class WidgetForMoodDisplayInner extends StatelessWidget {
  final MoodSelect newMood;


  const WidgetForMoodDisplayInner({Key? key, required this.newMood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          // display secondary emotions

          SizedBox(height: 40),
          SingleChildScrollView(
            child: Container(

              margin: const EdgeInsets.only(left : 25, right : 25, top: 130, bottom : 10),
              child: DisplayMultiSelection(items: newMood, selectedChoices: moodSelection,),
            ),
          ),

        ],
      ),
    );
  }
}
