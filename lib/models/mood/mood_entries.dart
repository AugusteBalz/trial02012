
import 'package:trial0201/models/mood/one_mood.dart';



class MoodEntry {

  String id;
  DateTime dateTime;
  List<OneMood> eachMood;


  MoodEntry({

    required this.id,
    required this.dateTime,
    required this.eachMood,

  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.

  List<Map<String, dynamic>> toListOfMaps() {
    List<Map<String, dynamic>> temp = [];

    for(int i = 0; i< eachMood.length; i++ ){
      temp.add({

        //id
      'id': id,

        //date
      'dateTime': dateTime.toString(),

        //one mood
      'primaryMood': eachMood[i].moodPrimary.toString(),
      'secondaryMood': eachMood[i].moodSecondary.toString(),
      'strength': eachMood[i].strength,
      'color': eachMood[i].color.toString(),
      });

    }

    return temp;
  }


}