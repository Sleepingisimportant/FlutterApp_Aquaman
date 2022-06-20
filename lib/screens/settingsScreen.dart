import 'package:aquaman/screens/dailyRecordsScreen.dart';
import 'package:aquaman/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:aquaman/utilities/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:aquaman/models/generalData.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:aquaman/screens/bottomSheet/lanaguage_bottomSheet.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> getTimeStartEndHrMin() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.getInt('_timeStartMin');
    prefs.getInt('_timeStartHr');
    prefs.getInt('_timeEndMin');
    prefs.getInt('_timeEndHr');

    setState(() {
      // if (_timeStartMin == null) {
      //   _timeStartMin = 0;
      // } else {
      //   _timeStartMin = prefs.getInt('_timeStartMin');
      // }
      prefs.getInt('_timeStartMin') == null
          ? _timeStartMin = 0
          : _timeStartMin = prefs.getInt('_timeStartMin');
      prefs.getInt('_timeStartHr') == null
          ? _timeStartHr = 8
          : _timeStartHr = prefs.getInt('_timeStartHr');
      prefs.getInt('_timeEndMin') == null
          ? _timeEndMin = 0
          : _timeEndMin = prefs.getInt('_timeEndMin');
      prefs.getInt('_timeEndMin') == null
          ? _timeEndHr = 20
          : _timeEndHr = prefs.getInt('_timeEndHr');

      (_timeStartHr * 60 + _timeStartMin) <= (_timeEndHr * 60 + _timeEndMin)
          ? showErrorNotification = false
          : showErrorNotification = true;
    });
  }

  double notificationNumber = 0;
  bool showErrorNotification = false;

  Future<void> scheduleAlarm() async {
    await flutterLocalNotificationsPlugin.cancelAll();

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(''),
    );

    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: false,
      presentSound: false,
    );

    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    _intervalMin = (_intervalHr * 60).round();

    setState(() {
      notificationNumber =
          (_timeEndHr * 60 + _timeEndMin - _timeStartHr * 60 - _timeStartMin) /
              _intervalMin;

      (_timeStartHr * 60 + _timeStartMin) <= (_timeEndHr * 60 + _timeEndMin)
          ? showErrorNotification = false
          : showErrorNotification = true;
    });

    for (int i = 0; i <= notificationNumber; i++) {
      try {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          i,
          "LocaleKeys.notif_content_notif_title.tr()",
          "LocaleKeys.notif_content_notif_body.tr()",
          _selectTimeForNotification(_timeStartHr, _timeStartMin)
              .add(Duration(minutes: _intervalMin * i)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        print(_selectTimeForNotification(_timeStartHr, _timeStartMin)
            .add(Duration(minutes: _intervalMin * i)));
      } catch (e) {
        // print(e);

        await flutterLocalNotificationsPlugin.zonedSchedule(
          i,
          "LocaleKeys.notif_content_notif_title.tr()",
          "LocaleKeys.notif_content_notif_body.tr()",
          _selectTimeForNotification(_timeStartHr, _timeStartMin)
              .add(Duration(days: 1, minutes: _intervalMin * i)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        print(_selectTimeForNotification(_timeStartHr, _timeStartMin)
            .add(Duration(days: 1, minutes: _intervalMin * i)));
      }
    }
  }

  tz.TZDateTime _selectTimeForNotification(int hr, int min) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime.local(now.year, now.month, now.day, hr, min);

    return scheduledDate;
  }

  int _currentSliderValueWaterIntake = 2000;
  int _currentSliderValueAge = 30;
  int _currentSliderValueWeight = 60;

  void calculateWaterIntakeTarget() {
    if (_currentSliderValueAge <= 30) {
      setState(() {
        _currentSliderValueWaterIntake = _currentSliderValueWeight * 40;
        if (_currentSliderValueWaterIntake > 5000) {
          _currentSliderValueWaterIntake = 5000;
        }
      });
    } else if (_currentSliderValueAge > 30 && _currentSliderValueAge <= 55) {
      setState(() {
        _currentSliderValueWaterIntake = _currentSliderValueWeight * 35;
        if (_currentSliderValueWaterIntake > 5000) {
          _currentSliderValueWaterIntake = 5000;
        }
      });
    } else if (_currentSliderValueAge > 55) {
      setState(() {
        _currentSliderValueWaterIntake = _currentSliderValueWeight * 30;
        if (_currentSliderValueWaterIntake > 5000) {
          _currentSliderValueWaterIntake = 5000;
        }
      });
    }
    storeWaterIntakeTarget();
  }

  Future<void> storeWaterIntakeTarget() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('waterIntakeTarget', _currentSliderValueWaterIntake);

    Provider.of<GeneralData>(context, listen: false)
        .storeWaterIntakeData(_currentSliderValueWaterIntake);

    Provider.of<GeneralData>(context, listen: false).calculateIntakePercent();
  }

  Future<void> getWaterIntakeTarget() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    _currentSliderValueWaterIntake = prefs.getInt('waterIntakeTarget');

    setState(() {
      if (_currentSliderValueWaterIntake == null) {
        _currentSliderValueWaterIntake = 2000;
      } else if (_currentSliderValueWaterIntake != null) {
        _currentSliderValueWaterIntake = prefs.getInt('waterIntakeTarget');
      }
    });
  }

  // Notification switch
  bool isSwitchedNotification = false;
  bool isSwitchedCalTarget = false;

  //get notification switch

  Future<void> getIsSwitchedNotification() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.getBool('isSwitchedNotification');

    setState(() {
      if (prefs.getBool('isSwitchedNotification') != null) {
        isSwitchedNotification = prefs.getBool('isSwitchedNotification');
      } else if (prefs.getBool('isSwitchedNotification') != null) {
        isSwitchedNotification = false;
      }
    });
  }

  Future<void> getIsSwitchedCalTarget() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.getBool('isSwitchedCalTarget');

    setState(() {
      if (prefs.getBool('isSwitchedCalTarget') != null) {
        isSwitchedCalTarget = prefs.getBool('isSwitchedCalTarget');
      } else if (prefs.getBool('isSwitchedCalTarget') != null) {
        isSwitchedCalTarget = false;
      }
    });
  }

  //store notification switch

  Future<void> storeIsSwitchedNotification() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isSwitchedNotification', isSwitchedNotification);
  }

  Future<void> storeIsSwitchedCalTarget() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isSwitchedCalTarget', isSwitchedCalTarget);
  }

  String _timeStart;
  String _timeEnd;
  int _intervalIndex = 0;
  int _languageIndex = 0;
  String _selectedLanguage = 'English';

  double _intervalHr;
  int _intervalMin;
  int _timeStartHr = 8;
  int _timeStartMin = 0;
  int _timeEndHr = 20;
  int _timeEndMin = 0;

  Widget _selectTimeStart(BuildContext context) {
    List<int> hours = List<int>.generate(24, (i) => i);
    List<Text> hoursItems = [];
    for (int hr in hours) {
      if (hr < 10) {
        hoursItems.add(Text('0$hr',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      } else {
        hoursItems.add(Text('$hr',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      }
    }

    List<int> minutes = List<int>.generate(60, (i) => i);
    List<Text> minutesItems = [];
    for (int mn in minutes) {
      if (mn < 10) {
        minutesItems.add(Text('0$mn',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      } else {
        minutesItems.add(Text('$mn',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      }
    }
    return Container(
      color: Color.fromRGBO(95, 103, 113, 1),
      child: Container(
        height: 0.35 * MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          vertical: 0.02 * MediaQuery.of(context).size.height,
          horizontal: 0.045 * MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Text(
                "Start time",
                style: kBodyTitle(context),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CupertinoPicker(
                        children: hoursItems,
                        diameterRatio: 1.02,
                        scrollController: FixedExtentScrollController(
                          initialItem: _timeStartHr,
                        ),
                        backgroundColor: Colors.white,
                        itemExtent: 31.0,
                        onSelectedItemChanged: (index) async {
                          _timeStartHr = hours[index];
                        }),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                        // vertical: 0.02 * MediaQuery.of(context).size.height,
                        horizontal: 0.08 * MediaQuery.of(context).size.width,
                      ),
                      child: Text(":")),
                  Expanded(
                    child: CupertinoPicker(
                        children: minutesItems,
                        diameterRatio: 1.02,
                        scrollController: FixedExtentScrollController(
                          initialItem: _timeStartMin,
                        ),
                        backgroundColor: Colors.white,
                        itemExtent: 31.0,
                        onSelectedItemChanged: (index) async {
                          _timeStartMin = minutes[index];
                        }),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 0.035 * MediaQuery.of(context).size.width,
                            color: Colors.black54)),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _timeStart = formatDate(
                            DateTime(0, 0, 0, _timeStartHr, _timeStartMin),
                            [HH, ':', nn, " "]).toString();
                        storeTimeStart();
                      });

                      Navigator.pop(context);
                    },
                    child: Text("Confirm",
                        style: TextStyle(
                            fontSize: 0.035 * MediaQuery.of(context).size.width,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> storeTimeStart() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('timeStart', _timeStart);
    prefs.setInt('_timeStartMin', _timeStartMin);
    prefs.setInt('_timeStartHr', _timeStartHr);

    if (isSwitchedNotification == true) {
      scheduleAlarm();
    }
  }

  Future<void> getTimeStart() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    _timeStart = prefs.getString('timeStart');
    setState(() {
      _timeStart == null
          ? _timeStart = '08:00 '
          : _timeStart = prefs.getString('timeStart');
    });
  }

  Widget _selectTimeEnd(BuildContext context) {
    List<int> hours = List<int>.generate(24, (i) => i);
    List<Text> hoursItems = [];
    for (int hr in hours) {
      if (hr < 10) {
        hoursItems.add(Text('0$hr',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      } else {
        hoursItems.add(Text('$hr',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      }
    }

    List<int> minutes = List<int>.generate(60, (i) => i);
    List<Text> minutesItems = [];
    for (int mn in minutes) {
      if (mn < 10) {
        minutesItems.add(Text('0$mn',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      } else {
        minutesItems.add(Text('$mn',
            style: kBodyTitle(context).copyWith(
                fontSize: 0.045 * MediaQuery.of(context).size.width)));
      }
    }
    return Container(
      color: Color.fromRGBO(95, 103, 113, 1),
      child: Container(
        height: 0.35 * MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          vertical: 0.02 * MediaQuery.of(context).size.height,
          horizontal: 0.045 * MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Text(
                "End time",
                style: kBodyTitle(context),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CupertinoPicker(
                        children: hoursItems,
                        diameterRatio: 1.02,
                        scrollController: FixedExtentScrollController(
                          initialItem: _timeEndHr,
                        ),
                        backgroundColor: Colors.white,
                        itemExtent: 31.0,
                        onSelectedItemChanged: (index) async {
                          _timeEndHr = hours[index];
                        }),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 0.08 * MediaQuery.of(context).size.width,
                      ),
                      child: Text(":")),
                  Expanded(
                    child: CupertinoPicker(
                        children: minutesItems,
                        diameterRatio: 1.02,
                        scrollController: FixedExtentScrollController(
                          initialItem: _timeEndMin,
                        ),
                        backgroundColor: Colors.white,
                        itemExtent: 31.0,
                        onSelectedItemChanged: (index) async {
                          _timeEndMin = minutes[index];
                        }),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 0.035 * MediaQuery.of(context).size.width,
                            color: Colors.black54)),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _timeEnd = formatDate(
                            DateTime(0, 0, 0, _timeEndHr, _timeEndMin),
                            [HH, ':', nn, " "]).toString();
                        storeTimeStart();
                      });

                      Navigator.pop(context);
                    },
                    child: Text("Confirm",
                        style: TextStyle(
                            fontSize: 0.035 * MediaQuery.of(context).size.width,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTimeEnd() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    _timeEnd = prefs.getString('timeEnd');

    setState(() {
      if (_timeEnd == null) {
        _timeEnd = "20:00 ";
      } else if (_timeEnd != null) {
        _timeEnd = prefs.getString('timeEnd');
      }
    });
  }

  Future<void> storeTimeEnd() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('timeEnd', _timeEnd);
    prefs.setInt('_timeEndMin', _timeEndMin);
    prefs.setInt('_timeEndHr', _timeEndHr);

    if (isSwitchedNotification == true) {
      scheduleAlarm();
    }
  }

  Widget _selectIntervalPicker() {
    const List<double> allInterval = [
      0.5,
      1.0,
      1.5,
      2.0,
      2.5,
      3.0,
      3.5,
      4.0,
      4.5,
      5.0,
    ];
    List<Text> intervalItems = [];
    for (double interval in allInterval) {
      intervalItems.add(Text('$interval',
          style: kBodyTitle(context)
              .copyWith(fontSize: 0.045 * MediaQuery.of(context).size.width)));
    }

    return Container(
      color: Color.fromRGBO(95, 103, 113, 1),
      child: Container(
        height: 0.35 * MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          vertical: 0.02 * MediaQuery.of(context).size.height,
          horizontal: 0.045 * MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Text(
                "Interval",
                style: kBodyTitle(context),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: CupertinoPicker(
                        diameterRatio: 1.02,
                        scrollController: FixedExtentScrollController(
                          initialItem: _intervalIndex,
                        ),
                        backgroundColor: Colors.white,
                        itemExtent: 31.0,
                        onSelectedItemChanged: (index) {
                          _intervalIndex = index;
                          _intervalHr = allInterval[index];
                        },
                        children: intervalItems,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    width: 0.30 * MediaQuery.of(context).size.width,
                    child: Text(
                      LocaleKeys.settings_hour.tr(),
                      style: kBodyTitle(context).copyWith(
                          fontSize: 0.04 * MediaQuery.of(context).size.width),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 0.035 * MediaQuery.of(context).size.width,
                            color: Colors.black54)),
                  ),
                  InkWell(
                    onTap: () async {
                      Future<SharedPreferences> _prefs =
                          SharedPreferences.getInstance();
                      final SharedPreferences prefs = await _prefs;
                      setState(() {
                        storeIntervalHr();

                        prefs.setInt('_intervalIndex', _intervalIndex);
                      });

                      Navigator.pop(context);
                    },
                    child: Text("Confirm",
                        style: TextStyle(
                            fontSize: 0.035 * MediaQuery.of(context).size.width,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getIntervalHr() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _intervalHr = prefs.getDouble('intervalHr');
    _intervalIndex = prefs.getInt('_intervalIndex');
    setState(
      () {
        if (_intervalHr == null) {
          _intervalHr = 1.0;
        } else if (_intervalHr != null) {
          _intervalHr = prefs.getDouble('intervalHr');
        }

        if (_intervalIndex == null) {
          _intervalIndex = 1;
        } else if (_intervalIndex != null) {
          _intervalIndex = prefs.getInt('_intervalIndex');
        }
      },
    );
  }

  //ios get interval picker

  Future<void> storeIntervalHr() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('intervalHr', _intervalHr);

    if (isSwitchedNotification == true) {
      scheduleAlarm();
    }
  }

  Future<void> storeLanguage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('language', _selectedLanguage);
  }

  Future<void> getLanguage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _selectedLanguage = prefs.getString('language');
    _languageIndex = prefs.getInt('_languageIndex');
    setState(
      () {
        if (_selectedLanguage == null) {
          _selectedLanguage = 'English';
        } else {
          _selectedLanguage = prefs.getString('language');
        }

        if (_languageIndex == null) {
          _languageIndex = 0;
        } else {
          _languageIndex = prefs.getInt('_languageIndex');
        }
      },
    );
  }

  void languageButtonPress(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tz.initializeTimeZones();
    var berlin = tz.getLocation('Europe/Amsterdam');
    tz.setLocalLocation(berlin);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_aquaman_notif');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    getTimeStart();
    getTimeEnd();
    getIntervalHr();
    getLanguage();
    getWaterIntakeTarget();
    getIsSwitchedNotification();
    getIsSwitchedCalTarget();
    getTimeStartEndHrMin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kSettingsScreenBackgroundColor),
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: false,
        title: Text(
          LocaleKeys.settings_setting.tr(),
          style: kScreenTitle(context),
        ),
        elevation: 0.0,
        backgroundColor: Color(kSettingsScreenBackgroundColor),
        iconTheme: IconThemeData(color: Color(kDeepGreyColor)),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 0.06 * MediaQuery.of(context).size.width,
            ),
            child: IconButton(
              onPressed: () {
                // Navigate to setting screen
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DailyRecords(),
                  ),
                );
              },
              icon: Icon(
                Icons.bar_chart_rounded,
                color: Color(kDeepGreyColor),
                size: 0.09 * MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.02 * MediaQuery.of(context).size.height,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
                horizontal: 0.08 * MediaQuery.of(context).size.width,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.015 * MediaQuery.of(context).size.height,
                horizontal: 0.065 * MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(1.0, 1.0))
                  ]),
              child: InkWell(
                onTap: () {
                  setState(() {
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => _selectLanguagePicker(),
                    // );
                    languageButtonPress(context);
                  });
                },
                child: Container(
                  height: 0.05 * MediaQuery.of(context).size.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.settings_language.tr(),
                        style: kBodyTitle(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.settings_selected_language.tr(),
                            style: kBodyText(context),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Icon(
                            Icons.edit_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
                horizontal: 0.08 * MediaQuery.of(context).size.width,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.015 * MediaQuery.of(context).size.height,
                horizontal: 0.065 * MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(1.0, 1.0))
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSwitchedNotification = !isSwitchedNotification;
                        storeIsSwitchedNotification();
                      });
                    },
                    child: Container(
                      height: 0.05 * MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.settings_notification.tr(),
                              style: kBodyTitle(context)),
                          Switch(
                            activeColor: Color(kBlueColor),
                            value: isSwitchedNotification,
                            onChanged: (newValue) {
                              setState(() {
                                isSwitchedNotification = newValue;
                                storeIsSwitchedNotification();
                                if (isSwitchedNotification == true) {
                                  scheduleAlarm();
                                } else {
                                  flutterLocalNotificationsPlugin.cancelAll();
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isSwitchedNotification,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => _selectTimeStart(context),
                              );
                            },
                            child: Container(
                              height:
                                  0.045 * MediaQuery.of(context).size.height,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LocaleKeys.settings_start.tr(),
                                      style: kBodyText(context)),
                                  Row(
                                    children: [
                                      Text(
                                        '$_timeStart',
                                        style: kBodyText(context),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Icon(
                                        Icons.edit_rounded,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      _selectTimeEnd(context));
                            },
                            child: Container(
                              height:
                                  0.045 * MediaQuery.of(context).size.height,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.settings_end.tr(),
                                    style: kBodyText(context),
                                  ),
                                  Row(children: [
                                    Text(
                                      '$_timeEnd',
                                      style: kBodyText(context),
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Icon(
                                      Icons.edit_rounded,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => _selectIntervalPicker(),
                              );
                            },
                            child: Container(
                              height:
                                  0.045 * MediaQuery.of(context).size.height,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.settings_interval.tr(),
                                    style: kBodyText(context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "$_intervalHr ${LocaleKeys.settings_hour.tr()}",
                                        style: kBodyText(context),
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Icon(
                                        Icons.edit_rounded,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            // visible: notificationNumber < 0,
                            visible: showErrorNotification,
                            child: SizedBox(
                              height:
                                  0.025 * MediaQuery.of(context).size.height,
                            ),
                          ),
                          Visibility(
                            visible: showErrorNotification,
                            child: Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.symmetric(horizontal: 40.0),
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    0.015 * MediaQuery.of(context).size.width,
                                vertical:
                                    0.008 * MediaQuery.of(context).size.height,
                              ),
                              // height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.red[500],
                                ),
                              ),
                              child: Text(
                                  LocaleKeys.settings_no_notif_being_generated
                                      .tr(),
                                  style: kBodyText(context)
                                      .copyWith(color: Colors.red[500])
                                  // TextStyle(color: Colors.red[500]),
                                  ),
                            ),
                          ),
                          Visibility(
                            visible: showErrorNotification,
                            child: SizedBox(
                              height: 0.02 * MediaQuery.of(context).size.height,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0.02 * MediaQuery.of(context).size.height,
                  horizontal: 0.08 * MediaQuery.of(context).size.width,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 0.015 * MediaQuery.of(context).size.height,
                  horizontal: 0.065 * MediaQuery.of(context).size.width,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(1.0, 1.0))
                    ]),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      height: 0.05 * MediaQuery.of(context).size.height,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                              LocaleKeys.settings_daily_water_intake.tr(),
                              style: kBodyTitle(context))),
                    ),
                    Container(
                      height: 0.045 * MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                  LocaleKeys.settings_set_daily_water_intake
                                      .tr(),
                                  style: kBodyText(context))),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 100.0,
                            child: Text(
                              '$_currentSliderValueWaterIntake ml',
                              style: kBodyText(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: SliderTheme(
                        data: SliderThemeData(
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 18.0),
                          trackHeight: 1,
                        ),
                        child: Slider(
                          activeColor: Color(kBlueColor),
                          value: _currentSliderValueWaterIntake.toDouble(),
                          min: 500,
                          max: 5000,
                          divisions: 90,
                          label: _currentSliderValueWaterIntake.toString(),
                          onChanged: (value) {
                            setState(() {
                              _currentSliderValueWaterIntake = value.round();
                              storeWaterIntakeTarget();
                            });
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSwitchedCalTarget = !isSwitchedCalTarget;
                          storeIsSwitchedCalTarget();
                        });
                      },
                      child: Container(
                        height: 0.045 * MediaQuery.of(context).size.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                LocaleKeys
                                    .settings_calculate_water_intake_target
                                    .tr(),
                                style: kBodyText(context)),
                            isSwitchedCalTarget
                                ? Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    size: 20.0,
                                    color: Color(kGreyColor),
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 20.0,
                                    color: Color(kGreyColor),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSwitchedCalTarget,
                      child: Container(
                        height: 0.04 * MediaQuery.of(context).size.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(LocaleKeys.settings_age.tr(),
                                style: kBodyText(context)
                                    .copyWith(color: Colors.black38)),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 100.0,
                              child: Text(
                                "$_currentSliderValueAge ${LocaleKeys.settings_years_old.tr()}",
                                style: kBodyText(context)
                                    .copyWith(color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSwitchedCalTarget,
                      child: Container(
                        child: SliderTheme(
                          data: SliderThemeData(
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 18.0),
                            trackHeight: 1,
                          ),
                          child: Slider(
                            activeColor: Color(kWaveDeepBlueColor),
                            value: _currentSliderValueAge.toDouble(),
                            min: 10,
                            max: 100,
                            divisions: 90,
                            label: _currentSliderValueAge.toString(),
                            onChanged: (value) {
                              setState(() {
                                _currentSliderValueAge = value.round();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSwitchedCalTarget,
                      child: Container(
                        height: 0.04 * MediaQuery.of(context).size.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(LocaleKeys.settings_weight.tr(),
                                style: kBodyText(context)
                                    .copyWith(color: Colors.black38)),
                            Text(
                              "$_currentSliderValueWeight kg",
                              style: kBodyText(context)
                                  .copyWith(color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSwitchedCalTarget,
                      child: Container(
                        child: SliderTheme(
                          data: SliderThemeData(
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 18.0),
                            trackHeight: 1,
                          ),
                          child: Slider(
                            activeColor: Color(kWaveDeepBlueColor),
                            autofocus: true,
                            value: _currentSliderValueWeight.toDouble(),
                            min: 35,
                            max: 200,
                            divisions: 165,
                            label: _currentSliderValueWeight.toString(),
                            onChanged: (value) {
                              setState(() {
                                _currentSliderValueWeight = value.round();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isSwitchedCalTarget,
                        child: SizedBox(
                            height: 0.01 * MediaQuery.of(context).size.height)),
                    Visibility(
                      visible: isSwitchedCalTarget,
                      child: Container(
                        // padding: EdgeInsets.only(
                        //   right: 0.25 * MediaQuery.of(context).size.width,
                        // ),
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                calculateWaterIntakeTarget();
                              });
                            },
                            elevation: 0.0,
                            color: Color(kBlueColor),
                            highlightColor: Colors.white,
                            highlightElevation: 1.0,
                            textColor: Colors.black54,
                            shape: RoundedRectangleBorder(
                              // side: BorderSide(
                              //     color: Color(kLightBlueColor), width: 0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Text(LocaleKeys.settings_calculate.tr(),
                                style: TextStyle(
                                    fontSize: 0.035 *
                                        MediaQuery.of(context).size.width,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white))),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
