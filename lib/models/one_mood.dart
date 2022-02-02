import 'package:flutter/cupertino.dart';

import 'moods.dart';


class OneMood {

  PrimaryMoods moodPrimary;
  SecondaryMoods moodSecondary;
  int strength;
  Color color;

  OneMood({

    required this.moodPrimary,
    required this.moodSecondary,
    required this.strength,
    required this.color,
  });
}