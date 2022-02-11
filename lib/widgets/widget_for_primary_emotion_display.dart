import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/primary_emotions_blueprint.dart';

class WidgetForPrimaryEmotionDisplay extends StatefulWidget {
  final PrimaryEmotionsBlueprint selectionOfPrimaryEmotion;

  const WidgetForPrimaryEmotionDisplay(
      {Key? key, required this.selectionOfPrimaryEmotion})
      : super(key: key);

  @override
  _WidgetForPrimaryEmotionDisplayState createState() =>
      _WidgetForPrimaryEmotionDisplayState();
}

class _WidgetForPrimaryEmotionDisplayState
    extends State<WidgetForPrimaryEmotionDisplay> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
          onPressed: () {
            indexOfBigEmotion  = widget.selectionOfPrimaryEmotion.id;
            Navigator.pushNamed(context, '/logmood2');

          },
          color:  widget.selectionOfPrimaryEmotion.color,
          height: 70,
          child: Text(widget.selectionOfPrimaryEmotion.emotionName)),
    );
  }
}
