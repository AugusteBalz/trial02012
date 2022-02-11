import 'package:flutter/material.dart';
import 'package:trial0201/widgets/auth/image_from_gallery.dart';

/*
extra button if needed
 */

enum ImageSourceType { gallery, camera }


class Button3 extends StatefulWidget {
  const Button3({Key? key}) : super(key: key);

  @override
  _Button3State createState() => _Button3State();
}

class _Button3State extends State<Button3> {

  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,
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
        onTap: () async {


          _handleURLButtonPress(context, ImageSourceType.gallery);

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
