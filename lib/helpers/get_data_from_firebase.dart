/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Os extends StatefulWidget {
  const Os({Key? key}) : super(key: key);

  @override
  _OsState createState() => _OsState();
}

class _OsState extends State<Os> {
  get outerMoodDocuments => null;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: outerMoodDocuments.length,
      itemBuilder: (context, index) {



          return Column(
            children: [
              Container(
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
                          DateFormat("MMM d, HH:mm").format(entryTime),
                          //writes out the date
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      /*   Column(
                                //map the list of moods to the widgets
                                //"for each moodlog "md" draw a widget"

                                children:  group.map((md) {
                                  //previous output:
                                  // "SecondaryMood.angry_jealous"
                                  //this leaves it just with "jealous"
/*
                                  String? temp = secondaryMoodToString[md.moodSecondary];
                                  String newMoodS = (temp != null) ? temp : "ERROR";

                                  //same goes with primary moods

                                  String? temp2 =primaryMoodToString[md.moodPrimary];
                                  String newMoodP =(temp2 != null) ? temp2 : "ERROR";

                                  int subStrenght = md.strength;
                                  // String something = "${md.strength}"; // string interpolation?


 */
                                  String newMoodS = "de"; //md['moodSecondary'];
                                  String newMoodP ="de"; // md['moodPrimary'];


                                  //color

                                  PrimaryMoods newMood = primaryMoodToString.keys.firstWhere(
                                          (k) => primaryMoodToString[k] == 'Angry');
                                  //  Color myColor = getColor(newMoodP);

                                  Color? tempColor = primaryColors[newMood];

                                  Color myColor = (tempColor!=null) ? tempColor : Colors.blueGrey;

                                  //displaying widgets

                                  if (Theme.of(context).brightness ==
                                      Brightness.light) {
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //primary mood
                                              Text(
                                                newMoodP,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //secondary mood
                                              Text(
                                                newMoodS,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),

                                              //its strenght
                                              Text(
                                                md['strength'].toString(),
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
                                })
                              ),*/
                    ],
                  ),
                ),
              ),
            ],
          );
        }





        /*Container(


                    child:
                    Text(eachOuterMoodDocument['id'].toString()),


                    // Text('du'),
                  );


                     */
      },
    );
  }
}

 */
