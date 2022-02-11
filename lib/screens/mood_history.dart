
import 'package:flutter/material.dart';
import 'package:trial0201/widgets/mood/moodlog_list.dart';


/*

shows previously added emotions

 */

class ShowMoodHistory extends StatefulWidget {
  const ShowMoodHistory({Key? key}) : super(key: key);

  @override
  _ShowMoodHistoryState createState() => _ShowMoodHistoryState();
}

class _ShowMoodHistoryState extends State<ShowMoodHistory> {
  @override
  Widget build(BuildContext context) {
    return MoodLogList();
  }
}
