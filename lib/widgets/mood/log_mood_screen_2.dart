import 'package:flutter/material.dart';
import 'package:trial0201/widgets/mood/emotion_selection_new.dart';



class LogMoodScreen2 extends StatefulWidget {
  const LogMoodScreen2({Key? key}) : super(key: key);

  @override
  State<LogMoodScreen2> createState() => _LogMoodScreen2State();
}

class _LogMoodScreen2State extends State<LogMoodScreen2> {



  @override
  Widget build(BuildContext context) {
    return EmotionSelectionNew();
  }
}
