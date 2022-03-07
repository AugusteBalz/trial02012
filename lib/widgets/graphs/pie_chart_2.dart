import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';

import 'package:trial0201/models/mood/mood_entries.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/one_mood.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)

Map<PrimaryMoods, double> countingPrimaryOccurencesDefault = {};
Map<PrimaryMoods, double> countingPrimaryOccurences = {};




Map<int, Map<int, List<List<OneMood>>>> maptoMonths = {};

int wholeMonthsCount = 0;

PrimaryMoods mostPopularMood = PrimaryMoods.Scared;
String moodOfTheMonth3 = '';
Color colorOfTheMonth = Colors.cyanAccent;

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  int touchedIndex = 0;






  @override
  Widget build(BuildContext context) {


// GETS DATA FROM THE FIREBASE
    print('this1.5');

    groupByMonths(); // sorts it out by months

    calculateMonthlyStats(2022, 3);

    print('this2');
    findMostCommonEmotion();



    print('this3');

    // tidyUpTheData();

    return Column(
      children: [
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 2,
                  centerSpaceRadius: 0,
                  sections: showingSections()),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'The most common emotion of this month is '),
                  TextSpan(
                      text: moodOfTheMonth3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorOfTheMonth,
                      )),
                ],
              ),
            )),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {



    return List.generate(countingPrimaryOccurences.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 45.0 : 30.0;
      final textSize = isTouched ? 14.0 : 10.0;

double value;
       value = countingPrimaryOccurences.values.elementAt(i);

       if (wholeMonthsCount == null || wholeMonthsCount == 0){
        print('We count WholeMonthsCount from 1');
       wholeMonthsCount=1;
       //getData();
       }
       print(value);
       print(wholeMonthsCount);

      //show right percentage
      String name = (value / wholeMonthsCount * 100).round().toString();

      Color? coloredBy =
          primaryColors[countingPrimaryOccurences.keys.elementAt(i)];

      Color coloredBy2 = (coloredBy != null) ? coloredBy : Colors.grey;

      Color coloredBy3 =
          Color.alphaBlend(Colors.black26.withOpacity(0.15), coloredBy2);

      //get the correct title

      String? title =
          primaryMoodToString[countingPrimaryOccurences.keys.elementAt(i)];


      print(title);


      String title2 = (title != null) ? title : "Error";

      return PieChartSectionData(
        color: coloredBy3,
        value: value,
        title: name + '%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize - 1,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
        badgeWidget: _Badge(
          title2,
          size: widgetSize+3+1,
          textsize: textSize,
          borderColor: coloredBy2,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }

  /*

  void sortOutByMonths() {
    DateTime entryTime;
    print('d');

    Map<Months, Map<String, dynamic>> tempMap = {};

    maptoMonths.clear();



    if (outerMoodDocuments == null){

      return;
    }

    for (QueryDocumentSnapshot document in outerMoodDocuments) {
      document.id;
      print(document['id']);
      entryTime = (document['dateTime'] as Timestamp).toDate();

      int entryYear = entryTime.year;
      int entryMonth = entryTime.month;

      List<QueryDocumentSnapshot> dummyList = [];
      dummyList.add(document);

      if (!maptoMonths.containsKey(entryYear)) {
        // if it doesnt contain both the year and the month,
        // we add both the year and the month
        Map<int, List<QueryDocumentSnapshot>> dummyMonth = {};


        dummyMonth.putIfAbsent(entryMonth, () => dummyList);

        maptoMonths.putIfAbsent(entryYear, () => dummyMonth);

      } else {
        //if it contains the year, but not the month, we update

        if (!(maptoMonths[entryYear]!.containsKey(entryMonth))) {
          //we add a new month to the existing year

          maptoMonths[entryYear]!.putIfAbsent(entryMonth, () => dummyList);
        }
        else {

          //this is the case where it contains both


          maptoMonths[entryYear]![entryMonth]!.add(document);




        }

      }
    }
  }
  */




}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final double textsize;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.textsize,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size * 2,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,

        //TODO: do proper sizing of the boxes
        // shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text(
          svgAsset,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: textsize,
              ),
          //fit: BoxFit.contain,
        ),
      ),
    );
  }
}

void calculateMonthlyStats(thisYearNumber, thisMonthNumber) {
  List<List<OneMood>> thisMonthsEntries = [];

  //TODO: THIS!!!!
 // int thisMonthNumber = 2;
 // int thisYearNumber = 2022;

  thisMonthsEntries.clear();
  //we select only moods that were added this month

  if(maptoMonths.containsKey(thisYearNumber)) {
    if (maptoMonths[thisYearNumber]!.containsKey(thisMonthNumber)) {
      if (maptoMonths[thisYearNumber]![thisMonthNumber] != null) {
        maptoMonths[thisYearNumber]![thisMonthNumber]!.forEach((element) {
          thisMonthsEntries.add(element);
         // print(element);
        });
      }
    }
  }



  //we clean anything that was here before
  countingPrimaryOccurences.clear();
  wholeMonthsCount = 0;

  //make a list in order by color

  primaryColors.forEach((key, value) {
    countingPrimaryOccurences.putIfAbsent(key, () => 0);
  });

  for (List<OneMood> entry in thisMonthsEntries) {
  //  print('no work');
    for (OneMood mood in entry) {
      if (countingPrimaryOccurences.containsKey(mood.moodPrimary)) {
        double? k = countingPrimaryOccurences[mood.moodPrimary];
        if (k == null) {
          //if its null we add a new count
          k = 1;
        } else {
          //if its not null we increase the count by one
          k = k + 1;
          print(mood.moodPrimary);
          print(k);
        }

        //we add a new count
        countingPrimaryOccurences[mood.moodPrimary] = k;
      } else {
        //if its empty we add 1
        countingPrimaryOccurences.putIfAbsent(mood.moodPrimary, () => 1);
      }

      wholeMonthsCount = wholeMonthsCount + 1;
    }
  }
}

void findMostCommonEmotion() {
  double maxi = 0;

  for (PrimaryMoods mood in countingPrimaryOccurences.keys) {
    double? temp = countingPrimaryOccurences[mood];

    if (temp != null && temp > maxi) {
      maxi = temp;
      mostPopularMood = mood;
    }
  }

  displayMostPopularMood();
}

void displayMostPopularMood() {
  // TODO: edit the theming of words
  String? moodOfTheMonth = primaryMoodToString[mostPopularMood];
  String moodOfTheMonth2 = (moodOfTheMonth != null) ? moodOfTheMonth : "Error";
  moodOfTheMonth3 = moodOfTheMonth2;

  Color? colorz = primaryColors[mostPopularMood];
  colorOfTheMonth = (colorz != null) ? colorz : Colors.teal;
}

void groupByMonths() {
  int thisMonth;
  int thisYear;
  DateTime thisDate;

  maptoMonths.clear();

/*
  for (MoodEntry entry in allData2) {
    thisYear = entry.dateTime.year;
    thisMonth = entry.dateTime.month;
    thisDate = DateTime(thisYear, thisMonth);
    OneMood temp;

    if (mapOfMonths.containsKey(thisDate)) {
      //if it already contains the key we sort it out
      // mapOfMonths[thisDate]!.addAll(entry.eachMood);

      for (OneMood one in entry.eachMood) {
        temp = one;
        mapOfMonths[thisDate]!.add(temp);
        print('help');
      }
    } else {
      //if it doesnt contain the key, we add it

      mapOfMonths.putIfAbsent(thisDate, () => entry.eachMood);

      print(thisDate.month);
    }
  }
 */



  for (MoodEntry entry in allData2) {

    thisYear = entry.dateTime.year;
    thisMonth = entry.dateTime.month;
    thisDate = DateTime(thisYear, thisMonth);
    OneMood temp;
    List<List<OneMood>> dummyList = [];
    Map<int, List<List<OneMood>>> dummyMonth = {};

    dummyList.add(entry.eachMood);

    if (!maptoMonths.containsKey(thisYear)) {
      // if it doesnt contain both the year and the month,
      // we add both the year and the month





      dummyMonth.putIfAbsent(thisMonth, () => dummyList);

      maptoMonths.putIfAbsent(thisYear, () => dummyMonth);

    } else {
      //if it contains the year, but not the month, we update

      if (!(maptoMonths[thisYear]!.containsKey(thisMonth))) {
        //we add a new month to the existing year

        maptoMonths[thisYear]!.putIfAbsent(thisMonth, () => dummyList);
      }
      else {

        //this is the case where it contains both


        maptoMonths[thisYear]![thisMonth]!.add(entry.eachMood);





      }

    }

    print (maptoMonths);
  }
}

class WidgetDisplayMonthGraph extends StatefulWidget {
  var outerMoodDocuments;

  WidgetDisplayMonthGraph(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> outerMoodDocuments,
      {Key? key})
      : super(key: key);

  @override
  _WidgetDisplayMonthGraphState createState() =>
      _WidgetDisplayMonthGraphState();
}

class _WidgetDisplayMonthGraphState extends State<WidgetDisplayMonthGraph> {
  @override
  Widget build(BuildContext context) {
    return Container();

    //TODO: Implement later


  }
}
