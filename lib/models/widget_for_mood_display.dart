import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood_select.dart';
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

        //white half circle
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.scale(
            scale: 1.7,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(200)),
            ),
          ),
        ),


        Column(
          children: [

            //name of the emotion

            Container(
                margin: const EdgeInsets.only(top: 200),
                child: Center(child: Text(newMood.moodP))),


            // display secondary emotions

            SingleChildScrollView(
              child: Container(

                margin: const EdgeInsets.only(left : 25, right : 25, top: 130, bottom : 10),
                child: DisplayMultiSelection(items: newMood, selectedChoices: moodSelection,),
              ),
            ),

          ],
        ),


      ]),
    );
  }
}
