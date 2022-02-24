import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/globals/matching_maps.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/primary_emotions_blueprint.dart';
import 'package:trial0201/widgets/mood/circle_display.dart';

//TODO: add a colour wheel to select emotions

class LogMoodScreen1New extends StatefulWidget {
  const LogMoodScreen1New({Key? key}) : super(key: key);

  @override
  State<LogMoodScreen1New> createState() => _LogMoodScreen1NewState();
}

class _LogMoodScreen1NewState extends State<LogMoodScreen1New> {
  PrimaryEmotionsBlueprint selectionOfPrimaryEmotion = PrimaryEmotionsBlueprint(
    emotionName: "Disgusted",
    emotionP: PrimaryMoods.Disgusted,
    color: disgustedMoodColor,
    id: 0,
  );

  double WIDTH = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Right now I am feeling...",
            style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        //TODO: show the back button properly
        //systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
          //  margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
         // padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          alignment: Alignment.center,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 6;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                      children: [CustomPaint(
                        size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomPainter(color: sadMoodColor),
                      ),
                        Text('Sad'),
                      ]
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 7;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        CustomPaint(
                          size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                          //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSCustomPainter(color: disgustedMoodColor),

                        ),
                        Text('Disgusted'),


                      ]
                    ),

                  ),
                  SizedBox(width: 7,),
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 5;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [

                          CustomPaint(
                            size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(color: peacefulMoodColor),

                          ),
                          Text('Peaceful'),


                        ]
                    ),

                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 0;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [

                          CustomPaint(
                            size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(color: angryMoodColor),

                          ),
                          Text('Angry'),


                        ]
                    ),

                  ),
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 4;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [

                          CustomPaint(
                            size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(color: happyMoodColor),

                          ),
                          Text('Happy'),


                        ]
                    ),

                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 1;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [

                          CustomPaint(
                            size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(color: scaredMoodColor),

                          ),
                          Text('Scared'),


                        ]
                    ),

                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 3;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [

                          CustomPaint(
                            size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(color: powerfulMoodColor),

                          ),
                          Text('Powerful'),


                        ]
                    ),

                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      indexOfBigEmotion  = 2;
                      Navigator.pushNamed(context, '/logmood2');
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [

                          CustomPaint(
                            size: Size(WIDTH, (WIDTH * 0.5833333333333334).toDouble()),
                            //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(color: surprisedMoodColor),

                          ),
                          Text('Surprised'),


                        ]
                    ),

                  ),
                ],
              ),
              SizedBox(height: 90,)
            ],
          )

          /*
           Stack(children: [


          Positioned(
            child: const Icon(
              Icons.zoom_out_map_outlined,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            top: 130,
            left: 153,
          ),
          Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: wholePrimaryEmotionsList.map((oneEmotionName) {
              selectionOfPrimaryEmotion = oneEmotionName;

              // currentSliderValue = sliders.elementAt(0);


              double left = 0;
              double top = 0;
              double right = 0;
              double bottom = 0;

              List<double>? temp = moodToPosition[selectionOfPrimaryEmotion.emotionP];
              if (temp !=null){
                left = temp.elementAt(0);
                top = temp.elementAt(1);
                // right = temp.elementAt(2);
                //bottom = temp.elementAt(3);
              }


              //displaying widgets

              return Positioned(
                child: CircleButton(

                    onTap: () {

                },

                    selectionOfPrimaryEmotion: selectionOfPrimaryEmotion),
                top: top,
                left: left,
                //right: right,
                //bottom: bottom,
              );
              //WidgetForPrimaryEmotionDisplay(selectionOfPrimaryEmotion: selectionOfPrimaryEmotion);
            }).toList(),
          ),
        ],

        ),
           */
          ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  Color color;

  RPSCustomPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {


    Paint paint0 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(size.width*0.0617750,size.height*0.5695571);
    path0.cubicTo(size.width*0.0231917,size.height*0.3970143,size.width*0.1278667,size.height*0.0569714,size.width*0.3300583,size.height*0.2055714);
    path0.cubicTo(size.width*0.3953583,size.height*-0.0349286,size.width*0.7631917,size.height*-0.0753143,size.width*0.8083917,size.height*0.2693143);
    path0.cubicTo(size.width*1.0131917,size.height*0.3203714,size.width*1.0466667,size.height*0.6586571,size.width*0.9093083,size.height*0.7699286);
    path0.cubicTo(size.width*0.7736917,size.height*1.1838143,size.width*0.5025917,size.height*0.6903286,size.width*0.3021167,size.height*0.9224429);
    path0.cubicTo(size.width*0.0571583,size.height*1.0458857,size.width*-0.0138500,size.height*0.7295571,size.width*0.0617750,size.height*0.5695571);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

