import 'package:flutter/material.dart';

import 'package:trial0201/widgets/pickers/image_picker_user_profile_pic.dart';

/*
extra button if needed
 */




class Button5 extends StatefulWidget {
  const Button5({Key? key}) : super(key: key);

  @override
  _Button5State createState() => _Button5State();
}

class _Button5State extends State<Button5> {

  void _handleURLButtonPress(BuildContext context, var type) {
  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo,
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
        onTap: ()  {



          Navigator.pushNamed(context, '/images');





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
