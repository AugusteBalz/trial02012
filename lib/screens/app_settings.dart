import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/globals/theming.dart';
import 'package:trial0201/screens/mood_history.dart';



class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {



    return Container(

      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child:
      Column(
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                const Text("Theme"),
                //ToggleButtons(children: children, isSelected: isSelected)

                ToggleSwitch(
                  minWidth: 60.0,
                  minHeight: 50.0,
                  initialLabelIndex: previousIndex,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons:  const [

                    Icons.wb_sunny_rounded,
                    Icons.nights_stay_rounded,

                  ],
                  iconSize: 30.0,
                  activeBgColors:  const [[Colors.yellow, Colors.orange],[Colors.blue, Color(
                      0xFF00116B)] ],
                  //animate: true, // with just animate set to true, default curve = Curves.easeIn
                  //curve: Curves.linear, // animate must be set to true when using custom curve
                  onToggle: (index) {

                    //TODO: fix theming

                     if(previousIndex!=index){
                       currentModel.toggleMode();
                       previousIndex = index!;


                       //TODO: color sceheme!!!!
                      // _changeColorTheme(Theme.of(context));

                       //rebuild all the widgets
                      // ShowMoodHistory();
                     }

                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: const [
                Text("Customize colors"),
              ],
            ),
          )

        ],
      ),
      
      
    );
  }
}


void _changeColorTheme(ThemeData mode) {




  if (mode.brightness == Brightness.light) {
    print('dod');
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