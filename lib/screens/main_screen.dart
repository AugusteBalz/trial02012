import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  String userName = '';

  Future<void> getTheUsername() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    if (mainUserName == 'user') {
      var ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      mainUserName = ref['username'];
      print(mainUserName);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getTheUsername();

    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 10,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: (mainUserName != null ) ? Text(
                  'How are you feeling today, ' + mainUserName! + '?',
                  style: TextStyle(),
                ) : Text(
                  'How are you feeling today' + '?',)),
            //TODO: do a fix with the name


            Container(
              //width: 500,
              alignment: Alignment.center,
              // transform: Matrix4.rotationZ(0.1), // for fun
              child: CarouselSlider(
                carouselController: carouselController, // Give the controller
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: 450,
                  enlargeCenterPage: true,
                ),
                items: widgetlist.map((featuredImage) {
                  return Container(
                    // padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 5),
                    //alignment: Alignment.center,

                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: featuredImage,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
