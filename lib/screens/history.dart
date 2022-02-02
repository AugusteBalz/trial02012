
import 'package:flutter/material.dart';
import 'package:trial0201/widgets/mood/moodlog_list.dart';


/*

shows previously added emotions

 */

class ShowHistory extends StatefulWidget {
  const ShowHistory({Key? key}) : super(key: key);

  @override
  _ShowHistoryState createState() => _ShowHistoryState();
}

class _ShowHistoryState extends State<ShowHistory> {
  @override
  Widget build(BuildContext context) {
    return MoodLogList();
  }
}
