import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/models/mood/primary_emotions_blueprint.dart';

class WidgetForPrimaryEmotionDisplay extends StatefulWidget {
  final PrimaryEmotionsBlueprint selectionOfPrimaryEmotion;

  const WidgetForPrimaryEmotionDisplay(
      {Key? key, required this.selectionOfPrimaryEmotion})
      : super(key: key);

  @override
  _WidgetForPrimaryEmotionDisplayState createState() =>
      _WidgetForPrimaryEmotionDisplayState();
}

class _WidgetForPrimaryEmotionDisplayState
    extends State<WidgetForPrimaryEmotionDisplay> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
          onPressed: () {
            indexOfBigEmotion  = widget.selectionOfPrimaryEmotion.id;
            Navigator.pushNamed(context, '/logmood2');

          },
          color:  widget.selectionOfPrimaryEmotion.color,
          height: 70,
          child: Text(widget.selectionOfPrimaryEmotion.emotionName)),
    );
  }
}


class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(size.width*0.3950000,size.height*0.3957143);
    path0.cubicTo(size.width*0.3591667,size.height*0.2492857,size.width*0.4931250,size.height*0.1714286,size.width*0.5300000,size.height*0.2271429);
    path0.cubicTo(size.width*0.5966667,size.height*0.0939286,size.width*0.7672917,size.height*0.1767857,size.width*0.7541667,size.height*0.3357143);
    path0.cubicTo(size.width*0.7979167,size.height*0.3246429,size.width*0.8714583,size.height*0.5492857,size.width*0.7050000,size.height*0.5771429);
    path0.cubicTo(size.width*0.6568750,size.height*0.6625000,size.width*0.5612500,size.height*0.5403571,size.width*0.4900000,size.height*0.6057143);
    path0.cubicTo(size.width*0.4281250,size.height*0.6332143,size.width*0.3193750,size.height*0.5557143,size.width*0.3950000,size.height*0.3957143);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
