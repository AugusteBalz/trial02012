

import 'package:flutter/material.dart';
import 'package:trial0201/widgets/story/story_log_list.dart';

class StoryHistory extends StatefulWidget {
  const StoryHistory({Key? key}) : super(key: key);

  @override
  _StoryHistoryState createState() => _StoryHistoryState();
}

class _StoryHistoryState extends State<StoryHistory> {
  @override
  Widget build(BuildContext context) {
    return StoryLogList();
  }
}
