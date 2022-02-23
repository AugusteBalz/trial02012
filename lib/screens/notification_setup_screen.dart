import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:getwidget/getwidget.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:trial0201/globals/globals.dart';
import 'package:trial0201/screens/notification_setup.dart';

//TODO: still not working
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

String? selectedNotificationPayload;

Future<void> setUpTheNotifications() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = '/';


  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
          ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      });


  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,

  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload);
      });
}



Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class NotificationSetUpScreen extends StatefulWidget {
  const NotificationSetUpScreen({Key? key}) : super(key: key);

  @override
  _NotificationSetUpScreenState createState() => _NotificationSetUpScreenState();
}

class _NotificationSetUpScreenState extends State<NotificationSetUpScreen> {



  bool notificationControl = false;
  DateTime notificationTime = DateTime.now();

  DocumentReference userData = FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid);


  Future<void> getUserData()
  async {


    var ref = await  userData.get();

    notificationControl = ref['notifications']['control'];
    notificationTime = (ref['notifications']['time'] as Timestamp).toDate();


    time = TimeOfDay.fromDateTime(notificationTime);
    notificationsOnOff = notificationControl;

    setState(() {

      time = TimeOfDay.fromDateTime(notificationTime);
      notificationsOnOff = notificationControl;


    });

  }

  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime) async{




    setState(() {
      time = newTime;
      _scheduleDailyTenAMNotification(newTime.hour, newTime.minute);

      print(time.hour);
      print(time.minute);
     userData.update({
        'notifications': {'control' : notificationsOnOff, 'time': Timestamp.fromDate(DateTime(2022, 01, 01, time.hour, time.minute))}
      });
    });
  }


  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    userData.update({
      'notifications': {'control' : false}
    });
  }

  Future<void> _scheduleDailyTenAMNotification(int hours, int minutes) async {



    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Hi there!',
        'How are you feeling?',
        _nextInstanceOfTenAM(hours, minutes),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }


  tz.TZDateTime _nextInstanceOfTenAM(int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }


  void initState() {
    super.initState();
    _requestPermissions();
    setUpTheNotifications();
    print('o');
    getUserData();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        SecondPage(receivedNotification.payload),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, '/secondPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return  
      
      
      
      Scaffold(
       // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20),

        
        child: Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[


          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Show Notifications'),

              GFToggle(
                onChanged: (val){

                  if (val == false){
                    _cancelAllNotifications();

                    print("notifications are turned off");
                  }
                  else {_scheduleDailyTenAMNotification(time.hour, time.minute);
                  print("notifications are ON!");

                  }


                },
                value: true,
                type: GFToggleType.ios,
              )
            ],),
          ),

          SizedBox(height: 100,),
          Text(
            "Every Day",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            time.format(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: time,
                  onChange: onTimeChanged,
                  minuteInterval: MinuteInterval.ONE,
                  iosStylePicker: iosStyle,
                  minHour: 0,
                  maxHour: 23,
                  is24HrFormat: true,
                  // Optional onChange to receive value as DateTime
                  onChangeDateTime: (DateTime dateTime) {
                    print(dateTime);
                  },
                ),
              );
            },
            child: Text(
              "Select a different time",
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],
    ),
    ),
    ),
      )
    ;
  }
}
