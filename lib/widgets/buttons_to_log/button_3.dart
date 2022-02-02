import 'package:flutter/material.dart';

/*
extra button if needed
 */

class Button3 extends StatefulWidget {
  const Button3({Key? key}) : super(key: key);

  @override
  _Button3State createState() => _Button3State();
}

class _Button3State extends State<Button3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Colors.tealAccent,
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
        /*  final value =
              await Navigator.pushNamed(context, '/emotionSelectionScreen');

          setState(() {
            const ShowHistory();
          });

         */
        },
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: const [
          Text(
            "Something else",
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
