
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/screens/mood_history.dart';

class ButtonToLogEvent extends StatefulWidget {
  const ButtonToLogEvent({Key? key}) : super(key: key);

  @override
  _ButtonToLogEventState createState() => _ButtonToLogEventState();
}

class _ButtonToLogEventState extends State<ButtonToLogEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.purpleAccent,
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.redAccent,
      ),
      padding: const EdgeInsets.all(8),
      child: BlurryContainer(
        borderRadius: BorderRadius.circular(15),
        bgColor: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: InkWell(
          onTap: () async {

            final value = await Navigator.pushNamed(context, '/logstory');

            setState(() {

              //TODO: set the needed history
           //   const ShowMoodHistory();
            });


          },

          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Event/story",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.bubble_chart_rounded,
                  color: Colors.white,
                ),
              ]),
        ),
      ),
    );
  }
}