import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood_entries.dart';
import 'package:trial0201/models/one_mood.dart';
import 'package:trial0201/widgets/graphs/line_chart.dart';
import 'package:trial0201/widgets/graphs/pie_chart.dart';
import 'package:trial0201/widgets/graphs/pie_chart_2.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Map< DateTime,List<OneMood>> mapOfMonths = {};

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {


    //TODO: does not work
    //_groupByMonths();


    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: EdgeInsets.all(10),
          child: Column(
        children: const [

          PieChartSample3(),
          SizedBox(height: 30,),

          LineChartSample1(),
          //PieChartSample2(),
        ],
      )),
    );
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