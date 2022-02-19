import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trial0201/globals/defaults.dart';


import '../widgets/buttons_to_log/button_widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Container(
      
        
        child: Column(


          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [


            Container(
              margin: EdgeInsets.all(40),
                alignment: Alignment.centerLeft
                ,child: Text('How are you feeling today, '+mainUserName+ '?', style: TextStyle(),)),
            SizedBox(height: 40,),
            Container(
              //width: 500,
              alignment: Alignment.center,
              // transform: Matrix4.rotationZ(0.1), // for fun
              child: CarouselSlider(
                carouselController: carouselController, // Give the controller
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                  height: 320,
                  enlargeCenterPage: true,
                ),
                items: widgetlist.map((featuredImage) {
                  return Container(
                   // padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 5),
                    //alignment: Alignment.center,

                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      child: featuredImage,


                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
