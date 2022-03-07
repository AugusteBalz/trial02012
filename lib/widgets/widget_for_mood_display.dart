import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/widgets/mood/display_multi_selection.dart';

List<String> selectedChoices = [];

MediaQueryData queryData = new MediaQueryData();

class WidgetForMoodDisplay extends StatelessWidget {
  final MoodSelect newMood;
  final Color colorToLeft;
  final Color colorToRight;



  const WidgetForMoodDisplay(
      {Key? key,
      required this.newMood,
      required this.colorToLeft,
      required this.colorToRight})
      : super(key: key);




  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
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
            Container(
            //  color: Colors.pinkAccent,
              height: queryData.size.height* 0.25,
              width: queryData.size.width * 0.25,
            ),

            //name of the emotion

            Container(

                margin: const EdgeInsets.only( left: 20, right: 20), //top: 200,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 15,
                    ),
                    Text(newMood.moodP),
                    Icon(
                      Icons.arrow_forward,
                      size: 15,
                    ),
                  ],
                ))),
          ],
        ),
      ]),
    );
  }
}
