import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/mood_entries.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/one_mood.dart';

import 'package:trial0201/widgets/graphs/pie_chart_2.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial0201/widgets/no_items_yet/no_moods_yet.dart';

Map< DateTime,List<OneMood>> mapOfMonths = {};
bool empty = true;

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {

  List<OneMood> convertToOneMood(List<dynamic> document, List<OneMood> dummy) {

    //this function takes in List<dynamic> from the firebase and converts it to List of OneMoods

    for (var element in document) {
      PrimaryMoods newMood = primaryMoodToString.keys
          .firstWhere((k) => primaryMoodToString[k] == element['moodPrimary']);

      SecondaryMoods newMood2 = secondaryMoodToString.keys
          .firstWhere((k) => secondaryMoodToString[k] == element['moodSecondary']);


      //  Color myColor = getColor(newMoodP);

      Color? tempColor = primaryColors[newMood];

      Color myColor = (tempColor != null) ? tempColor : Colors.blueGrey;

      dummy.add(OneMood(
        moodPrimary: newMood,
        moodSecondary: newMood2,
        strength: element['strength'],
        color: myColor,
      ));
    }



    return dummy;
  }

 void getData() async {

    final user = FirebaseAuth.instance.currentUser!;

    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('users').doc(user.uid).collection('MoodEntries');



    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();



    allData2.clear();

    // Get data from docs and convert map to List
    querySnapshot.docs
        .map((document) => {
      allData2.add(MoodEntry(
        id: document['id'],
        dateTime: (document['dateTime'] as Timestamp).toDate(),
        eachMood: convertToOneMood(document["OneMood"], []),
      ))
    })
        .toList();

    if(allData2.isNotEmpty){
      empty = false;
    }


    setState(() {

    });




  }

  @override
  void initState() {
    getData();
    super.initState();

  }




  @override
  Widget build(BuildContext context) {

    //TODO: does not work
    //_groupByMonths();

    //getData();

  if(empty){
    return NoMoodsYet();
    }


    else{ return
    SingleChildScrollView(
    child: Container(
    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    padding: EdgeInsets.all(10),
    child: Column(
    children: [

    PieChartSample3(),
    SizedBox(height: 30, ),

    //  LineChartSample1(),
    //PieChartSample2(),
    ],
    )),
    );
  }
  }
}


// Map of datetime/ onemood

void  _groupByMonths(){

  int thisMonth;
  int thisYear;
  DateTime thisDate;

  mapOfMonths.clear();

  for(MoodEntry entry in moodEntryList){

    thisYear = entry.dateTime.year;
    thisMonth = entry.dateTime.month;
    thisDate = DateTime(thisYear, thisMonth);
    OneMood temp;

    if(mapOfMonths.containsKey(thisDate)){

      //if it already contains the key we sort it out
      // mapOfMonths[thisDate]!.addAll(entry.eachMood);

      for(OneMood one in entry.eachMood){

        temp = one;
        mapOfMonths[thisDate]!.add(temp);
        print('help');
      }


    }
    else {
      //if it doesnt contain the key, we add it

      mapOfMonths.putIfAbsent(thisDate, () => entry.eachMood);

      print(thisDate.month);

    }
  }


}