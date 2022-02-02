
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/models/mood_select.dart';

/*
taken from
https://github.com/ponnamkarthik/MultiSelectChoiceChip
 */

class MultiSelectChip extends StatefulWidget {
  final MoodSelect reportList;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;
  final List<String> selectedChoices;

  MultiSelectChip(this.reportList, this.selectedChoices, {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";


  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.moodS.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: FilterChip(
          label: Text(item, style: Theme.of(context).textTheme.headline4,),
          selected: widget.selectedChoices.contains(item),

          backgroundColor: Colors.transparent,
         // shape: StadiumBorder(side: BorderSide(
          //  color: Colors.blueGrey,)),
          selectedColor: Colors.white10,
          selectedShadowColor: widget.reportList.color,
          elevation: 10,
          onSelected: (selected) {

              setState(() {
                widget.selectedChoices.contains(item)
                    ? widget.selectedChoices.remove(item)
                    : widget.selectedChoices.add(item);
                widget.onSelectionChanged?.call(widget.selectedChoices);
              });

          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _buildChoiceList(),
      ),
    );
  }
}