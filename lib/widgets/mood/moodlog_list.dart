import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/colors_of_mood.dart';
import 'package:trial0201/globals/globals.dart';

import 'package:intl/intl.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trial0201/main.dart';

//TODO: add the ability to delete an entry

class MoodLogList extends StatelessWidget {
  const MoodLogList({Key? key}) : super(key: key);

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



    List<Object?> items = [];
    return Column(
      children: [
        Container(
          color: Colors.yellowAccent,
          height: 60,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
              'Users/3oD3lMeJuQr7UJ84aHp2/MoodEntries')
              .snapshots(),
          builder: (context, AsyncSnapshot<
              QuerySnapshot<Map<String, dynamic>>> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (streamSnapshot.hasError) {
              return Text("something went wrong");
            } else if (streamSnapshot.connectionState ==
                ConnectionState.done) {
              return Text('done');
            } else {
              final outerMoodDocuments = streamSnapshot.data!.docs;
              final outerMoodDocuments2 = streamSnapshot.data!.docs;

              //outerMoodDocuments.

              print('testing1');



              outerMoodDocuments.map( (e){

                print('testing2');
                return StreamBuilder(
                    stream: e.reference.collection('OneEntry').snapshots(),


                    builder: (context2,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        innerStreamSnapshot) {
                      print('testing3');
                      return Text('o');
                    }


                );
              });


                /*
                outerMoodDocuments2.forEach((element) {

                  element.reference.snapshots();

                  return StreamBuilder(

                      builder: context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> innerDtreamSnapshot);


                });

                 */


                return ListView.builder(
                shrinkWrap: true,
                itemCount: outerMoodDocuments.length,
                itemBuilder: (context, index) {
                  final eachOuterMoodDocument = outerMoodDocuments[index];

                  //eachOuterMoodDocument.co

                  print(eachOuterMoodDocument.data().toString());


                  return Container(


                    child:
                    Text(eachOuterMoodDocument['id'].toString()),


                    // Text('du'),
                  );
                },

              );
            }
/*
              if (streamSnapshot.connectionState == ConnectionState.active) {

               final documents = streamSnapshot.data;

               if (streamSnapshot.hasData) {
                 return ListView.builder(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,

                   itemBuilder: (context, index) =>
                       Container(
                         padding: EdgeInsets.all(10),
                         height: 40,
                         child: Text(documents![index]['j']),

                         //TODO: here????
                       ),
                   itemCount: streamSnapshot.data.docs.length,

                 );
               }
              }
              return Text("error");

 */
          },),
        Column(
          //map the list of transactions to the widgets
          //"for each moodlog "md" draw a widget"

          children: moodEntryList.map((entry) {
            //take off the time from the map key

            DateTime entryTime = entry.dateTime;

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
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                          ),
                        ),
                        Column(
                          //map the list of moods to the widgets
                          //"for each moodlog "md" draw a widget"

                          children: entry.eachMood.map((md) {
                            //previous output:
                            // "SecondaryMood.angry_jealous"
                            //this leaves it just with "jealous"

                            String? temp =
                            secondaryMoodToString[md.moodSecondary];
                            String newMoodS = (temp != null) ? temp : "ERROR";

                            //same goes with primary moods

                            String? temp2 = primaryMoodToString[md.moodPrimary];
                            String newMoodP = (temp2 != null) ? temp2 : "ERROR";

                            int subStrenght = md.strength;
                            // String something = "${md.strength}"; // string interpolation?

                            //color

                            
                          //  Color myColor = getColor(newMoodP);
                            Color myColor = md.color;

                            //displaying widgets
                            
                            if (Theme.of(context).brightness == Brightness.light){
                              
                             // myColor = myColor.withOpacity(0.7);
                             myColor =  HSLColor.fromColor(myColor).withLightness(0.4).withSaturation(1).toColor();
                            }
                            else{
                            //  myColor = Color.alphaBlend( Colors.white.withOpacity(0.2), myColor);
                            //  myColor = myColor.withOpacity(0.7);
                              myColor = HSLColor.fromColor(myColor).withLightness(0.65).withSaturation(1).toColor();
                            }

                            return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          style: Theme
                                              .of(context)
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        //secondary mood
                                        Text(
                                          newMoodS,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText2,
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
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}


