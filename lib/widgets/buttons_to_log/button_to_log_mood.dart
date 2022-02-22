import 'package:blurrycontainer/blurrycontainer.dart';
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
              Colors.pinkAccent,
              Color(0xFF6703CB),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.redAccent,
        ),

      child: BlurryContainer(
        borderRadius: BorderRadius.circular(20),
        bgColor: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: InkWell(
          onTap: () async {
             await Navigator.pushNamed(context, '/logmood1');

            setState(() {

              //reload the screens
              const ShowMoodHistory();
              const GraphScreen();

            });
          },

          child: Container(padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: const [
                  Text('How are you feeling right now?', style: TextStyle(
                    fontSize: 25
                  ),),
                  Icon( Icons.all_inclusive_outlined,
                  size: 50,),
                  Text('Log mood', style: TextStyle(
                      fontSize: 15
                  ),),
                ],
              ))




            /*
            Row(children: const [
            Center(
                child: Text(
                  "Mood",
                  style: TextStyle(
                    fontSize: 20.0,

                  ),
                )),
            Icon(
              Icons.bubble_chart_rounded,
              color: Colors.white,
            ),
          ]),
             */
        ),
      ),
    );
  }
}

