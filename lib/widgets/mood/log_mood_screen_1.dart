import 'package:flutter/material.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/primary_emotions_blueprint.dart';
import 'package:trial0201/widgets/mood/circle_display.dart';



//TODO: add a colour wheel to select emotions

class LogMoodScreen1 extends StatefulWidget {
  const LogMoodScreen1({Key? key}) : super(key: key);

  @override
  State<LogMoodScreen1> createState() => _LogMoodScreen1State();
}

class _LogMoodScreen1State extends State<LogMoodScreen1> {
  PrimaryEmotionsBlueprint selectionOfPrimaryEmotion = PrimaryEmotionsBlueprint(
      emotionName: "Disgusted", emotionP: PrimaryMoods.Disgusted, color: disgustedMoodColor, id : 0,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Right now I am feeling...",
            style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        //TODO: show the back button properly
        //systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        alignment: Alignment.center,
        child: Stack(children: [


          Positioned(
            child: const Icon(
              Icons.zoom_out_map_outlined,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            top: 130,
            left: 153,
          ),
          Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: wholePrimaryEmotionsList.map((oneEmotionName) {
              selectionOfPrimaryEmotion = oneEmotionName;

              // currentSliderValue = sliders.elementAt(0);


              double left = 0;
              double top = 0;
              double right = 0;
              double bottom = 0;

              List<double>? temp = moodToPosition[selectionOfPrimaryEmotion.emotionP];
              if (temp !=null){
                left = temp.elementAt(0);
                top = temp.elementAt(1);
                // right = temp.elementAt(2);
                //bottom = temp.elementAt(3);
              }


              //displaying widgets

              return new Positioned(
                child: new CircleButton(onTap: () {

                }, selectionOfPrimaryEmotion: selectionOfPrimaryEmotion),
                top: top,
                left: left,
                //right: right,
                //bottom: bottom,
              );
              //WidgetForPrimaryEmotionDisplay(selectionOfPrimaryEmotion: selectionOfPrimaryEmotion);
            }).toList(),
          ),
        ],

        ),
      ),
    );
  }
}
