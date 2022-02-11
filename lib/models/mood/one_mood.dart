import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/matching_maps.dart';

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


/*
  List<
      QueryDocumentSnapshot<Map<String, dynamic>>> fromListOfOneMoodsToFirebase(
      List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> temp = [];

    for (Map item in data) {
      temp.add({

      //one mood
      'primaryMood': item.,
      'secondaryMood': eachMood[i].moodSecondary.toString(),
    'strength': eachMood[i].strength,
    'color': eachMood[i].color.toString(),
    });

    }
//TODO : FIX HERE


    return
    temp;
  }

 */
}






