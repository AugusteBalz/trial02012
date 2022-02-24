
import 'package:blurrycontainer/blurrycontainer.dart';
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
            Colors.orange,
            Colors.yellow,
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

            final value = await Navigator.pushNamed(context, '/logstory2');

            setState(() {

              //TODO: set the needed history
           //   const ShowMoodHistory();
            });


          },

          child: Container(padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: const [
                  Text('What happened today?', style: TextStyle(
                      fontSize: 25
                  ),),
                  Icon( Icons.menu_book_outlined,
                    size: 50,),
                  Text('Log story / event', style: TextStyle(
                      fontSize: 15
                  ),),
                ],
              )),
        ),
      ),
    );
  }
}