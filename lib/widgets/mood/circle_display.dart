

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/primary_emotions_blueprint.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final PrimaryEmotionsBlueprint selectionOfPrimaryEmotion;


  const CircleButton({Key? key, required this.onTap, required  this.selectionOfPrimaryEmotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 45.0;
/*

 Color? tempColor =  primaryColors[selectionOfPrimaryEmotion.emotionP];
   Color myColor =  (tempColor != null ) ? tempColor : Colors.grey;


 */

    return InkResponse(
      onTap: (){
        {
          indexOfBigEmotion  = selectionOfPrimaryEmotion.id;
          Navigator.pushNamed(context, '/logmood2');

        };
      },
      child: Container(

         width: size*2,
        height: size,

        child: Container(

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selectionOfPrimaryEmotion.color,width: 2),
            gradient: RadialGradient(colors: [selectionOfPrimaryEmotion.color.withOpacity(0.7), selectionOfPrimaryEmotion.color], radius: 1)
          ),

          padding: EdgeInsets.all(8),
         // width: size*2,

          //height: size,

        /* decoration: BoxDecoration(
            color: selectionOfPrimaryEmotion.color,
            shape: BoxShape.rectangle,
            borderRadius: ,
          ),

         */
          child: Center(child: Text(selectionOfPrimaryEmotion.emotionName

          ,
          style: TextStyle(

            fontSize: Theme.of(context).textTheme.headline5!.fontSize,
            fontWeight: Theme.of(context).textTheme.headline5!.fontWeight,
          ),),),
        ),
      ),
    );
  }
}