import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/screens/graphs.dart';
import 'package:trial0201/screens/mood_history.dart';


class ButtonExtra extends StatefulWidget {
  const ButtonExtra({Key? key}) : super(key: key);

  @override
  _ButtonExtraState createState() => _ButtonExtraState();
}

class _ButtonExtraState extends State<ButtonExtra> {
  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.greenAccent,
              Color(0xFF3762FF),
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
            Navigator.pushNamed(context, '/logmood1new');

            setState(() {

              //reload the screens
             

            });
          },

          child: Container(padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: const [
                  Text('Something extra', style: TextStyle(
                    fontSize: 25
                  ),),
                 /* Icon( Icons.bubble_chart_outlined,
                  size: 50,),
                  Text('Read about', style: TextStyle(
                      fontSize: 15
                  ),),

                  */
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

