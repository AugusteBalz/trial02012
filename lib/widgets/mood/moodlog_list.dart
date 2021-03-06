
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/widgets/no_items_yet/no_moods_yet.dart';

//TODO: add the ability to delete an entry

var userId;

class MoodLogList extends StatelessWidget {
  const MoodLogList({Key? key}) : super(key: key);

  Future<void> getUserId() async {
    userId = await FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
/*
    Color getColor(String name) {
      //red is just a sample color
      Color color;

      switch(name) {
        case "Happy": {
          color =  Theme.of(context).colorScheme.happy;
        }
        break;

        case "Sad": {
          color =  Theme.of(context).colorScheme.sad;
        }
        break;

        case "Angry": {
          color =  Theme.of(context).colorScheme.angry;
        }
        break;

        case "disgusted": {
          color =  Theme.of(context).colorScheme.disgusted;
        }
        break;
        case "surprised": {
          color =  Theme.of(context).colorScheme.surprised;
        }
        break;

        case "scared": {
          color =  Theme.of(context).colorScheme.scared;
        }
        break;

        case "powerful": {
          color =  Theme.of(context).colorScheme.powerful;
        }
        break;

        case "peaceful": {
          color =  Theme.of(context).colorScheme.peaceful;
        }
        break;

        default: {
          color = Colors.grey;
        }
        break;
      }



      return color;
    }




 */

    //   getUserId();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('MoodEntries')
                .orderBy('dateTime', descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (streamSnapshot == null) {
                return const Text('done');
              } else if (streamSnapshot.hasError) {
                return Text("something went wrong");
              } else if (streamSnapshot.connectionState ==
                  ConnectionState.done) {
                return Text('done');
              } else if (!streamSnapshot.hasData) {
                return NoMoodsYet();
              } else {
                final outerMoodDocuments = streamSnapshot.data!.docs;

                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: outerMoodDocuments.length,
                    itemBuilder: (context, index) {
                      final eachOuterMoodDocument = outerMoodDocuments[index];

                      //Datetime
                      DateTime entryTime =
                          (eachOuterMoodDocument['dateTime'] as Timestamp)
                              .toDate();

                      String id = eachOuterMoodDocument['id'];

                      List<dynamic> group =
                          eachOuterMoodDocument.get("OneMood") as List<dynamic>;

                      return
                          DisplaySubEmotionHistory(
                        group: group,
                        entryTime: entryTime,
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }
}

class DisplaySubEmotionHistory extends StatefulWidget {
  final List<dynamic> group;
  final DateTime entryTime;

  const DisplaySubEmotionHistory(
      {Key? key, required this.group, required this.entryTime})
      : super(key: key);

  @override
  _DisplaySubEmotionHistoryState createState() =>
      _DisplaySubEmotionHistoryState();
}

class _DisplaySubEmotionHistoryState extends State<DisplaySubEmotionHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: Text(
                DateFormat("MMM d, HH:mm").format(widget.entryTime),
                //writes out the date
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Column(
              //map the list of moods to the widgets
              //"for each moodlog "md" draw a widget"

              children: widget.group.map((md) {
                //previous output:
                // "SecondaryMood.angry_jealous"
                //this leaves it just with "jealous"

                String newMoodP = md['moodPrimary'];
                String newMoodS = md['moodSecondary'];

                int subStrenght = md['strength'];

                PrimaryMoods newMood = primaryMoodToString.keys
                    .firstWhere((k) => primaryMoodToString[k] == newMoodP);
                //  Color myColor = getColor(newMoodP);

                Color? tempColor = primaryColors[newMood];

                Color myColor =
                    (tempColor != null) ? tempColor : Colors.blueGrey;
                //displaying widgets

                if (Theme.of(context).brightness == Brightness.light) {
                  // myColor = myColor.withOpacity(0.7);
                  myColor = HSLColor.fromColor(myColor)
                      .withLightness(0.4)
                      .withSaturation(1)
                      .toColor();
                } else {
                  //  myColor = Color.alphaBlend( Colors.white.withOpacity(0.2), myColor);
                  //  myColor = myColor.withOpacity(0.7);
                  myColor = HSLColor.fromColor(myColor)
                      .withLightness(0.65)
                      .withSaturation(1)
                      .toColor();
                }

                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //primary mood
                            Text(
                              newMoodP,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: myColor,
                                  ),
                            ),

                            //the date
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //secondary mood
                            Text(
                              newMoodS,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),

                            //its strenght
                            Text(
                              subStrenght.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: myColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
