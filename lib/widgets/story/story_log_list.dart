import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/globals/globals.dart';

import 'package:intl/intl.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trial0201/main.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/widgets/no_items_yet/no_stories_yet.dart';
import 'package:trial0201/widgets/pickers/image_display_story_pic.dart';
import 'package:trial0201/widgets/pickers/image_picker_for_stories.dart';

//TODO: add the ability to delete an entry

class StoryLogList extends StatelessWidget {
  const StoryLogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(


      //TODO : make it flexible

      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('StoryEntries')
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return Text("something went wrong");
          } else if (streamSnapshot.connectionState == ConnectionState.done) {
            return Text('done');
          }

          else {

            final outerStoryDocuments = streamSnapshot.data!.docs;

            if(outerStoryDocuments.isEmpty){
              return NoStoriesYet();
            }

            return

                //ListTile(title: Text("o"),);

                Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: outerStoryDocuments.length,
                      itemBuilder: (context, index) {
                        final eachOuterStoryDocument =
                            outerStoryDocuments[index];

                        return DisplayOneStory(eachOuterStoryDocument: eachOuterStoryDocument);



                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}


class DisplayOneStory extends StatefulWidget {

  final QueryDocumentSnapshot<Map<String, dynamic>> eachOuterStoryDocument;

  const DisplayOneStory({Key? key,required this.eachOuterStoryDocument}) : super(key: key);

  @override
  _DisplayOneStoryState createState() => _DisplayOneStoryState();
}

class _DisplayOneStoryState extends State<DisplayOneStory> {

  var url;

  @override
  Widget build(BuildContext context) {
      //Datetime
      DateTime entryTime =
        (widget.eachOuterStoryDocument['dateTime'] as Timestamp)
            .toDate();

    String title = widget.eachOuterStoryDocument['title'];
    String story = widget.eachOuterStoryDocument['story'];
    List<dynamic> tags = widget.eachOuterStoryDocument['tag'];
    url = widget.eachOuterStoryDocument['image_url'];


    List<dynamic> group = widget.eachOuterStoryDocument
        .get("OneMood") as List<dynamic>;



    String listOfTags = '';

    for (dynamic item in tags){

      listOfTags = listOfTags + '#' + item + ' ';
    }


    return

      //ListTile(title: Text("o"),);

      Container(

        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Stack(
          children: [

            Column(
              children: [
                SizedBox( height: 30),
                Container(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              DateFormat("MMM d, HH:mm")
                                  .format(entryTime),
                              //writes out the date
                              style:
                              Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5),
                                    child: Text(title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3)),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5),
                                    child: Text(story,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5)),

                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5),
                                    child: Text(listOfTags,
                                        style: TextStyle(

                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .headline5!.fontSize,
                                          color: Colors.grey,
                                        ))
                                ),
                              ],
                            ),
                          ),
                          Column(
                            //map the list of moods to the widgets
                            //"for each moodlog "md" draw a widget"

                            children: group.map((md) {
                              //previous output:
                              // "SecondaryMood.angry_jealous"
                              //this leaves it just with "jealous"

                              String newMoodP = md['moodPrimary'];
                              String newMoodS = md['moodSecondary'];

                              int subStrenght = md['strength'];

                              PrimaryMoods newMood = primaryMoodToString
                                  .keys
                                  .firstWhere((k) =>
                              primaryMoodToString[k] ==
                                  newMoodP);
                              //  Color myColor = getColor(newMoodP);

                              Color? tempColor = primaryColors[newMood];

                              Color myColor = (tempColor != null)
                                  ? tempColor
                                  : Colors.blueGrey;
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
                                        MainAxisAlignment
                                            .spaceBetween,
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
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
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
                                            subStrenght.toString(),
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
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
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right:25),
              child: Align(
                  alignment: Alignment.topRight,
                  child: ImageDisplayStoryPick(url: widget.eachOuterStoryDocument['image_url'])),
            ),
          ],
        ),
      );
  }
}
