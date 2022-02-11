import 'package:flutter/material.dart';
import 'package:trial0201/screens/graphs.dart';
import 'package:trial0201/screens/mood_history.dart';


class ButtonToLogMood extends StatefulWidget {
  const ButtonToLogMood({Key? key}) : super(key: key);

  @override
  _ButtonToLogMoodState createState() => _ButtonToLogMoodState();
}

class _ButtonToLogMoodState extends State<ButtonToLogMood> {
  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.pinkAccent,
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.redAccent,
        ),
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () async {
           await Navigator.pushNamed(context, '/logmood1');

          setState(() {

            //reload the screens
            const ShowMoodHistory();
            const GraphScreen();

          });
        },

        child: Row(children: const [
          Center(
              child: Text(
                "Mood",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              )),
          Icon(
            Icons.bubble_chart_rounded,
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}

