import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/widgets/mood/display_multi_selection.dart';

List<String> selectedChoices = [];


class WidgetForMoodDisplayInnerInStories extends StatelessWidget {
  final MoodSelect newMood;


  const WidgetForMoodDisplayInnerInStories({Key? key, required this.newMood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        child: Container(

          margin: const EdgeInsets.all(5),
          child: DisplayMultiSelection(items: newMood, selectedChoices: moodSelectionForStories,),
        ),
      ),
    );
  }
}
