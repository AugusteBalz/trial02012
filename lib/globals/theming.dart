library mood_as_classes.globals;

import 'package:flutter/material.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/main.dart';
import 'package:trial0201/models/mood/blueprint_mood.dart';
import 'package:trial0201/models/mood/mood_entries.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/globals/mood/constants_of_mood.dart';



int previousIndex = 0; //for theme toggling

ThemeModel currentModel = ThemeModel();

//---


// Define the default `TextTheme`. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.

TextTheme textTextTheme = const TextTheme(
  //for appbar
  headline1: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w200),

  //secondary appbar
  headline2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w200),

  //for additional appbar things (as "done", "next")
  headline3: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),

  //for mood choice chips
  headline4: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w200),

  //for mood choice primary
  headline5: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),


  //for smallest emotions
  headline6: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w200),

  // for smallest emotions appbar things
  bodyText1: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),

  //for bigger sub-emotions
  bodyText2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200),

  //for the date
  subtitle1: TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueGrey),
);