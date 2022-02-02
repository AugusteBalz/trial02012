import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


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
    return Column(

      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          //width: 500,
          alignment: Alignment.center,
          // transform: Matrix4.rotationZ(0.1), // for fun
          child: CarouselSlider(
            carouselController: carouselController, // Give the controller
            options: CarouselOptions(
                enableInfiniteScroll: false,
              height: 600,
              enlargeCenterPage: true,
            ),
            items: widgetlist.map((featuredImage) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 5),
                //alignment: Alignment.center,

                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Material(
                      child: featuredImage,

                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
