import 'package:flutter/material.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/widgets/story/widget_for_mood_display_inner.dart';

import '../widget_for_mood_display.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class EmotionSelectionNew extends StatefulWidget {
  @override
  _EmotionSelectionNewState createState() => _EmotionSelectionNewState();
}

class _EmotionSelectionNewState extends State<EmotionSelectionNew> {
  PageController _controller1 = PageController(initialPage: 4242);
  PageController _controller2 = PageController(initialPage: 4242);
  int manualController = -1;

  var currentPageValue = 0.0;

  final List<dynamic> displayWidgets = [
    WidgetForMoodDisplay(newMood: angrySelection),
    WidgetForMoodDisplay(newMood: scaredSelection),
    WidgetForMoodDisplay(newMood: surpriseSelection),
    WidgetForMoodDisplay(newMood: powerfulSelection),
    Container(
      child: WidgetForMoodDisplay(newMood: happySelection),
    ),
    WidgetForMoodDisplay(newMood: peacefulSelection),
    WidgetForMoodDisplay(newMood: sadSelection),
    WidgetForMoodDisplay(newMood: disgustedSelection),
  ];

  final List<dynamic> displayInnerWidgets = [
    WidgetForMoodDisplayInner(newMood: angrySelection),
    WidgetForMoodDisplayInner(newMood: scaredSelection),
    WidgetForMoodDisplayInner(newMood: surpriseSelection),
    WidgetForMoodDisplayInner(newMood: powerfulSelection),
    Container(
      child: WidgetForMoodDisplayInner(newMood: happySelection),
    ),
    WidgetForMoodDisplayInner(newMood: peacefulSelection),
    WidgetForMoodDisplayInner(newMood: sadSelection),
    WidgetForMoodDisplayInner(newMood: disgustedSelection),
  ];

  double? currentPage = 0;

  Widget _itemBuilder(BuildContext context, int index) => Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            index.toString(),
            style: TextStyle(color: Colors.white, fontSize: 60),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _controller1 = PageController(viewportFraction: 0.8);
    _controller2 = PageController(viewportFraction: 0.8);

    _controller2.addListener(() {
      _controller1.jumpTo(_controller2.offset);
    });

//     _controller1.addListener(() {
//       _controller2.animateToPage(
//         _controller1.page.toInt(),
//         duration: Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        
        children: [Expanded(
          child: GestureDetector(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller1,






              itemBuilder: (context, index) {
                final index2 = index - 4242+ indexOfBigEmotion;



                return
                  displayWidgets[index2 % (displayWidgets.length)];


              },








            ),
          ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.scale(
              scale:1.8,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black87,
                    borderRadius: BorderRadius.circular(200)),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(),

              Expanded(
                child: Container(
                  //margin: EdgeInsets.all(30),
                  child: GestureDetector(
                    child: PageView.builder(
                        controller: _controller2,





                        itemBuilder: (context, index) {
                          final index2 = index - 4242+ indexOfBigEmotion;



                          return
                            displayInnerWidgets[index2 % (displayInnerWidgets.length)];
                        }








                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
