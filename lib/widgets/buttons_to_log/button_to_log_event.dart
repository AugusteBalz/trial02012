
import 'package:flutter/material.dart';

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
            Colors.yellow,
            Colors.deepOrange,
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.redAccent,
      ),
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () async {
          /*
          final value = await Navigator.pushNamed(context, '/emotionSelectionScreen');

          setState(() {
            const ShowHistory();
          });

           */
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
    );
  }
}