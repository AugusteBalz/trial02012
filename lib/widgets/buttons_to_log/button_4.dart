import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
extra button if needed
 */

class Button4 extends StatefulWidget {
  const Button4({Key? key}) : super(key: key);

  @override
  _Button4State createState() => _Button4State();
}

class _Button4State extends State<Button4> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyanAccent,
            Colors.lightGreenAccent,
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
          onTap: ()  {

            Navigator.pushNamed(context, "/auth");



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
      ),
    );
  }
}
