import 'package:flutter/material.dart';
import 'package:aquaman/Widgets/waterWave2.dart';
import 'package:aquaman/Widgets/waterWave1.dart';
import 'package:aquaman/Widgets/ruler.dart';
import 'package:aquaman/Widgets/appTitle.dart';
import 'package:aquaman/Widgets/settingsButtons.dart';
import 'package:aquaman/Widgets/floatingButtons.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WaterScreen extends StatefulWidget {
  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  DateTime latestUpdatedTime;

  Future<void> cleanDataDaily() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    final DateTime now = DateTime.now();

    if (prefs.getString('latestUpdatedTime') != null) {
      latestUpdatedTime = DateTime.parse(prefs.getString('latestUpdatedTime'));

      if (latestUpdatedTime
          .isBefore(DateTime(now.year, now.month, now.day, 0, 0))) {
        Provider.of<GeneralData>(context, listen: false).removeDataDaily();
      }
    }
  }

  Future<void> storeDailyRecords() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final DateTime now = DateTime.now();

    if (prefs.getString('latestUpdatedTime') != null) {
      latestUpdatedTime = DateTime.parse(prefs.getString('latestUpdatedTime'));

      if (DateTime(latestUpdatedTime.year, latestUpdatedTime.month,
              latestUpdatedTime.day + 1, 0, 0)
          .isBefore(now)) {
        int dayDifference = (now
                    .difference(DateTime(
                        latestUpdatedTime.year,
                        latestUpdatedTime.month,
                        latestUpdatedTime.day + 1,
                        0,
                        0))
                    .inHours /
                24)
            .ceil();

        Provider.of<GeneralData>(context, listen: false)
            .storeDailyWaterIntakeTarget(dayDifference);
        Provider.of<GeneralData>(context, listen: false)
            .calculatedTargetReachedDay();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    storeDailyRecords();

    cleanDataDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(children: [
          WaterWave1(),
          WaterWave2(),
          AppTitleV1(),
          Ruler(),
          SettingsButtons(),
          FloatingButton(),
        ]),
      ),
    );
  }
}
