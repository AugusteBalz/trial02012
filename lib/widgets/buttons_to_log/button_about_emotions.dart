import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/screens/graphs.dart';
import 'package:trial0201/screens/mood_history.dart';


class ButtonAboutEmotions extends StatefulWidget {
  const ButtonAboutEmotions({Key? key}) : super(key: key);

  @override
  _ButtonAboutEmotionsState createState() => _ButtonAboutEmotionsState();
}

class _ButtonAboutEmotionsState extends State<ButtonAboutEmotions> {
  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Color(0xFF0930B8),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.redAccent,
        ),

      child: BlurryContainer(
        borderRadius: BorderRadius.circular(20),
        bgColor: Colors.white.withOpacity(0.9),
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
                  Text('Why it is important to recognise your emotions?', style: TextStyle(
                    fontSize: 25
                  ),),
                  Icon( Icons.all_inclusive_outlined,
                  size: 50,),
                  Text('Read about', style: TextStyle(
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

