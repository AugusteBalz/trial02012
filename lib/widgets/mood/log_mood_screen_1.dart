import 'package:flutter/material.dart';
import 'package:trial0201/globals/colors_of_mood.dart';
import 'package:trial0201/models/moods.dart';
import 'package:trial0201/models/primary_emotions_blueprint.dart';
import 'package:trial0201/widgets/widget_for_primary_emotion_display.dart';


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: wholePrimaryEmotionsList.map((oneEmotionName) {
            selectionOfPrimaryEmotion = oneEmotionName;

            // currentSliderValue = sliders.elementAt(0);

            //displaying widgets

            return WidgetForPrimaryEmotionDisplay(
                selectionOfPrimaryEmotion: selectionOfPrimaryEmotion);
          }).toList(),
        ),
      ),
    );
  }
}
