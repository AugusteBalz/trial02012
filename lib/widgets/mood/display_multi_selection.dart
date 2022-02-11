import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/mood_select.dart';

import 'package:trial0201/widgets/mood/multi_select_chip2.dart';

/*
Displays multi selection chips in 1st mood logging screen
 */


class DisplayMultiSelection extends StatefulWidget {
  
  final MoodSelect items;
  final List<String> selectedChoices;

  const DisplayMultiSelection({Key? key, required this.items, required this.selectedChoices}) : super(key: key);

  @override
  _DisplayMultiSelectionState createState() => _DisplayMultiSelectionState();
}

class _DisplayMultiSelectionState extends State<DisplayMultiSelection> {




  @override
  Widget build(BuildContext context) {
    return MultiSelectChip(
      widget.items,
      widget.selectedChoices,

      onSelectionChanged: (selectedList) {
        setState(() {

          //add all selected moods to the list
          selectedDisplayMoods = [...selectedList];

        });
      },


    );
  }
}
