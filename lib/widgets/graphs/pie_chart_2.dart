import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/main.dart';
import 'package:trial0201/models/mood_entries.dart';
import 'package:trial0201/models/moods.dart';
import 'package:trial0201/models/one_mood.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)

Map<PrimaryMoods, double> countingPrimaryOccurencesDefault = {};
Map<PrimaryMoods, double> countingPrimaryOccurences = {};

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
    calculateMonthlyStats();
    findMostCommonEmotion();

    return List.generate(countingPrimaryOccurences.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 45.0 : 30.0;
      final textSize = isTouched ? 14.0 : 10.0;

      double value = countingPrimaryOccurences.values.elementAt(i);

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
          size: widgetSize,
          textsize: textSize,
          borderColor: coloredBy2,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }
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

void calculateMonthlyStats() {
  List<MoodEntry> thisMonthsEntries = [];
  int thisMonthNumber = DateTime.now().month;

  //we select only moods that were added this month

  for (MoodEntry entry in moodEntryList) {
    if (thisMonthNumber == entry.dateTime.month) {
      thisMonthsEntries.add(entry);
    }
  }

  //we clean anything that was here before
  countingPrimaryOccurences.clear();
  wholeMonthsCount = 0;

  //make a list in order by color

  primaryColors.forEach((key, value) {
    countingPrimaryOccurences.putIfAbsent(key, () => 0);
  });

  for (MoodEntry entry in thisMonthsEntries) {
    for (OneMood mood in entry.eachMood) {
      if (countingPrimaryOccurences.containsKey(mood.moodPrimary)) {
        double? k = countingPrimaryOccurences[mood.moodPrimary];
        if (k == null) {
          //if its null we add a new count
          k = 1;
        } else {
          //if its not null we increase the count by one
          k = k + 1;
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
