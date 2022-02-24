import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/theming.dart';

import 'package:trial0201/screens/app_settings.dart';
import 'package:trial0201/screens/graphs.dart';
import 'package:trial0201/screens/notification_setup_screen.dart';
import 'package:trial0201/screens/read_about_emotion_regulation.dart';
import 'package:trial0201/screens/story_History.dart';

import 'package:trial0201/widgets/auth/auth_screen.dart';
import 'package:trial0201/widgets/auth/splash_screen.dart';
import 'package:trial0201/widgets/bottom_nav.dart';
import 'package:trial0201/screens/mood_history.dart';
import 'package:trial0201/screens/main_screen.dart';
import 'package:trial0201/widgets/mood/emotion_selection_new.dart';


import 'package:trial0201/widgets/mood/log_mood_screen_1_new.dart';
import 'package:trial0201/widgets/mood/log_mood_screen_2.dart';
import 'package:trial0201/widgets/mood/log_mood_screen_3.dart';


import 'package:firebase_core/firebase_core.dart';

import 'package:trial0201/widgets/story/story_screen_new.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

const primaryColor = Colors.transparent;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyAppFirst());
}

class MyAppFirst extends StatelessWidget {
  const MyAppFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => currentModel,
      child: Consumer<ThemeModel>(
        builder: (_, currentModel, __) {
          return MaterialApp(
            title: 'Embrace Yourself',
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => const MyApp(),

              //to multiselect mood log


              '/logmood1new': (context) => const LogMoodScreen1New(),

              '/logmood2': (context) => const LogMoodScreen2(),

              '/logmood3': (context) => const LogMoodScreen3(),

              //
              '/moodhistory': (context) => const ShowMoodHistory(),

              //
              '/storyHistory': (context) => const StoryHistory(),

              //
              '/auth': (context) => AuthScreen(),

              //

              '/logstory2': (context) => StoryScreenNew(),

              //
              '/readAboutEmotions': (context) => ReadAboutEmotionRegulation(),
              '/setUpNotifications': (context) => NotificationSetUpScreen(),
              '/emotionSelectionNew': (context) => EmotionSelectionNew(),

              //
              // '/images' : (context) => ImagePickerForUserProfile(),

              //'/emotionSelectionScreen' : (context) => const EmotionSelectionScreen(),
            },
            theme: ThemeData(
              // Define the default brightness and colors.
              brightness: Brightness.light,
              primaryColor: Color(0xFF190A34),


              // Define the default font family.
              fontFamily: 'Nunito',

              // Define the default `TextTheme`. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: textTextTheme.apply(
                // bodyColor: Colors.orange,
                displayColor: Colors.black,
              ),
              appBarTheme: const AppBarTheme(
                //brightness: Brightness.light,
                // systemOverlayStyle: SystemUiOverlayStyle.dark,
                color: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),

                systemOverlayStyle: SystemUiOverlayStyle(
                  // Status bar color

                  // Status bar brightness (optional)
                  statusBarIconBrightness: Brightness.dark,
                  // For Android (dark icons)
                  statusBarBrightness: Brightness.light, // For iOS (dark icons)
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                primary: Colors.deepPurple,
                side:
                    BorderSide(
                        width: 1.0, color: Colors.deepPurple),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(15),
                textStyle: const TextStyle(
                  color: Colors.pinkAccent,
                ),
              )),
              /*  colorScheme:  const ColorScheme(
                    primary: Colors.black26,
                    primaryVariant: Colors.black26,
                    secondary: Colors.black26,
                    secondaryVariant: Colors.black26,
                    surface: Colors.black26,
                    background: Colors.black26,
                    error: Colors.black26,
                    onPrimary: Colors.black26,
                    onSecondary: Colors.black26,
                    onSurface: Colors.black26,
                    onBackground: Colors.black26,
                    onError: Colors.black26,
                    brightness: Brightness.light),



               */
            ),

            darkTheme: ThemeData(
                // Define the default brightness and colors.
                brightness: Brightness.dark,
                primaryColor: const Color(0xFF151026),

                // Define the default font family.
                fontFamily: 'Nunito',

                //we add white text for dark theme
                textTheme: textTextTheme.apply(
                  // bodyColor: Colors.orange,
                  displayColor: Colors.white,
                ),
                appBarTheme: const AppBarTheme(
                  color: Colors.transparent,
                  elevation: 0,
                  //systemOverlayStyle: SystemUiOverlayStyle.dark,
                  iconTheme: IconThemeData(color: Colors.white),

                  systemOverlayStyle: SystemUiOverlayStyle(
                    // Status bar color
                    statusBarColor: Colors.red,

                    // Status bar brightness (optional)
                    statusBarIconBrightness: Brightness.light,
                    // For Android (dark icons)
                    statusBarBrightness:
                        Brightness.dark, // For iOS (dark icons)
                  ),
                )),
            // Provide dark theme.
            themeMode: currentModel.mode,
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        ));

    */

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {
            print(userSnapshot.data.toString());
            return HomePage();
          }
          return AuthScreen();
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //we save the userinput

//  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    StoryHistory(),
    ShowMoodHistory(),
    MainScreen(),
    GraphScreen(),
    AppSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      BottomNavi().changePage(index);
    });
  }

  // Map<SecondaryMoods, int> allMoodLogs = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          children: [
            Image(image: AssetImage('assets/images/embrace_black.png'), height: 55,),
            SizedBox(height: 15,)
          ],
        ),
      ),
      body: Container(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        child:
          // Center(child: CircularProgressIndicator()),
          //widget to select the moods from
          // UserMood(),
          _widgetOptions.elementAt(selectedIndex),

      ),
      /* floatingActionButton: FloatingActionButton(
          child: Icon(Icons.airplanemode_on_rounded),
          onPressed: () {
            FirebaseFirestore.instance
                    .collection('Users/3oD3lMeJuQr7UJ84aHp2/MoodEntries')
                    .doc('OneEntry4')
                    .set({
              'id': 'bandymas',
            })

                /*.add({

              'id':'oop',
                })


                 */
                ;
          }),

      */
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            // canvasColor: Colors.green,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.yellow))),
        // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          elevation: 0,
          // backgroundColor: Colors.pink,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Stories',
              //  backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check),
              label: 'Moods',
              //  backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
              // backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Insights',
              // backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services_rounded),
              label: 'Settings',
              // backgroundColor: Colors.white,
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    //Theme.of(context).colorScheme.happy;

    // ThemeData.light().colorScheme.happy = Colors.blue ;
    // _changeColorTheme(_mode);
    notifyListeners();
  }
}

/*
void _changeColorTheme(ThemeMode mode) {
  if (mode == ThemeMode.light) {
    angryMoodColor = angryMoodColorLight;
    scaredMoodColor = scaredMoodColorLight;
    sadMoodColor = sadMoodColorLight;
    happyMoodColor = happyMoodColorLight;
    surprisedMoodColor = surprisedMoodColorLight;
    powerfulMoodColor = powerfulMoodColorLight;
    disgustedMoodColor = disgustedMoodColorLight;
    peacefulMoodColor = peacefulMoodColorLight;
  } else {
    angryMoodColor = angryMoodColorDark;
    scaredMoodColor = scaredMoodColorDark;
    sadMoodColor = sadMoodColorDark;
    happyMoodColor = happyMoodColorDark;
    surprisedMoodColor = surprisedMoodColorDark;
    powerfulMoodColor = powerfulMoodColorDark;
    disgustedMoodColor = disgustedMoodColorDark;
    peacefulMoodColor = peacefulMoodColorDark;
  }
}



 */

/*
extension CustomColorScheme on ColorScheme {

  Color get happy => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);
  Color get angry => brightness == Brightness.light ? const Color(0xffbe3636) : const Color(0xf57c1401);
  Color get scared => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);
  Color get sad => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);
  Color get surprised => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);
  Color get powerful => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);
  Color get disgusted => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);
  Color get peaceful => brightness == Brightness.light ? const Color(0xFF28a745) : const Color(0x2228a745);



}


 */
