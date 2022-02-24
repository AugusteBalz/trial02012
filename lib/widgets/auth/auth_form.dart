import 'dart:io';
import 'dart:ui';


import 'package:flutter/material.dart';

import 'package:trial0201/globals/defaults.dart';

import 'package:trial0201/widgets/pickers/image_picker_user_profile_pic.dart';



class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile = mainProfilePic;

  void _pickedImage(File image) {
    _userImageFile = image;
    mainProfilePic = image;
  }

//  File imageFile = File('assets/images/lights.jpg');

/* CollectionReference storyCollection = FirebaseFirestore.instance
      .collection('Users/3oD3lMeJuQr7UJ84aHp2/StoryEntries');


  getFromGallery() async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )) as PickedFile?;
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }
 */

  void _trySubmit() {
    FormState? isValidTemp = _formKey.currentState;
    FormState isValidTemp2 = (isValidTemp != null) ? isValidTemp : FormState();

    final isValid = isValidTemp2.validate();
    FocusScope.of(context).unfocus();

/*
   //_userImageFile = imageFile;
    if (_userImageFile == null && !_isLogin && FirebaseAuth.instance.currentUser == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }


 */
    if (isValid) {
      isValidTemp2.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top:80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage('assets/images/embrace_white.png')),
           /* Container(
                margin: EdgeInsets.all(30),
                child: Text(_isLogin
                    ? 'Welcome back!'
                    : 'Nice to meet you!')),

            */
            Flexible(
              child: Container(
                //  margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                padding: const EdgeInsets.all(5.0),

                decoration: new BoxDecoration(
                  //you can get rid of below line also
                  borderRadius: new BorderRadius.circular(10.0),
                  //below line is for rectangular shape
                  shape: BoxShape.rectangle,
                  //you can change opacity with color here(I used black) for rect

                  //I added some shadow, but you can remove boxShadow also.
                ),
                child: SingleChildScrollView(
                  child: Container(
                    //padding: EdgeInsets.all(16),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (!_isLogin)
                                ImagePickerForUserProfile(_pickedImage, _userImageFile),
                              SizedBox(
                                height: 30,
                              ),
                              ClipRect(
                                child: Card(

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 3.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(25.0),
                                    
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              key: ValueKey('email'),
                                              autocorrect: false,
                                              textCapitalization: TextCapitalization.none,
                                              enableSuggestions: false,
                                              validator: (value) {
                                                if (value == null ||
                                                    !value.contains('@') ||
                                                    value.isEmpty) {
                                                  return 'Please enter a valid email address.';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                labelText: 'Email address',
                                              ),
                                              onSaved: (value) {
                                                String? tempValue = value;
                                                _userEmail =
                                                (tempValue != null) ? tempValue : "ERROR";
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            if (!_isLogin)
                                              TextFormField(
                                                key: ValueKey('username'),
                                                autocorrect: true,
                                                textCapitalization: TextCapitalization.words,
                                                enableSuggestions: false,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.length < 4) {
                                                    return 'Please enter at least 4 characters';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                InputDecoration(labelText: 'Username'),
                                                onSaved: (value) {
                                                  String? tempValue = value;
                                                  _userName =
                                                  (tempValue != null) ? tempValue : "ERROR";
                                                },
                                              ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              key: ValueKey('password'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value.length < 7) {
                                                  return 'Password must be at least 7 characters long.';
                                                }
                                                return null;
                                              },
                                              decoration:
                                              InputDecoration(labelText: 'Password'),
                                              obscureText: true,
                                              onSaved: (value) {
                                                String? tempValue = value;
                                                _userPassword =
                                                (tempValue != null) ? tempValue : "ERROR";
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              if (widget.isLoading)
                                CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              if (!widget.isLoading)
                                TextButton(
                                  child: Text(_isLogin ? 'Login' : 'Signup', style: TextStyle(

                                    color: Colors.white,
                                    fontSize: 20
                                  ),),
                                  onPressed: _trySubmit,

                                ),

                              if (!widget.isLoading)
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        Color(0xFF040A2B)),
                                  ),
                                  child: Text(
                                    _isLogin
                                        ? 'Create a new account'
                                        : 'I already have an account',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 35,)
          ],
        ),
      ),
    );
  }
}
