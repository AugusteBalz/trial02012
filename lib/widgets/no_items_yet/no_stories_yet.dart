import 'dart:io';

import 'package:flutter/material.dart';

class NoStoriesYet extends StatefulWidget {
  const NoStoriesYet({Key? key}) : super(key: key);

  @override
  _NoStoriesYetState createState() => _NoStoriesYetState();
}

class _NoStoriesYetState extends State<NoStoriesYet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 120),
      alignment: Alignment.center,

      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child:
                  Text('Hmm... it seems that you do not have any stories yet')),
          Container(
                alignment: Alignment.center,

                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                height: 150,
                child:
                    Image(image: AssetImage('assets/images/arrow_doodle.png'))),
          
          OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/logstory');
              },
              child: Text("I want to log my first story!")),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
