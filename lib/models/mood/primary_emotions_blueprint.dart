import 'package:flutter/cupertino.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/models/mood/moods.dart';

class PrimaryEmotionsBlueprint {
  String emotionName;
  PrimaryMoods emotionP;
  Color color;
  int id;

  PrimaryEmotionsBlueprint({
    required this.emotionName,
    required this.emotionP,
    required this.color,
    required this.id,
  });
}

List<PrimaryEmotionsBlueprint> wholePrimaryEmotionsList = [

  PrimaryEmotionsBlueprint(
    emotionName: "Angry",
    emotionP: PrimaryMoods.Angry,
    color: angryMoodColor,
    id: 0,
  ),
  PrimaryEmotionsBlueprint(
    emotionName: "Scared",
    emotionP: PrimaryMoods.Scared,
    color: scaredMoodColor,
    id: 1,
  ),
  PrimaryEmotionsBlueprint(
    emotionName: "Surprised",
    emotionP: PrimaryMoods.Surprised,
    color: surprisedMoodColor,
    id: 2,
  ),

  PrimaryEmotionsBlueprint(
    emotionName: "Powerful",
    emotionP: PrimaryMoods.Powerful,
    color: powerfulMoodColor,
    id: 3,
  ),
  PrimaryEmotionsBlueprint(
    emotionName: "Happy",
    emotionP: PrimaryMoods.Happy,
    color: happyMoodColor,
    id: 4,
  ),
  PrimaryEmotionsBlueprint(
    emotionName: "Peaceful",
    emotionP: PrimaryMoods.Peaceful,
    color: peacefulMoodColor,
    id: 5,
  ),
  PrimaryEmotionsBlueprint(
    emotionName: "Sad",
    emotionP: PrimaryMoods.Sad,
    color: sadMoodColor,
    id: 6,
  ),
  PrimaryEmotionsBlueprint(
    emotionName: "Disgusted",
    emotionP: PrimaryMoods.Disgusted,
    color: disgustedMoodColor,
    id: 7,
  ),

];
