
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/models/mood/mood_select.dart';

/*
taken from
https://github.com/ponnamkarthik/MultiSelectChoiceChip
 */

List<String> helo = ['relationship', 'career', 'education', 'family', 'physical symptoms', 'financial', 'home', 'adventure', 'other', 'travel'];

class MultiSelectChipForTags extends StatefulWidget {

  final Function(List<String>)? onSelectionChanged;
  final List<String> selectedChoices;

  MultiSelectChipForTags({this.onSelectionChanged, required this.selectedChoices});

  @override
  _MultiSelectChipForTagsState createState() => _MultiSelectChipForTagsState();
}

class _MultiSelectChipForTagsState extends State<MultiSelectChipForTags> {
  // String selectedChoice = "";


  _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in helo) {

      choices.add(Container(
       // padding: const EdgeInsets.all(2.0),
      //  height: 35,
        child: Transform(
          transform: new Matrix4.identity()..scale(0.8),
          child: ChoiceChip(
            label: Text("# " + item, style: Theme.of(context).textTheme.headline4,),
            selected: widget.selectedChoices.contains(item),

            backgroundColor: Colors.transparent,
           // shape: StadiumBorder(side: BorderSide(
            //  color: Colors.blueGrey,)),
            selectedColor: Colors.white10,
            selectedShadowColor: Colors.orange,
            elevation: 6,
            onSelected: (selected) {

                setState(() {
                  widget.selectedChoices.contains(item)
                      ? widget.selectedChoices.remove(item)
                      : widget.selectedChoices.add(item);
                  widget.onSelectionChanged?.call(widget.selectedChoices);
                });

            },
          ),
        ),
      ));
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 0.0, // gap between adjacent chips
        runSpacing: 0.0, // gap between lines
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _buildChoiceList(),
      ),
    );
  }
}