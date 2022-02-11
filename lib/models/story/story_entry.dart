
import 'package:trial0201/models/mood/one_mood.dart';



class StoryEntry {

  String id;
  DateTime dateTime;
  String title;
  String story;
  List<String> tags;
  List<OneMood> eachMood;


  StoryEntry({

    required this.id,
    required this.dateTime,
    required this.title,
    required this.story,
    required this.tags,
    required this.eachMood,

  });


}