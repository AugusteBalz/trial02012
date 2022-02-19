import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:ui' as ui;

import 'package:trial0201/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

 late File imageFile;


  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }


  void _submitAuthForm(
      String email,
      String password,
      String username,
      File image,
      bool isLogin,
      BuildContext ctx,
      ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

    /*    final fileName = basename(imageFile!.path);
        final destination = 'user_image/$fileName';


        final ref = FirebaseStorage.instance
            .ref()
            .child('destination')
            .child(authResult.user!.uid + '.jpg');

        await ref.putFile(imageFile).whenComplete(() => null);

     */

        var url;

        if(image!=null){
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_image/')
              .child("images/")
              .child(authResult.user!.uid + '.jpg');
          await ref.putFile(image);
           url = await ref.getDownloadURL();
        }




        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        String? temp = err.message;
        message = (temp != null ) ? temp : "ERROR";
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.5,

                0.9,
              ],
              colors: [
                const Color(0xFFFFD25B),
                const Color(0xFFFF7BDF),



                Colors.indigo,

              ],
            )
        ),
        child: Align(
          alignment: Alignment.center,
          child: AuthForm(
            _submitAuthForm,
            _isLoading,
          ),
        ),
      ),
    );
  }
}

/*


class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(Offset(size.width*0.42,size.height*0.37),Offset(size.width*0.75,size.height*0.37),[Color(0xff2418b8),Color(0xff500689)],[0.00,1.00]);

    Path path0 = Path();
    path0.moveTo(size.width*0.6550000,size.height*0.4471429);
    path0.cubicTo(size.width*0.5777083,size.height*0.3900000,size.width*0.5847917,size.height*0.3971429,size.width*0.4850000,size.height*0.4200000);
    path0.quadraticBezierTo(size.width*0.4293750,size.height*0.4128571,size.width*0.4175000,size.height*0.2871429);
    path0.lineTo(size.width*0.7508333,size.height*0.2828571);
    path0.lineTo(size.width*0.7508333,size.height*0.4285714);
    path0.quadraticBezierTo(size.width*0.7243750,size.height*0.4667857,size.width*0.6550000,size.height*0.4471429);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
 */
