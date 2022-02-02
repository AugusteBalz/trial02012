import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/widgets/mood/display_one_slider.dart';



class DisplayMoodSliders extends StatefulWidget {
  const DisplayMoodSliders({Key? key}) : super(key: key);


  @override
  _DisplayMoodSliders createState() => _DisplayMoodSliders();
}

class _DisplayMoodSliders extends State<DisplayMoodSliders> {



  int arraylength= selectedDisplayMoods.length;



  @override
  Widget build(BuildContext context) {
    return Container(child:
        Column(

          children:

          oneEntry.eachMood.map((oneEmotion) {

            oneSubEmotion = oneEmotion;


           // currentSliderValue = sliders.elementAt(0);

            //displaying widgets

            return DisplayOneSlider(md: oneEmotion,);
          }).toList(),


        )
      ,);
  }
}
