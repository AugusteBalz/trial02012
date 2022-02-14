import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/widgets/mood/display_one_slider.dart';

class LogMoodScreen3 extends StatefulWidget {
  const LogMoodScreen3({Key? key}) : super(key: key);

  @override
  State<LogMoodScreen3> createState() => _LogMoodScreen3State();
}

var userId;


class _LogMoodScreen3State extends State<LogMoodScreen3> {



  CollectionReference moodCollection = FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('MoodEntries');

  Future<void> addAMood() {
    // Call the user's CollectionReference to add a new user

    List<Map<String, dynamic>> temporaryArray = [];

    for (OneMood mood in oneEntry.eachMood) {
      temporaryArray.add({
        'moodPrimary': primaryMoodToString[mood.moodPrimary],
        'moodSecondary': secondaryMoodToString[mood.moodSecondary],
        'strength': mood.strength,
      });
    }

    return moodCollection
        .add({
          'id': oneEntry.id, // John Doe
          'dateTime': Timestamp.fromDate(oneEntry.dateTime), // Stokes and Sons

          'OneMood': temporaryArray,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void _addNewMoodEntryFinal() async {
    //TODO: does not work adding items to database
    //  await DBHelper.insert('user_mood_database2.db', oneEntry.toListOfMaps());

    setState(() {
      //puts it reversed
      moodEntryList.insert(0, oneEntry);
    });
  }

  // double currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {

   // getUserId();


    return Scaffold(
      appBar: AppBar(
        title: Text("How strong are these emotions?",
            style: Theme.of(context).textTheme.headline2),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  _addNewMoodEntryFinal();

                  addAMood();

                  //TODO: make it work!!!! details: after logging a mood person should be forwarded to "history" tab

                  /*  setState(() {
                      BottomNavi().changePage(2);

                    });


                  HomePage();

                   */
                },
                child: Text(
                  "Done",
                  style: Theme.of(context).textTheme.headline3,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              //TODO: make it stretch
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: oneEntry.eachMood.map((md) {
                //previous output:
                // "SecondaryMood.angry_jealous"
                //this leaves it just with "jealous"

                //previous output:
                // "SecondaryMood.angry_jealous"
                //this leaves it just with "jealous"

                String? temp = secondaryMoodToString[md.moodSecondary];
                String newMoodS = (temp != null) ? temp : "ERROR";

                //same goes with primary moods

                String? temp2 = primaryMoodToString[md.moodPrimary];
                String newMoodP = (temp2 != null) ? temp2 : "ERROR";

                //color

                Color myColor = md.color;

                //displaying widgets

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

                            DisplayOneSlider(md: md),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
